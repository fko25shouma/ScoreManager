package scoremanager;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.School;
import bean.Teacher;
import dao.TeacherDao;
import tool.Action;

public class TeacherDeleteExecuteAction extends Action {
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        School school = (School)session.getAttribute("school");
        
        String id = request.getParameter("id");

        Teacher teacher = new Teacher();
        teacher.setId(id);

        TeacherDao dao = new TeacherDao();
        dao.delete(teacher);

        request.getRequestDispatcher("teacher_delete_done.jsp")
               .forward(request, response);
    }
}
