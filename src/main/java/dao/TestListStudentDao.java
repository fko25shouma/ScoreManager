package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Student;
import bean.TestListStudent;

public class TestListStudentDao extends Dao {

    private final String baseSql = """
        SELECT
            T.SUBJECT_CD,
            S.NAME AS SUBJECT_NAME,
            T.NO,
            T.POINT
        FROM TEST T
        JOIN SUBJECT S
          ON T.SUBJECT_CD = S.CD
         AND T.SCHOOL_CD = S.SCHOOL_CD
        WHERE T.STUDENT_NO = ?
          AND T.SCHOOL_CD = ?
        ORDER BY T.SUBJECT_CD, T.NO
        """;

    public List<TestListStudent> filter(Student student) {
        List<TestListStudent> list = new ArrayList<>();

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(baseSql)) {

            ps.setString(1, student.getNo());
            ps.setString(2, student.getSchool().getCd());

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    TestListStudent t = new TestListStudent();
                    t.setSubjectCd(rs.getString("SUBJECT_CD"));
                    t.setSubjectName(rs.getString("SUBJECT_NAME"));
                    t.setNum(rs.getInt("NO"));
                    t.setPoint(rs.getInt("POINT"));
                    list.add(t);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
