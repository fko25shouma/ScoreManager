package scoremanager;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.ClassNum;
import bean.School;
import dao.ClassNumDao;
import tool.Action;

public class ClassUpdateAction extends Action {
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        School school = (School)session.getAttribute("school");

        String cd = request.getParameter("cd");

        ClassNumDao dao = new ClassNumDao();
        ClassNum class_num = dao.get(cd, school);


        request.setAttribute("cd", class_num.getClass_num());

        request.getRequestDispatcher("scoremanager/main/class_update.jsp")
               .forward(request, response);
    }
}
