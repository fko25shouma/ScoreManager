package scoremanager;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.School;
import bean.Student;
import bean.Teacher;
import dao.ClassNumDao;
import dao.StudentDao;
import tool.Action;

public class StudentUpdateAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp)
            throws Exception {

        HttpSession session = req.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        // ▼ ログインチェック
        if (teacher == null || !teacher.isAuthenticated()) {
            resp.sendRedirect("Login.action");
            return;
        }

        // ▼ パラメータ取得
        String no = req.getParameter("no");
        if (no == null || no.isEmpty()) {
            resp.sendRedirect("StudentList.action");
            return;
        }

        School school = teacher.getSchool();
        StudentDao sDao = new StudentDao();

        // ▼ 学生情報取得
        Student student = sDao.get(no);

        if (student == null) {
            req.setAttribute("error", "学生情報が見つかりません");
            req.getRequestDispatcher("/scoremanager/main/student_update.jsp")
               .forward(req, resp);
            return;
        }

        // ▼ クラス一覧（プルダウン用）
        ClassNumDao cDao = new ClassNumDao();
        var classNumSet = cDao.filter(school);

        // ▼ 入学年度一覧（StudentList と同じ）
        var entYearSet = sDao.filterEntYear(school);

        // ▼ JSP へ渡す
        req.setAttribute("student", student);
        req.setAttribute("class_num_set", classNumSet);
        req.setAttribute("ent_year_set", entYearSet);

        req.getRequestDispatcher("/scoremanager/main/student_update.jsp")
           .forward(req, resp);
    }
}
