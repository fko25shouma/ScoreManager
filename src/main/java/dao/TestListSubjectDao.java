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

    // STUDENTをベースにしたLEFT JOINに変更し、全員を確実に表示.
    // 合わせて、CHAR型の空白対策（TRIM）も徹底的に組み込みました。
    private final String baseSql = """
        SELECT
            ST.NO AS STUDENT_NO,
            ST.NAME AS STUDENT_NAME,
            ST.ENT_YEAR,
            ST.CLASS_NUM,
            T.NO AS TEST_NO,
            T.POINT
        FROM STUDENT ST
        LEFT JOIN TEST T
          ON TRIM(ST.NO) = TRIM(T.STUDENT_NO)
         AND TRIM(ST.SCHOOL_CD) = TRIM(T.SCHOOL_CD)
         AND TRIM(T.SUBJECT_CD) = ?
        WHERE TRIM(ST.SCHOOL_CD) = ?
          AND ST.ENT_YEAR = ?
          AND TRIM(ST.CLASS_NUM) = ?
          AND ST.IS_ATTEND = TRUE
        ORDER BY ST.NO, T.NO
        """;

    public List<TestListSubject> filter(int entYear, String classNum, Subject subject, School school) {
        List<TestListSubject> list = new ArrayList<>();

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(baseSql)) {

            // SQLの「?」の順番に合わせてセット（空白除去も徹底）
            ps.setString(1, subject.getCd().trim());
            ps.setString(2, school.getCd().trim());
            ps.setInt(3, entYear);
            ps.setString(4, classNum.trim());

            try (ResultSet rs = ps.executeQuery()) {
                Map<String, TestListSubject> map = new LinkedHashMap<>();

                while (rs.next()) {
                    String studentNo = rs.getString("STUDENT_NO").trim();

                    // まだリストにいない学生なら、新しく作成してMapに入れる
                    TestListSubject tls = map.get(studentNo);
                    if (tls == null) {
                        tls = new TestListSubject();
                        tls.setStudentNo(studentNo);
                        tls.setStudentName(rs.getString("STUDENT_NAME"));
                        tls.setEntYear(rs.getInt("ENT_YEAR"));
                        tls.setClassNum(rs.getString("CLASS_NUM") != null ? rs.getString("CLASS_NUM").trim() : "");
                        tls.setPoints(new LinkedHashMap<>());
                        map.put(studentNo, tls);
                    }

                    // ▼ LEFT JOIN なので、テストデータがない（未受験の）場合はスキップする
                    int testNo = rs.getInt("TEST_NO");
                    if (!rs.wasNull()) {
                        int point = rs.getInt("POINT");
                        // マップの特性を利用して、古いゴミデータがあれば最新の点数で上書きして綺麗にする
                        tls.getPoints().put(testNo, point);
                    }
                }

                // 綺麗にまとまった学生リストをList型に変換
                list.addAll(map.values());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}