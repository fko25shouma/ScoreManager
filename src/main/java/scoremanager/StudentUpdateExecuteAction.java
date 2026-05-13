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
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // --- 1. 準備 ---
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");
        StudentDao sDao = new StudentDao();

        // --- 2. リクエストパラメータの取得 ---
        String entYearStr = request.getParameter("ent_year");
        String no = request.getParameter("no");
        String name = request.getParameter("name");
        String classNum = request.getParameter("class_num");
        String isAttendStr = request.getParameter("is_attend"); // チェックボックス

        // 数値への変換
        int entYear = Integer.parseInt(entYearStr);
        // チェックボックスがONなら true, OFF(null)なら false
        boolean isAttend = (isAttendStr != null);

        // --- 3. 更新用データの作成 ---
        // 既存の学生情報を取得するか、新しくインスタンスを作って値をセットする
        Student student = new Student();
        student.setNo(no);
        student.setName(name);
        student.setEntYear(entYear);
        student.setClassNum(classNum);
        student.setAttend(isAttend);
        student.setSchool(teacher.getSchool()); // ログインユーザーの学校をセット

        // --- 4. データベース更新 ---
        // StudentDaoにsaveメソッド（またはupdateメソッド）がある想定
        boolean result = sDao.save(student);

        // --- 5. 遷移先の決定 ---
        if (result) {
            // 更新成功：学生一覧へリダイレクト、または完了画面へ
            response.sendRedirect("StudentUpdateDone.action");
        } else {
            // 更新失敗：エラーメッセージをセットして元の画面へ（簡易的な例）
            request.setAttribute("error", "更新に失敗しました。");
            request.getRequestDispatcher("student_update.jsp").forward(request, response);
        }
    }
}