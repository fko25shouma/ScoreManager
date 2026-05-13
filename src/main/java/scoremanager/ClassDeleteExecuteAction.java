package scoremanager;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.ClassNum;
import bean.School;
import dao.ClassNumDao;
import tool.Action;

public class ClassDeleteExecuteAction extends Action {
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        School school = (School)session.getAttribute("school");

        String cd = request.getParameter("cd");

        ClassNum class_num = new ClassNum();
        class_num.setSchool(school);
        class_num.setClass_num(cd);

        ClassNumDao dao = new ClassNumDao();
        dao.delete(class_num);

        request.getRequestDispatcher("scoremanager/main/class_delete_done.jsp")
               .forward(request, response);
    }
}
