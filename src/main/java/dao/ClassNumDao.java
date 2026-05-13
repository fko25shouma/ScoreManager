package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.ClassNum;
import bean.School;

public class ClassNumDao extends Dao {

    // ▼ 1件取得
    public ClassNum get(String class_num, School school) throws Exception {

        ClassNum classNum = null;

        String sql = "SELECT * FROM class_num WHERE class_num = ? AND school_cd = ?";

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, class_num);
            statement.setString(2, school.getCd());

            try (ResultSet rSet = statement.executeQuery()) {
                if (rSet.next()) {
                    classNum = new ClassNum();
                    classNum.setClass_num(rSet.getString("class_num"));

                    SchoolDao sDao = new SchoolDao();
                    classNum.setSchool(sDao.get(rSet.getString("school_cd")));
                }
            }

        } catch (Exception e) {
            throw e;
        }

        return classNum;
    }

    // ▼ クラス番号一覧
    public List<String> filter(School school) throws Exception {

        List<String> list = new ArrayList<>();

        String sql = "SELECT class_num FROM class_num WHERE school_cd=? ORDER BY class_num";

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, school.getCd());

            try (ResultSet rSet = statement.executeQuery()) {
                while (rSet.next()) {
                    list.add(rSet.getString("class_num"));
                }
            }

        } catch (Exception e) {
            throw e;
        }

        return list;
    }

    // ▼ 新規登録
    public boolean save(ClassNum classNum) throws Exception {

        String sql = """
            INSERT INTO class_num(class_num, school_cd)
            VALUES (?, ?)
            """;

        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, classNum.getClass_num());
            ps.setString(2, classNum.getSchool().getCd());

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            throw e;
        }
    }

    // ▼ クラス番号変更（旧番号 → 新番号）
    public boolean save(ClassNum classNum, String newClassNum) throws Exception {

        String sql = """
            UPDATE class_num
               SET class_num = ?
             WHERE class_num = ?
               AND school_cd = ?
            """;

        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, newClassNum);
            ps.setString(2, classNum.getClass_num());
            ps.setString(3, classNum.getSchool().getCd());

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            throw e;
        }
    }
    public boolean delete(ClassNum class_num) {
        String sql = """
            DELETE FROM CLASSNUM
            WHERE SCHOOL_CD = ? AND CD = ?
            """;

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, class_num.getSchool().getCd());
            ps.setString(2, class_num.getClass_num());

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

}
