package scoremanager;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.School;
import bean.Student;
import dao.StudentDao;
import tool.Action;

public class StudentCreateExecuteAction extends Action {
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        School school = (School)session.getAttribute("school");

        String ent_year = request.getParameter("ent_year");
        String no = request.getParameter("no");
        String name = request.getParameter("name");
        String class_num = request.getParameter("class_num");
        StudentDao dao = new StudentDao();
        Student student = new Student();
        
        boolean hasError = false;

        // ▼ 入学年度チェック
        if (ent_year == null || ent_year.isBlank()) {
            request.setAttribute("error_ent_year", "入学年度を選択してください");
            hasError = true;
        }

        // ▼ 学生番号チェック
        if (no == null || no.isBlank()) {
            request.setAttribute("error_no", "学生番号を入力してください");
            hasError = true;
        }

        // ▼ 氏名チェック
        if (name == null || name.isBlank()) {
            request.setAttribute("error_name", "氏名を入力してください");
            hasError = true;
        }

        // ▼ クラスチェック
        if (class_num == null || class_num.isBlank()) {
            request.setAttribute("error_class_num", "クラスを選択してください");
            hasError = true;
        }
        
        if (hasError) {
            request.setAttribute("ent_year", ent_year);
            request.setAttribute("no", no);
            request.setAttribute("name", name);
            request.setAttribute("class_num", class_num);

            request.getRequestDispatcher("student_create.jsp")
                   .forward(request, response);
            return;
        }
        student.setSchool(school);
        student.setEntYear(Integer.parseInt(ent_year));
        student.setNo(no);
        student.setName(name);
        student.setClassNum(class_num); 
        student.setAttend(true);
        dao.save(student);
        
        request.getRequestDispatcher("student_create_done.jsp")
               .forward(request, response);
    }
}
