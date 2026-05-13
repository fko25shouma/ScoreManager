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

        // ログインチェック
        Teacher teacher = (Teacher) req.getSession().getAttribute("user");
        if (teacher == null) {
            req.getRequestDispatcher("/scoremanager/main/login.jsp").forward(req, res);
            return;
        }

        School school = teacher.getSchool();

        // プルダウン用データの取得
        ClassNumDao classNumDao = new ClassNumDao();
        SubjectDao subjectDao = new SubjectDao();
        StudentDao studentDao = new StudentDao();

        List<String> classList = classNumDao.filter(school);
        List<Subject> subjectList = subjectDao.filter(school);
        List<Integer> entYearSet = studentDao.filterEntYear(school);

        // JSPへデータを渡す
        req.setAttribute("class_num_set", classList);
        req.setAttribute("subject_list", subjectList);
        req.setAttribute("ent_year_set", entYearSet);
        
        // 前回の入力を保持（学生番号含む）
        req.setAttribute("student_no", req.getParameter("student_no"));

        // 登録画面へ遷移
        req.getRequestDispatcher("/scoremanager/main/test_regist.jsp").forward(req, res);
    }
}