package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import bean.School;
import bean.Student;
import bean.Subject;
import bean.Test;

public class TestDao extends Dao {

    private final String baseSql = """
        SELECT
            STUDENT_NO,
            SUBJECT_CD,
            SCHOOL_CD,
            NO,
            POINT,
            CLASS_NUM
        FROM TEST
        """;

    public Test get(Student student, Subject subject, School school, int no) {
        Test test = null;

        String sql = baseSql + """
            WHERE STUDENT_NO = ?
              AND SUBJECT_CD = ?
              AND SCHOOL_CD = ?
              AND NO = ?
            """;

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, student.getNo());
            ps.setString(2, subject.getCd());
            ps.setString(3, school.getCd());
            ps.setInt(4, no);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    test = new Test();
                    test.setStudent(student);
                    test.setSubject(subject);
                    test.setSchool(school);
                    test.setNo(rs.getInt("NO"));
                    test.setPoint(rs.getInt("POINT"));
                    test.setClassNum(rs.getString("CLASS_NUM"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return test;
    }

    public boolean save(List<Test> list) {
        try (Connection con = getConnection()) {
            con.setAutoCommit(false);

            for (Test t : list) {
                if (!save(t, con)) {
                    con.rollback();
                    return false;
                }
            }

            con.commit();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean save(Test test, Connection con) {
        String sql = """
            INSERT INTO TEST(
                STUDENT_NO,
                SUBJECT_CD,
                SCHOOL_CD,
                NO,
                POINT,
                CLASS_NUM
            ) VALUES (?, ?, ?, ?, ?, ?)
            """;

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, test.getStudent().getNo());
            ps.setString(2, test.getSubject().getCd());
            ps.setString(3, test.getSchool().getCd());
            ps.setInt(4, test.getNo());
            ps.setInt(5, test.getPoint());
            ps.setString(6, test.getClassNum());

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

	public List<Test> list(List<Student> studentList, Subject subject, School school, int num) {
		// TODO 自動生成されたメソッド・スタブ
		return null;
	}
}

