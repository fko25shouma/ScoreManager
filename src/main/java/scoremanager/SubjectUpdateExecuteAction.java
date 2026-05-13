package scoremanager;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.School;
import bean.Subject;
import dao.SubjectDao;
import tool.Action;

public class SubjectUpdateExecuteAction extends Action {
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        School school = (School)session.getAttribute("school");
        SubjectDao dao = new SubjectDao();

        String cd = request.getParameter("cd");
        String name = request.getParameter("name");
        
        boolean hasError = false;
        Subject current = dao.get(cd, school);
        if (current == null) {
            request.setAttribute("deleteerror", "科目が存在していません。");
            request.setAttribute("cd", cd);
            request.setAttribute("name", name);
            hasError = true;
        }
        
        if (name == null || name.isBlank()) {
            request.setAttribute("error", "このフィールドを入力してください。");
            hasError = true;
        }
        
        if (hasError == true) {
            request.setAttribute("cd", cd);
            request.setAttribute("name", name);
            request.setAttribute("school_cd", school.getCd());

            request.getRequestDispatcher("subject_update.jsp")
                   .forward(request, response);
            return;
        }

        Subject subject = new Subject();
        subject.setSchoolCd(school.getCd());
        subject.setCd(cd);
        subject.setName(name);

        dao.save(subject);

        request.getRequestDispatcher("subject_update_done.jsp")
               .forward(request, response);
    }
}
