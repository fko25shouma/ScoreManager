package scoremanager;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import tool.Action;

public class MenuAction extends Action {
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
    	
        // メニュー画面へフォワード
    	
        req.getRequestDispatcher("/scoremanager/main/menu.jsp").forward(req, resp);
    }
}