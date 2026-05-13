package scoremanager;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.School;
import bean.Teacher;
import dao.TeacherDao;
import tool.Action;

public class TeacherUpdateExecuteAction extends Action {
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        School school = (School)session.getAttribute("school");
        TeacherDao dao = new TeacherDao();

        String id = request.getParameter("id");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        
        Teacher teacher = new Teacher();
        teacher.setSchool(school);
        teacher.setId(id);
        teacher.setPassword(password);
        teacher.setName(name);

        dao.save(teacher);

        request.getRequestDispatcher("teacher_update_done.jsp")
               .forward(request, response);
    }
}
