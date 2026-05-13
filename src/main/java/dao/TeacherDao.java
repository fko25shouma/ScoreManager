package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.School;
import bean.Teacher;

public class TeacherDao extends Dao {

	public Teacher get(String id) {

	    Teacher teacher = null;

	    String sql = "SELECT ID, PASSWORD, NAME, SCHOOL_CD FROM TEACHER WHERE ID = ?";

	    try (Connection con = getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setString(1, id);

	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                teacher = new Teacher();
	                teacher.setId(rs.getString("ID"));
	                teacher.setPassword(rs.getString("PASSWORD"));
	                teacher.setName(rs.getString("NAME"));

	                School school = new School();
	                school.setCd(rs.getString("SCHOOL_CD"));
	                teacher.setSchool(school);
	            }
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return teacher;
	}

	
	public List<Teacher> filter(School school) {

	    List<Teacher> list = new ArrayList<>();

	    String sql = "SELECT ID, PASSWORD, NAME, SCHOOL_CD FROM TEACHER WHERE SCHOOL_CD = ? ORDER BY ID";

	    try (Connection con = getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setString(1, school.getCd());

	        try (ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                Teacher t = new Teacher();
	                t.setId(rs.getString("ID"));
	                t.setPassword(rs.getString("PASSWORD"));
	                t.setName(rs.getString("NAME"));

	                School s = new School();
	                s.setCd(rs.getString("SCHOOL_CD"));
	                t.setSchool(s);

	                list.add(t);
	            }
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}


    public Teacher login(String id, String password) {
        Teacher teacher = null;

        String sql = "SELECT ID, PASSWORD, NAME, SCHOOL_CD FROM TEACHER WHERE ID = ? AND PASSWORD = ?";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, id);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    teacher = new Teacher();
                    teacher.setId(rs.getString("ID"));
                    teacher.setPassword(rs.getString("PASSWORD"));
                    teacher.setName(rs.getString("NAME"));

                    School school = new School();
                    school.setCd(rs.getString("SCHOOL_CD"));
                    teacher.setSchool(school);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return teacher;
    }
    
    public boolean save(Teacher teacher) {
        String sql = """
            MERGE INTO TEACHER (ID, PASSWORD, NAME, SCHOOL_CD)
            KEY (ID)
            VALUES (?, ?, ?, ?)
            """;

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, teacher.getId());
            ps.setString(2, teacher.getPassword());
            ps.setString(3, teacher.getName());
            ps.setString(4, teacher.getSchool().getCd());

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    public boolean delete(Teacher teacher) {
        String sql = """
            DELETE FROM TEACHER
            WHERE ID = ?
            """;

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, teacher.getId());
            
            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
