package scoremanager;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.School;
import bean.Subject;
import dao.SubjectDao;
import tool.Action;

public class SubjectDeleteAction extends Action {
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        School school = (School)session.getAttribute("school");

        String cd = request.getParameter("cd");

        SubjectDao dao = new SubjectDao();
        Subject subject = dao.get(cd, school);


        request.setAttribute("cd", subject.getCd());
        request.setAttribute("name", subject.getName());

        request.getRequestDispatcher("subject_delete.jsp")
               .forward(request, response);
    }
}
