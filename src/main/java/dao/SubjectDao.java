package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.School;
import bean.Subject;

public class SubjectDao extends Dao {

    public Subject get(String cd, School school) {
        Subject subject = null;
        // ★CHAR型の空白問題対策として TRIM() を追加
        String sql = """
            SELECT SCHOOL_CD, CD, NAME
            FROM SUBJECT
            WHERE TRIM(CD) = ? AND TRIM(SCHOOL_CD) = ?
            """;

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, cd != null ? cd.trim() : "");
            ps.setString(2, school.getCd() != null ? school.getCd().trim() : "");

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    subject = new Subject();
                    subject.setCd(rs.getString("CD").trim());
                    subject.setName(rs.getString("NAME"));
                    subject.setSchoolCd(rs.getString("SCHOOL_CD").trim());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return subject;
    }

    public List<Subject> filter(School school) {
        List<Subject> list = new ArrayList<>();
        // ★TRIM() を追加
        String sql = """
            SELECT SCHOOL_CD, CD, NAME
            FROM SUBJECT
            WHERE TRIM(SCHOOL_CD) = ?
            ORDER BY CD
            """;

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, school.getCd() != null ? school.getCd().trim() : "");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Subject s = new Subject();
                    s.setCd(rs.getString("CD").trim());
                    s.setName(rs.getString("NAME"));
                    s.setSchoolCd(rs.getString("SCHOOL_CD").trim());
                    list.add(s);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean save(Subject subject) {
        String sql = """
            MERGE INTO SUBJECT (SCHOOL_CD, CD, NAME)
            KEY (SCHOOL_CD, CD)
            VALUES (?, ?, ?)
            """;
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, subject.getSchoolCd().trim());
            ps.setString(2, subject.getCd().trim());
            ps.setString(3, subject.getName());
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean delete(Subject subject) {
        String sql = """
            DELETE FROM SUBJECT
            WHERE TRIM(SCHOOL_CD) = ? AND TRIM(CD) = ?
            """;
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, subject.getSchoolCd().trim());
            ps.setString(2, subject.getCd().trim());
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}