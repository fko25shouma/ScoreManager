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

    // ▼ 1件取得
    public Student get(String no) {
        Student student = null;

        String sql = baseSql + " WHERE NO = ?";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

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

    // ▼ ENT_YEAR の一覧（distinct）
    public List<Integer> filterEntYear(School school) {

        List<Integer> list = new ArrayList<>();

        String sql = """
            SELECT DISTINCT ENT_YEAR
            FROM STUDENT
            WHERE SCHOOL_CD = ?
            ORDER BY ENT_YEAR
            """;

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

    // ▼ 年度＋クラス＋在籍
    public List<Student> filter(School school, int entYear, String classNum, boolean isAttend) {

        List<Student> list = new ArrayList<>();

        String sql = baseSql + """
            WHERE SCHOOL_CD = ?
              AND ENT_YEAR = ?
              AND CLASS_NUM = ?
              AND IS_ATTEND = ?
            ORDER BY NO
            """;

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, school.getCd());
            ps.setInt(2, entYear);
            ps.setString(3, classNum);
            ps.setBoolean(4, isAttend);

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

    // ▼ 年度のみ
    public List<Student> filter(School school, int entYear, boolean isAttend) {

        List<Student> list = new ArrayList<>();

        String sql = baseSql + """
            WHERE SCHOOL_CD = ?
              AND ENT_YEAR = ?
              AND IS_ATTEND = ?
            ORDER BY NO
            """;

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, school.getCd());
            ps.setInt(2, entYear);
            ps.setBoolean(3, isAttend);

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

    // ▼ クラスのみ
    public List<Student> filter(School school, String classNum, boolean isAttend) {

        List<Student> list = new ArrayList<>();

        String sql = baseSql + """
            WHERE SCHOOL_CD = ?
              AND CLASS_NUM = ?
              AND IS_ATTEND = ?
            ORDER BY NO
            """;

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, school.getCd());
            ps.setString(2, classNum);
            ps.setBoolean(3, isAttend);

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

    // ▼ 在籍のみ（全件）
    public List<Student> filter(School school, boolean isAttend) {

        List<Student> list = new ArrayList<>();

        String sql = baseSql + """
            WHERE SCHOOL_CD = ?
              AND IS_ATTEND = ?
            ORDER BY NO
            """;

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, school.getCd());
            ps.setBoolean(2, isAttend);

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

    // ▼ INSERT or UPDATE
    public boolean save(Student student) {

        try (Connection con = getConnection()) {

            // 既存チェック
            String checkSql = "SELECT COUNT(*) FROM STUDENT WHERE NO = ?";

            try (PreparedStatement ps = con.prepareStatement(checkSql)) {
                ps.setString(1, student.getNo());

                try (ResultSet rs = ps.executeQuery()) {
                    rs.next();
                    int count = rs.getInt(1);

                    if (count > 0) {
                        // UPDATE
                        String updateSql = """
                            UPDATE STUDENT
                               SET NAME = ?,
                                   ENT_YEAR = ?,
                                   CLASS_NUM = ?,
                                   IS_ATTEND = ?,
                                   SCHOOL_CD = ?
                             WHERE NO = ?
                            """;

                        try (PreparedStatement ups = con.prepareStatement(updateSql)) {
                            ups.setString(1, student.getName());
                            ups.setInt(2, student.getEntYear());
                            ups.setString(3, student.getClassNum());
                            ups.setBoolean(4, student.isAttend());
                            ups.setString(5, student.getSchool().getCd());
                            ups.setString(6, student.getNo());

                            return ups.executeUpdate() == 1;
                        }

                    } else {
                        // INSERT
                        String insertSql = """
                            INSERT INTO STUDENT(
                                NO,
                                NAME,
                                ENT_YEAR,
                                CLASS_NUM,
                                IS_ATTEND,
                                SCHOOL_CD
                            ) VALUES (?, ?, ?, ?, ?, ?)
                            """;

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
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ▼ Student オブジェクト生成（共通化）
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
