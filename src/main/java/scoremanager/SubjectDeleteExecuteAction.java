package scoremanager;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.School;
import bean.Subject;
import dao.SubjectDao;
import tool.Action;

public class SubjectDeleteExecuteAction extends Action {
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        School school = (School)session.getAttribute("school");

        String cd = request.getParameter("cd");

        Subject subject = new Subject();
        subject.setSchoolCd(school.getCd());
        subject.setCd(cd);

        SubjectDao dao = new SubjectDao();
        dao.delete(subject);

        request.getRequestDispatcher("subject_delete_done.jsp")
               .forward(request, response);
    }
}
