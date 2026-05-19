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

    /**
     * ▼ 1件取得
     * データベース内に空白問題による重複データ（ゴミデータ）が残っていても、
     * 点数が登録されている正しいレコード（54点など）を確実に優先して取得するよう改良しました。
     */
    public Test get(Student student, Subject subject, School school, int no) {
        Test test = null;
        String sql = baseSql + """
            WHERE TRIM(STUDENT_NO) = ?
              AND TRIM(SUBJECT_CD) = ?
              AND TRIM(SCHOOL_CD) = ?
              AND NO = ?
            """;

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, student.getNo().trim());
            ps.setString(2, subject.getCd().trim());
            ps.setString(3, school.getCd().trim());
            ps.setInt(4, no);

            try (ResultSet rs = ps.executeQuery()) {
                // ★ if ではなく while で全てのヒットデータをチェックします
                while (rs.next()) {
                    int point = rs.getInt("POINT");
                    
                    // まだデータを未取得の場合、または、新しく見つかったデータの点数が0より大きい（有効な）場合上書き
                    if (test == null || point > 0) {
                        test = new Test();
                        test.setStudent(student);
                        test.setSubject(subject);
                        test.setSchool(school);
                        test.setNo(rs.getInt("NO"));
                        test.setPoint(point);
                        String cNum = rs.getString("CLASS_NUM");
                        test.setClassNum(cNum != null ? cNum.trim() : "");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return test;
    }

    // ▼ 全件保存（コミット・ロールバック制御）
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

    // ▼ 1件保存（MERGE文による登録・更新）
    public boolean save(Test test, Connection con) {
        String sql = """
            MERGE INTO TEST(STUDENT_NO, SUBJECT_CD, SCHOOL_CD, NO, POINT, CLASS_NUM)
            KEY (STUDENT_NO, SUBJECT_CD, SCHOOL_CD, NO)
            VALUES (?, ?, ?, ?, ?, ?)
            """;
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, test.getStudent().getNo().trim());
            ps.setString(2, test.getSubject().getCd().trim());
            ps.setString(3, test.getSchool().getCd().trim());
            ps.setInt(4, test.getNo());
            ps.setInt(5, test.getPoint());
            ps.setString(6, test.getClassNum() != null ? test.getClassNum().trim() : "");
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ▼ 成績登録画面用：学生リストをループして成績オブジェクトのリストを生成
    public List<Test> list(List<Student> students, Subject subject, School school, int num) {
        List<Test> list = new java.util.ArrayList<>();
        for (Student stu : students) {
            Test t = get(stu, subject, school, num);
            if (t == null) {
                t = new Test();
                t.setStudent(stu);
                t.setSubject(subject);
                t.setSchool(school);
                t.setClassNum(stu.getClassNum());
                t.setNo(num);
                t.setPoint(0); // データがなければ初期値0
            }
            list.add(t);
        }
        return list;
    }
}