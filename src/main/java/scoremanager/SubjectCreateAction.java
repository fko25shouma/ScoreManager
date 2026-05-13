package scoremanager;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.School;
import tool.Action;

public class SubjectCreateAction extends Action{
	public void execute(
		HttpServletRequest request, HttpServletResponse response
		)throws Exception{
		
		HttpSession session = request.getSession();
		School school = (School)session.getAttribute("school");

		
		request.setAttribute("school_cd",school.getCd());
		
		request.getRequestDispatcher("subject_create.jsp")
        .forward(request, response);
	}
	
}