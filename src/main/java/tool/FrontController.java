package tool;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("*.action")
public class FrontController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, java.io.IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            // 例: /scoremanager/Logout.action
            String servletPath = request.getServletPath();

            // 最後の "/" 以降を取得 → Logout.action
            String actionName = servletPath.substring(servletPath.lastIndexOf("/") + 1);

            // .action を除去 → Logout
            actionName = actionName.replace(".action", "");

            // Action クラス名を組み立てる → LogoutAction
            String className = "scoremanager." + actionName + "Action";

            Class<?> clazz = Class.forName(className);
            Action action = (Action) clazz.getDeclaredConstructor().newInstance();
            action.execute(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, java.io.IOException {
        doGet(request, response);
    }
}
