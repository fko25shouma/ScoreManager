package scoremanager;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.School;
import bean.Teacher;
import dao.ClassNumDao;
import tool.Action;

public class ClassListAction extends Action {
    public void execute(
        HttpServletRequest request, HttpServletResponse response
    ) throws Exception {

        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        if (teacher == null || !teacher.isAuthenticated()) {
            request.getRequestDispatcher("/scoremanager/main/login.jsp")
                   .forward(request, response);
            return;
        }
        School school = (School)session.getAttribute("school");


        ClassNumDao dao = new ClassNumDao();
        List<String> list = dao.filter(school);

        request.setAttribute("list", list);

        request.getRequestDispatcher("/scoremanager/main/class_list.jsp")
               .forward(request, response);
    }
}
