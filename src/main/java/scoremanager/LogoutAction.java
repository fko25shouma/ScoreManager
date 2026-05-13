package scoremanager;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import tool.Action;

public class LogoutAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {

        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // ログイン画面へ戻る
        resp.sendRedirect("Login.action");
    }
}
