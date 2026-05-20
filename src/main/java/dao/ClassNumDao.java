package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.ClassNum;
import bean.School;

public class ClassNumDao extends Dao {

    // 主キーに該当するクラス情報を1件取得します
    public ClassNum get(String class_num, School school) throws Exception {
        ClassNum classNum = null;
        String sql = "SELECT * FROM class_num WHERE TRIM(class_num) = ? AND TRIM(school_cd) = ?";

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, class_num != null ? class_num.trim() : "");
            statement.setString(2, school.getCd() != null ? school.getCd().trim() : "");

            try (ResultSet rSet = statement.executeQuery()) {
                if (rSet.next()) {
                    classNum = new ClassNum();
                    classNum.setClass_num(rSet.getString("class_num").trim());

                    SchoolDao sDao = new SchoolDao();
                    classNum.setSchool(sDao.get(rSet.getString("school_cd").trim()));
                }
            }

        } catch (Exception e) {
            throw e;
        }

        return classNum;
    }

    // 学校コードに紐づくクラス番号の一覧を取得します
    public List<String> filter(School school) throws Exception {
        List<String> list = new ArrayList<>();
        String sql = "SELECT class_num FROM class_num WHERE TRIM(school_cd) = ? ORDER BY class_num";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, school.getCd() != null ? school.getCd().trim() : "");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(rs.getString("class_num").trim());
                }
            }
        } catch (Exception e) {
            throw e;
        }
        return list;
    }

    // 新規追加のためのインサート文を実行します
    public boolean insert(ClassNum classNum) throws Exception {
        String sql = "INSERT INTO class_num (class_num, school_cd) VALUES (?, ?)";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, classNum.getClass_num() != null ? classNum.getClass_num().trim() : "");
            ps.setString(2, classNum.getSchool().getCd() != null ? classNum.getSchool().getCd().trim() : "");

            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            throw e;
        }
    }

    // 新規登録画面（Action）から呼び出される単一引数の保存メソッドです
    public boolean save(ClassNum classNum) throws Exception {
        // データベースに同一キーのデータが存在するか確認します
        ClassNum exists = get(classNum.getClass_num(), classNum.getSchool());
        
        if (exists == null) {
            // 存在しない場合は新規登録処理を実行します
            return insert(classNum);
        } else {
            // すでに存在する場合は何もせず確定処理とします
            return true;
        }
    }

    // クラス番号変更（旧番号から新番号への更新処理）を実行します
    public boolean save(ClassNum classNum, String newClassNum) throws Exception {
        String sql = """
            UPDATE class_num
               SET class_num = ?
             WHERE TRIM(class_num) = ?
               AND TRIM(school_cd) = ?
            """;

        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, newClassNum != null ? newClassNum.trim() : "");
            ps.setString(2, classNum.getClass_num().trim());
            ps.setString(3, classNum.getSchool().getCd().trim());

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            throw e;
        }
    }

    // 対象のクラス情報を物理削除します
    public boolean delete(ClassNum classNum) throws Exception {
        String sql = "DELETE FROM class_num WHERE TRIM(school_cd) = ? AND TRIM(class_num) = ?";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, classNum.getSchool().getCd().trim());
            ps.setString(2, classNum.getClass_num().trim());

            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            throw e;
        }
    }
}