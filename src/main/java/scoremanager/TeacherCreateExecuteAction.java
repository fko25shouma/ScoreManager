package scoremanager;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.School;
import bean.Teacher;
import dao.TeacherDao;
import tool.Action;

public class TeacherCreateExecuteAction extends Action {
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        School school = (School)session.getAttribute("school");

        String id = request.getParameter("id");
        String password = request.getParameter("password");
        String password2 = request.getParameter("password2");
        String name = request.getParameter("name");
        
        boolean hasError = false;
        
        if (id == null || id.isEmpty()) {
            request.setAttribute("errorId", "このフィールドを入力してください");
            hasError = true;
        }
        if (password == null || password.isEmpty()) {
            request.setAttribute("errorPass", "このフィールドを入力してください");
            hasError = true;
        }
        if (!password.equals(password2)) {
            request.setAttribute("errorPass2", "パスワードが一致しません");
            hasError = true;
        }

        if (name == null || name.isEmpty()) {
            request.setAttribute("errorName", "このフィールドを入力してください");
            hasError = true;
        }
        
        if (hasError == true) {
            request.setAttribute("id", id);
            request.setAttribute("password", password);
            request.setAttribute("name", name);

            request.getRequestDispatcher("teacher_create.jsp")
                   .forward(request, response);
            return;
        }
        TeacherDao dao = new TeacherDao();
        
        Teacher teacher = new Teacher();
        teacher.setId(id);
        teacher.setPassword(password);
        teacher.setSchool(school);
        teacher.setName(name);

        dao.save(teacher);

        request.getRequestDispatcher("teacher_create_done.jsp")
               .forward(request, response);
    }
}
