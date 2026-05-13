package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.School;
import bean.Student;

public class StudentDao extends Dao {

    // 1件取得
    public Student get(String no) {
        Student student = null;
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM STUDENT WHERE NO = ?")) {
            ps.setString(1, no);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    student = mapRow(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return student;
    }

    // 入学年度リスト取得
    public List<Integer> filterEntYear(School school) {
        List<Integer> list = new ArrayList<>();
        String sql = "SELECT DISTINCT ENT_YEAR FROM STUDENT WHERE SCHOOL_CD = ? ORDER BY ENT_YEAR";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, school.getCd());
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(rs.getInt("ENT_YEAR"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * 学生の絞り込み検索 (Actionから呼ばれるメインのメソッド)
     */
    public List<Student> filter(School school, int entYear, String classNum, boolean isAttend) {
        List<Student> list = new ArrayList<>();
        
        // 基本となるSQL
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT * FROM STUDENT WHERE SCHOOL_CD = ?");
        
        // 条件に応じてSQLを動的に組み立てる
        if (entYear > 0) {
            sql.append(" AND ENT_YEAR = ?");
        }
        // classNum が null または 空文字でない場合のみ条件に追加
        if (classNum != null && !classNum.isEmpty()) {
            sql.append(" AND CLASS_NUM = ?");
        }
        if (isAttend) {
            sql.append(" AND IS_ATTEND = true");
        }
        sql.append(" ORDER BY NO");

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {
            
            int i = 1;
            ps.setString(i++, school.getCd());
            
            if (entYear > 0) {
                ps.setInt(i++, entYear);
            }
            if (classNum != null && !classNum.isEmpty()) {
                ps.setString(i++, classNum);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * 【重要】StudentListActionでエラーが出ている場合、この「引数が3つのメソッド」を
     * 追加することでエラーが消えます。
     */
    public List<Student> filter(School school, int entYear, boolean isAttend) {
        // 第3引数(classNum)に null を渡して、上の4つ引数メソッドを使い回す
        return filter(school, entYear, null, isAttend);
    }

    /**
     * 【重要】StudentListActionでエラーが出ている場合、この「引数が2つのメソッド」を
     * 追加することでエラーが消えます。
     */
    public List<Student> filter(School school, boolean isAttend) {
        // entYearに0, classNumにnullを渡して、上の4つ引数メソッドを使い回す
        return filter(school, 0, null, isAttend);
    }

    private Student mapRow(ResultSet rs) throws Exception {
        Student student = new Student();
        student.setNo(rs.getString("NO"));
        student.setName(rs.getString("NAME"));
        student.setEntYear(rs.getInt("ENT_YEAR"));
        student.setClassNum(rs.getString("CLASS_NUM"));
        student.setAttend(rs.getBoolean("IS_ATTEND"));
        School school = new School();
        school.setCd(rs.getString("SCHOOL_CD"));
        student.setSchool(school);
        return student;
    }
}