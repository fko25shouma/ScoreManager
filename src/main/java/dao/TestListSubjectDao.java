package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import bean.School;
import bean.Subject;
import bean.TestListSubject;

public class TestListSubjectDao extends Dao {

    private final String baseSql = """
        SELECT
            ST.NO AS STUDENT_NO,
            ST.NAME AS STUDENT_NAME,
            ST.ENT_YEAR,
            ST.CLASS_NUM,
            T.NO AS TEST_NO,
            T.POINT
        FROM TEST T
        JOIN STUDENT ST
          ON T.STUDENT_NO = ST.NO
         AND T.SCHOOL_CD = ST.SCHOOL_CD
        WHERE T.SCHOOL_CD = ?
          AND T.SUBJECT_CD = ?
          AND ST.ENT_YEAR = ?
          AND ST.CLASS_NUM = ?
        ORDER BY ST.NO, T.NO
        """;

    public List<TestListSubject> filter(int entYear, String classNum, Subject subject, School school) {
        List<TestListSubject> list = new ArrayList<>();

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(baseSql)) {

            ps.setString(1, school.getCd());
            ps.setString(2, subject.getCd());
            ps.setInt(3, entYear);
            ps.setString(4, classNum);

            try (ResultSet rs = ps.executeQuery()) {

                Map<String, TestListSubject> map = new LinkedHashMap<>();

                while (rs.next()) {
                    String studentNo = rs.getString("STUDENT_NO");

                    TestListSubject tls = map.get(studentNo);
                    if (tls == null) {
                        tls = new TestListSubject();
                        tls.setStudentNo(studentNo);
                        tls.setStudentName(rs.getString("STUDENT_NAME"));
                        tls.setEntYear(rs.getInt("ENT_YEAR"));
                        tls.setClassNum(rs.getString("CLASS_NUM"));
                        tls.setPoints(new LinkedHashMap<>());
                        map.put(studentNo, tls);
                    }

                    int testNo = rs.getInt("TEST_NO");
                    int point = rs.getInt("POINT");

                    tls.getPoints().put(testNo, point);
                }

                list.addAll(map.values());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
