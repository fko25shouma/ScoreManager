package scoremanager;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.Teacher;
import dao.TeacherDao;
import tool.Action;

public class LoginExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String id = request.getParameter("id");
        String password = request.getParameter("password");

        TeacherDao dao = new TeacherDao();
        Teacher teacher = dao.login(id, password);

        // ▼ ログイン失敗
        if (teacher == null) {
            request.setAttribute("error", "IDまたはパスワードが違います");
            request.getRequestDispatcher("/scoremanager/main/login.jsp")
                   .forward(request, response);
            return;
        }

        // ▼ ログイン成功 → 認証フラグを立てる
        teacher.setAuthenticated(true);

        // ▼ セッションへ保存（全 Action と統一）
        HttpSession session = request.getSession();
        session.setAttribute("user", teacher);         
        session.setAttribute("school", teacher.getSchool()); // ← ここが最重要
        session.setAttribute("loginUserName", teacher.getName());

        // ▼ メニューへ遷移
        response.sendRedirect(request.getContextPath() + "/scoremanager/main/menu.jsp");
    }
}
