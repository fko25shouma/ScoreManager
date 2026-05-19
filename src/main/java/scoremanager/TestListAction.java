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

        // ▼ ログインチェック
        Teacher teacher = (Teacher) req.getSession().getAttribute("user");
        if (teacher == null) {
            req.getRequestDispatcher("/scoremanager/main/login.jsp").forward(req, res);
            return;
        }

        School school = teacher.getSchool();

        // ▼ 初期表示用プルダウンデータのセット
        ClassNumDao classNumDao = new ClassNumDao();
        SubjectDao subjectDao = new SubjectDao();

        req.setAttribute("class_num_set", classNumDao.filter(school));
        req.setAttribute("subject_list", subjectDao.filter(school));

        // 入学年度セット（余裕を持たせて 2015〜2035年 で生成）
        java.util.Set<Integer> entYearSet = new java.util.TreeSet<>();
        for (int y = 2015; y <= 2035; y++) {
            entYearSet.add(y);
        }
        req.setAttribute("ent_year_set", entYearSet);

        // ▼ パラメータ取得と空白除去（CHAR型対策）
        String entYearStr = req.getParameter("ent_year");
        String classNum = req.getParameter("class_num");
        String subjectCd = req.getParameter("subject_cd");
        String numStr = req.getParameter("num");

        if (classNum != null) classNum = classNum.trim();
        if (subjectCd != null) subjectCd = subjectCd.trim();

        // ▼ 初期表示（メニュー等から遷移してきた直後で、まだ検索ボタンを押していない場合）
        if (entYearStr == null || entYearStr.isEmpty()) {
            req.getRequestDispatcher("/scoremanager/main/test_list.jsp").forward(req, res);
            return;
        }

        // ▼ 検索処理
        int entYear = Integer.parseInt(entYearStr);
        int num = (numStr != null && !numStr.isEmpty()) ? Integer.parseInt(numStr) : 1;

        // 科目の取得（安全装置付き）
        Subject subject = subjectDao.get(subjectCd, school);
        if (subject == null) {
            req.setAttribute("error", "指定された科目データが見つかりません。");
            req.getRequestDispatcher("/scoremanager/main/test_list.jsp").forward(req, res);
            return;
        }

        // ▼ 学生一覧取得
        StudentDao studentDao = new StudentDao();
        
        // ★【修正ポイント】引数を true（在学中のみ）から false（全件取得）に変更！
        // これで、在学中フラグに関わらず同じクラスの学生全員がリストアップされます
        List<Student> studentList = studentDao.filter(school, entYear, classNum, true);

        if (studentList.isEmpty()) {
            req.setAttribute("error", "条件に一致する学生が存在しません。");
        }

        // ▼ 成績一覧取得
        TestDao testDao = new TestDao();
        List<Test> testList = testDao.list(studentList, subject, school, num);

        // ▼ JSPへデータ受け渡し
        req.setAttribute("test_list", testList);
        req.setAttribute("ent_year", entYearStr);
        req.setAttribute("class_num", classNum);
        req.setAttribute("subject_cd", subjectCd);
        req.setAttribute("num", num);

        req.getRequestDispatcher("/scoremanager/main/test_list.jsp").forward(req, res);
    }
}