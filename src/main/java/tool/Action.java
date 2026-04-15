package tool;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public  abstract class Action extends HttpServlet {
	public abstract void execute(
			HttpServletRequest request, HttpServletResponse response
			) throws Exception;
}
