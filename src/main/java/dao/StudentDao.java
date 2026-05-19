package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.School;
import bean.Student;

public class StudentDao extends Dao {

    private final String baseSql = """
        SELECT
            NO,
            NAME,
            ENT_YEAR,
            CLASS_NUM,
            IS_ATTEND,
            SCHOOL_CD
        FROM STUDENT
        """;

    // 1件取得 (TRIM対応)
    public Student get(String no) {
        Student student = null;
        String sql = "SELECT * FROM STUDENT WHERE TRIM(NO) = ?";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, no != null ? no.trim() : "");
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

    // 入学年度リスト取得 (TRIM対応)
    public List<Integer> filterEntYear(School school) {
        List<Integer> list = new ArrayList<>();
        String sql = "SELECT DISTINCT ENT_YEAR FROM STUDENT WHERE TRIM(SCHOOL_CD) = ? ORDER BY ENT_YEAR";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, school.getCd() != null ? school.getCd().trim() : "");
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

    // 学生の動的絞り込み検索（メイン：引数4つ版）
    public List<Student> filter(School school, int entYear, String classNum, boolean isAttend) {
        List<Student> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT * FROM STUDENT WHERE TRIM(SCHOOL_CD) = ?");
        
        if (entYear > 0) {
            sql.append(" AND ENT_YEAR = ?");
        }
        if (classNum != null && !classNum.isEmpty()) {
            sql.append(" AND TRIM(CLASS_NUM) = ?");
        }
        if (isAttend) {
            sql.append(" AND IS_ATTEND = true");
        }
        sql.append(" ORDER BY NO");

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {
            
            int i = 1;
            ps.setString(i++, school.getCd() != null ? school.getCd().trim() : "");
            
            if (entYear > 0) {
                ps.setInt(i++, entYear);
            }
            if (classNum != null && !classNum.isEmpty()) {
                ps.setString(i++, classNum.trim());
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

    // StudentListAction用：互換オーバーロード（引数3つ）
    public List<Student> filter(School school, int entYear, boolean isAttend) {
        return filter(school, entYear, null, isAttend);
    }

    // StudentListAction用：互換オーバーロード（引数2つ）
    public List<Student> filter(School school, boolean isAttend) {
        return filter(school, 0, null, isAttend);
    }

    // 保存・更新
    public boolean save(Student student) {
        try (Connection con = getConnection()) {
            Student existing = get(student.getNo());
            if (existing != null) {
                String updateSql = "UPDATE STUDENT SET NAME=?, ENT_YEAR=?, CLASS_NUM=?, IS_ATTEND=? WHERE TRIM(NO)=?";
                try (PreparedStatement ups = con.prepareStatement(updateSql)) {
                    ups.setString(1, student.getName());
                    ups.setInt(2, student.getEntYear());
                    ups.setString(3, student.getClassNum());
                    ups.setBoolean(4, student.isAttend());
                    ups.setString(5, student.getNo().trim());
                    return ups.executeUpdate() == 1;
                }
            } else {
                String insertSql = "INSERT INTO STUDENT(NO, NAME, ENT_YEAR, CLASS_NUM, IS_ATTEND, SCHOOL_CD) VALUES (?, ?, ?, ?, ?, ?)";
                try (PreparedStatement ips = con.prepareStatement(insertSql)) {
                    ips.setString(1, student.getNo());
                    ips.setString(2, student.getName());
                    ips.setInt(3, student.getEntYear());
                    ips.setString(4, student.getClassNum());
                    ips.setBoolean(5, student.isAttend());
                    ips.setString(6, student.getSchool().getCd());
                    return ips.executeUpdate() == 1;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private Student mapRow(ResultSet rs) throws Exception {
        Student student = new Student();
        student.setNo(rs.getString("NO") != null ? rs.getString("NO").trim() : "");
        student.setName(rs.getString("NAME"));
        student.setEntYear(rs.getInt("ENT_YEAR"));
        String cNum = rs.getString("CLASS_NUM");
        student.setClassNum(cNum != null ? cNum.trim() : "");
        student.setAttend(rs.getBoolean("IS_ATTEND"));

        School school = new School();
        school.setCd(rs.getString("SCHOOL_CD") != null ? rs.getString("SCHOOL_CD").trim() : "");
        student.setSchool(school);
        return student;
    }
}