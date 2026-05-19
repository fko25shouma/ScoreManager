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
        // 1. ログインチェック
        Teacher teacher = (Teacher) req.getSession().getAttribute("user");
        if (teacher == null) {
            req.getRequestDispatcher("/scoremanager/main/login.jsp").forward(req, res);
            return;
        }

        School school = teacher.getSchool();

        // 2. 各種Daoからプルダウンデータを取得
        ClassNumDao classNumDao = new ClassNumDao();
        SubjectDao subjectDao = new SubjectDao();
        StudentDao studentDao = new StudentDao();

        List<String> classList = classNumDao.filter(school);
        List<Subject> subjectList = subjectDao.filter(school);
        List<Integer> entYearSet = studentDao.filterEntYear(school);

        // 3. リクエスト属性にセット
        req.setAttribute("class_num_set", classList);
        req.setAttribute("subject_list", subjectList);
        req.setAttribute("ent_year_set", entYearSet);
        
        // パラメータが飛んできていれば値を保持
        req.setAttribute("student_no", req.getParameter("student_no"));

        // 4. JSPへフォワード
        req.getRequestDispatcher("/scoremanager/main/test_regist.jsp").forward(req, res);
    }
}