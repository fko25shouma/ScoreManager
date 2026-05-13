package scoremanager;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import bean.School;
import bean.Subject;
import bean.Teacher;
import dao.ClassNumDao;
import dao.StudentDao;
import dao.SubjectDao;
import tool.Action;

public class TestRegistAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

        // ▼ 1. ログインチェック
        Teacher teacher = (Teacher) req.getSession().getAttribute("user");

        if (teacher == null || !teacher.isAuthenticated()) {
            req.getRequestDispatcher("/scoremanager/main/login.jsp").forward(req, res);
            return;
        }

        School school = teacher.getSchool();

        // ▼ 2. クラス一覧を取得
        ClassNumDao classNumDao = new ClassNumDao();
        List<String> classList = classNumDao.filter(school);

        // ▼ 3. 科目一覧を取得
        SubjectDao subjectDao = new SubjectDao();
        List<Subject> subjectList = subjectDao.filter(school);

        // ▼ 4. 入学年度リストを DB から取得
        StudentDao studentDao = new StudentDao();
        List<Integer> entYearSet = studentDao.filterEntYear(school);

        // ▼ 5. JSP に渡す
        req.setAttribute("class_num_set", classList);
        req.setAttribute("subject_list", subjectList);
        req.setAttribute("ent_year_set", entYearSet);

        // ▼ 6. test_regist.jsp へ遷移
        req.getRequestDispatcher("/scoremanager/main/test_regist.jsp").forward(req, res);
    }
}
