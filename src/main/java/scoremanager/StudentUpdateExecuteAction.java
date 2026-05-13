package scoremanager;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.Student;
import bean.Teacher;
import dao.StudentDao;
import tool.Action;

public class StudentUpdateExecuteAction extends Action {

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
        String name = req.getParameter("name");
        String entYearStr = req.getParameter("ent_year");
        String classNum = req.getParameter("class_num");

        boolean hasError = false;

        // ▼ 入力チェック
        if (no == null || no.isBlank()) {
            req.setAttribute("error_no", "学生番号が不正です");
            hasError = true;
        }
        if (name == null || name.isBlank()) {
            req.setAttribute("error_name", "氏名を入力してください");
            hasError = true;
        }
        if (entYearStr == null || entYearStr.isBlank()) {
            req.setAttribute("error_ent_year", "入学年度を選択してください");
            hasError = true;
        }
        if (classNum == null || classNum.isBlank()) {
            req.setAttribute("error_class_num", "クラスを選択してください");
            hasError = true;
        }

        // ▼ エラー時は元の画面へ戻す
        if (hasError) {
            req.setAttribute("no", no);
            req.setAttribute("name", name);
            req.setAttribute("ent_year", entYearStr);
            req.setAttribute("class_num", classNum);

            req.getRequestDispatcher("/scoremanager/main/student_update.jsp")
               .forward(req, resp);
            return;
        }

        // ▼ 更新処理
        StudentDao dao = new StudentDao();
        Student student = dao.get(no);

        if (student == null) {
            req.setAttribute("error", "学生情報が存在しません");
            req.getRequestDispatcher("/scoremanager/main/student_update.jsp")
               .forward(req, resp);
            return;
        }

        student.setName(name);
        student.setEntYear(Integer.parseInt(entYearStr));
        student.setClassNum(classNum);

        dao.save(student);

        // ▼ 完了画面へ
        req.getRequestDispatcher("/scoremanager/main/student_update_done.jsp")
           .forward(req, resp);
    }
}
