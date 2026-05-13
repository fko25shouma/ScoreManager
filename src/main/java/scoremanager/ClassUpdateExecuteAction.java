package scoremanager;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.ClassNum;
import bean.School;
import dao.ClassNumDao;
import tool.Action;

public class ClassUpdateExecuteAction extends Action {
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        School school = (School)session.getAttribute("school");
        ClassNumDao dao = new ClassNumDao();

        String cd = request.getParameter("cd");
        String newcd = request.getParameter("newcd");
        
        boolean hasError = false;
        ClassNum current = dao.get(cd, school);
        if (current == null) {
            request.setAttribute("deleteerror", "クラスが存在していません。");
            request.setAttribute("cd", cd);
            hasError = true;
        }
        
        if (newcd == null || newcd.isBlank()) {
            request.setAttribute("error", "このフィールドを入力してください。");
            hasError = true;
        }else if (newcd.length() != 3) {
            request.setAttribute("error", "クラス番号は3文字で入力してください");
            hasError = true;
        }
        ClassNum exists = dao.get(newcd, school);
        if (exists != null) {
            request.setAttribute("error", "このクラス番号は既に登録されています");
            hasError = true;
        }
        
        if (hasError == true) {
            request.setAttribute("cd", cd);
            request.setAttribute("school_cd", school.getCd());

            request.getRequestDispatcher("class_update.jsp")
                   .forward(request, response);
            return;
        }

        ClassNum class_num = new ClassNum();
        class_num.setSchool(school);
        class_num.setClass_num(cd);

        dao.save(class_num,newcd);

        request.getRequestDispatcher("class_update_done.jsp")
               .forward(request, response);
    }
}
