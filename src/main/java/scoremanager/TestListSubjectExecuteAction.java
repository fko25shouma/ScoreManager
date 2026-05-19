package scoremanager;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.Subject;
import bean.Teacher;
import bean.TestListSubject;
import dao.SubjectDao;
import dao.TestListSubjectDao;
import tool.Action; // ★ここが超重要：Actionクラスをインポート

// ★ HttpServlet ではなく、Action を継承する形に修正
public class TestListSubjectExecuteAction extends Action {

    // ★ doPost ではなく、execute メソッドに修正
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

        HttpSession session = req.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        if (teacher == null) {
            req.getRequestDispatcher("/scoremanager/main/login.jsp").forward(req, res);
            return;
        }

        // ▼ JSPのフォームから送られてくるパラメータを取得
        // （entYear と ent_year の両方の書き方に対応できるよう安全対策）
        String entYearStr = req.getParameter("entYear");
        if (entYearStr == null) entYearStr = req.getParameter("ent_year");

        String classNum = req.getParameter("classNum");
        if (classNum == null) classNum = req.getParameter("class_num");

        String subjectCd = req.getParameter("subjectCd");
        if (subjectCd == null) subjectCd = req.getParameter("subject_cd");

        try {
            // 入力バリデーション
            if (entYearStr == null || entYearStr.isEmpty() || subjectCd == null || subjectCd.isEmpty()) {
                req.setAttribute("error", "必須項目（年度、クラス、科目）を選択してください");
                req.getRequestDispatcher("/scoremanager/main/test_list.jsp").forward(req, res);
                return;
            }

            int entYear = Integer.parseInt(entYearStr);

            // 科目の妥当性を確認（空白対策のためのtrimも追加）
            SubjectDao subjectDao = new SubjectDao();
            Subject subject = subjectDao.get(subjectCd.trim(), teacher.getSchool());

            if (subject != null) {
                // 科目情報を元に、指定クラス全員の10回分の成績を取得
                TestListSubjectDao dao = new TestListSubjectDao();
                List<TestListSubject> list = dao.filter(entYear, classNum.trim(), subject, teacher.getSchool());

                // 取得したデータをJSPへ渡す
                req.setAttribute("subject", subject);
                req.setAttribute("entYear", entYear);
                req.setAttribute("classNum", classNum);
                req.setAttribute("list", list);
            } else {
                req.setAttribute("error", "科目情報が正しく取得できませんでした");
            }

        } catch (NumberFormatException e) {
            req.setAttribute("error", "入学年度の形式が不正です");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
        }

        // ▼ 科目別成績一覧画面へフォワード
        req.getRequestDispatcher("/scoremanager/main/test_list_subject.jsp").forward(req, res);
    }
}