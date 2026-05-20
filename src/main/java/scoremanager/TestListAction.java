package scoremanager;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import bean.School;
import bean.Student;
import bean.Subject;
import bean.Teacher;
import bean.Test;
import dao.ClassNumDao;
import dao.StudentDao;
import dao.SubjectDao;
import dao.TestDao;
import tool.Action;

public class TestListAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

        // ログイン状態の確認を行います
        Teacher teacher = (Teacher) req.getSession().getAttribute("user");
        if (teacher == null) {
            req.getRequestDispatcher("/scoremanager/main/login.jsp").forward(req, res);
            return;
        }

        School school = teacher.getSchool();

        // 初期表示およびリダイレクト時用の各コンポーネント用DAOオブジェクトを初期化します
        ClassNumDao classNumDao = new ClassNumDao();
        SubjectDao subjectDao = new SubjectDao();
        StudentDao studentDao = new StudentDao();

        // 各プルダウンにバインドするための動的データをリクエスト属性に設定します
        req.setAttribute("class_num_set", classNumDao.filter(school));
        req.setAttribute("subjects", subjectDao.filter(school));

        // 固定値によるループ生成を撤去し、データベースから実在する入学年度の一覧を動的に取得します
        List<Integer> entYearSet = studentDao.filterEntYear(school);
        req.setAttribute("ent_year_set", entYearSet);

        // リクエストパラメータの抽出を行います
        String entYearStr = req.getParameter("entYear");
        String classNum = req.getParameter("classNum");
        String subjectCd = req.getParameter("subjectCd");
        String numStr = req.getParameter("num");

        // 必須検索条件の不足を検知した場合は初期表示用JSPへ転送します
        if (entYearStr == null || entYearStr.isEmpty() || subjectCd == null || subjectCd.isEmpty()) {
            req.getRequestDispatcher("/scoremanager/main/test_list.jsp").forward(req, res);
            return;
        }

        // 抽出データの型変換およびデフォルト値の適用を行います
        int entYear = Integer.parseInt(entYearStr);
        int num = (numStr != null && !numStr.isEmpty()) ? Integer.parseInt(numStr) : 1;

        // 指定された科目の存在および妥当性を検証します
        Subject subject = subjectDao.get(subjectCd, school);
        if (subject == null) {
            req.setAttribute("error", "指定された科目データが見つかりません。");
            req.getRequestDispatcher("/scoremanager/main/test_list.jsp").forward(req, res);
            return;
        }
        
        // 対象クラスに所属する学生の一覧を永続化層から抽出します
        List<Student> studentList = studentDao.filter(school, entYear, classNum, true);

        if (studentList.isEmpty()) {
            req.setAttribute("error", "条件に一致する学生が存在しません。");
        }

        // 学生一覧と紐づく得点データの一覧を取得します
        TestDao testDao = new TestDao();
        List<Test> testList = testDao.list(studentList, subject, school, num);

        // 取得した各種データ群をビュー層（JSP）へ引き渡すための設定です
        req.setAttribute("test_list", testList);
        req.setAttribute("entYear", entYearStr);
        req.setAttribute("classNum", classNum);
        req.setAttribute("subjectCd", subjectCd);

        req.getRequestDispatcher("/scoremanager/main/test_list.jsp").forward(req, res);
    }
}