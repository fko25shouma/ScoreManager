package scoremanager;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.School;
import bean.Subject;
import dao.SubjectDao;
import tool.Action;

public class SubjectCreateExecuteAction extends Action {
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        School school = (School)session.getAttribute("school");

        String cd = request.getParameter("cd");
        String name = request.getParameter("name");
        
        boolean hasError = false;
        
        if (cd == null || cd.isEmpty()) {
            request.setAttribute("errorCd", "このフィールドを入力してください");
            hasError = true;
        } else if (cd.length() != 3) {
            request.setAttribute("errorCd", "科目コードは3文字で入力してください");
            hasError = true;
        }

        if (name == null || name.isEmpty()) {
            request.setAttribute("errorName", "このフィールドを入力してください");
            hasError = true;
        }
        
        SubjectDao dao = new SubjectDao();
        Subject exists = dao.get(cd, school);
        if (exists != null) {
            request.setAttribute("errorCd", "この科目コードは既に登録されています");
            hasError = true;
        }
        
        if (hasError == true) {
            request.setAttribute("cd", cd);
            request.setAttribute("name", name);
            request.setAttribute("school_cd", school.getCd());

            request.getRequestDispatcher("subject_create.jsp")
                   .forward(request, response);
            return;
        }

        Subject subject = new Subject();
        subject.setSchoolCd(school.getCd());
        subject.setCd(cd);
        subject.setName(name);

        dao.save(subject);

        request.getRequestDispatcher("subject_create_done.jsp")
               .forward(request, response);
    }
}
