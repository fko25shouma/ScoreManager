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
        String isAttendStr = request.getParameter("is_attend");

        // --- 3. バリデーション（入力チェック） ---
        // 氏名が未入力、または空白スペースのみの場合
        if (name == null || name.isBlank()) {
            // エラーメッセージを設定（JSP側で表示させるメッセージ）
            request.setAttribute("error", "このフィールドを入力してください。");
            
            // 元の入力値をリクエスト属性に詰め直す（画面に戻ったときに入力内容が消えないようにする）
            request.setAttribute("ent_year", entYearStr);
            request.setAttribute("no", no);
            request.setAttribute("name", name);
            request.setAttribute("currentClass", classNum);
            request.setAttribute("is_attend", isAttendStr != null ? "1" : "0");
            
            // クラスリスト（セレクトボックス用）が再表示に必要な場合は、ここで再度DAO等から取得してセットしてください
            // 例: request.setAttribute("classList", cDao.filter(teacher.getSchool()));

            // 入力画面（JSP）へフォワードで戻る
            request.getRequestDispatcher("student_update.jsp").forward(request, response);
            return; // 処理をここで終了させる（これ以降の更新処理は走らない）
        }

        // --- 4. データの型変換とセット ---
        int entYear = Integer.parseInt(entYearStr);
        boolean isAttend = (isAttendStr != null);

        // 更新用データの作成
        Student student = new Student();
        student.setNo(no);
        student.setName(name);
        student.setEntYear(entYear);
        student.setClassNum(classNum);
        student.setAttend(isAttend);
        student.setSchool(teacher.getSchool());

        // --- 5. データベース更新 ---
        boolean result = sDao.save(student);

        // --- 6. 遷移先の決定 ---
        if (result) {
            // 更新成功：完了画面へリダイレクト
            response.sendRedirect("student_update_done.jsp");
        } else {
            // 万が一DBの更新自体に失敗した場合のフォールバック
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}