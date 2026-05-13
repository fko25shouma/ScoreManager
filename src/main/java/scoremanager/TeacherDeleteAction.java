package scoremanager;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.School;
import bean.Teacher;
import dao.TeacherDao;
import tool.Action;

public class TeacherDeleteAction extends Action {
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        School school = (School)session.getAttribute("school");

        String id = request.getParameter("id");
        TeacherDao dao = new TeacherDao();
        Teacher teacher = dao.get(id);


        request.setAttribute("id", teacher.getId());
        request.setAttribute("name", teacher.getName());
        request.setAttribute("school", school);

        request.getRequestDispatcher("teacher_delete.jsp")
               .forward(request, response);
    }
}
