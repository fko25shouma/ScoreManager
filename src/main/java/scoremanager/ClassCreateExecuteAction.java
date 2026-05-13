package scoremanager;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.ClassNum;
import bean.School;
import dao.ClassNumDao;
import tool.Action;

public class ClassCreateExecuteAction extends Action {
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        School school = (School)session.getAttribute("school");

        String cd = request.getParameter("cd");
        
        boolean hasError = false;
        
        if (cd == null || cd.isEmpty()) {
            request.setAttribute("errorCd", "このフィールドを入力してください");
            hasError = true;
        } else if (cd.length() != 3) {
            request.setAttribute("errorCd", "クラス番号は3文字で入力してください");
            hasError = true;
        }
        
        ClassNumDao dao = new ClassNumDao();
        ClassNum exists = dao.get(cd, school);
        if (exists != null) {
            request.setAttribute("errorCd", "このクラス番号は既に登録されています");
            hasError = true;
        }
        
        if (hasError == true) {
            request.setAttribute("cd", cd);
            request.setAttribute("school_cd", school.getCd());

            request.getRequestDispatcher("class_create.jsp")
                   .forward(request, response);
            return;
        }

        ClassNum class_num = new ClassNum();
        class_num.setSchool(school);
        class_num.setClass_num(cd);
        dao.save(class_num);

        request.getRequestDispatcher("class_create_done.jsp")
               .forward(request, response);
    }
}
