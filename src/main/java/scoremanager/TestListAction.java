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

        // ▼ 初期表示用データ
        ClassNumDao classNumDao = new ClassNumDao();
        SubjectDao subjectDao = new SubjectDao();

        req.setAttribute("class_num_set", classNumDao.filter(school));
        req.setAttribute("subject_list", subjectDao.filter(school));

        // 入学年度セット
        java.util.Set<Integer> entYearSet = new java.util.TreeSet<>();
        for (int y = 2015; y <= 2030; y++) entYearSet.add(y);
        req.setAttribute("ent_year_set", entYearSet);

        // ▼ パラメータ取得
        String entYearStr = req.getParameter("ent_year");
        String classNum = req.getParameter("class_num");
        String subjectCd = req.getParameter("subject_cd");
        String numStr = req.getParameter("num");

        // ▼ 初期表示（検索前）
        if (entYearStr == null || entYearStr.isEmpty()) {
            req.getRequestDispatcher("/scoremanager/main/test_list.jsp").forward(req, res);
            return;
        }

        int entYear = Integer.parseInt(entYearStr);
        int num = Integer.parseInt(numStr);

        // ▼ 科目取得
        Subject subject = subjectDao.get(subjectCd, school);

        // ▼ 学生一覧取得
        StudentDao studentDao = new StudentDao();
        List<Student> studentList = studentDao.filter(school, entYear, classNum, true);

        // ▼ 成績一覧取得
        TestDao testDao = new TestDao();
        List<Test> testList = testDao.list(studentList, subject, school, num);

        req.setAttribute("test_list", testList);
        req.setAttribute("ent_year", entYear);
        req.setAttribute("class_num", classNum);
        req.setAttribute("subject_cd", subjectCd);
        req.setAttribute("num", num);

        req.getRequestDispatcher("/scoremanager/main/test_list.jsp").forward(req, res);
    }
}
