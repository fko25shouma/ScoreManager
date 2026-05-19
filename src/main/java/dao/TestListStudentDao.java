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
          ON TRIM(T.SUBJECT_CD) = TRIM(S.CD)
         AND TRIM(T.SCHOOL_CD) = TRIM(S.SCHOOL_CD)
        WHERE TRIM(T.STUDENT_NO) = ?
          AND TRIM(T.SCHOOL_CD) = ?
        ORDER BY T.SUBJECT_CD, T.NO
        """;

    public List<TestListStudent> filter(Student student) {
        // ★過去の重複ゴミデータを1つにまとめるための Map を用意
        java.util.Map<String, TestListStudent> map = new java.util.LinkedHashMap<>();

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(baseSql)) {

            ps.setString(1, student.getNo() != null ? student.getNo().trim() : "");
            ps.setString(2, student.getSchool().getCd() != null ? student.getSchool().getCd().trim() : "");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    TestListStudent t = new TestListStudent();
                    t.setSubjectCd(rs.getString("SUBJECT_CD").trim());
                    t.setSubjectName(rs.getString("SUBJECT_NAME"));
                    t.setNum(rs.getInt("NO"));
                    t.setPoint(rs.getInt("POINT"));
                    
                    // 「科目コード_回数」という合鍵を作る（例："A01_1"）
                    String key = t.getSubjectCd() + "_" + t.getNum();
                    
                    // ★同じ科目・回数のデータが来たら、新しい方で上書きして1つにまとめる
                    map.put(key, t);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 重複が排除された綺麗なリストを返却する
        return new ArrayList<>(map.values());
    }
}