package scoremanager;

import java.util.ArrayList;
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

public class TestRegistExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

        // ▼ 1. ログインチェック
        Teacher teacher = (Teacher) req.getSession().getAttribute("user");
        if (teacher == null || !teacher.isAuthenticated()) {
            req.getRequestDispatcher("/scoremanager/main/login.jsp").forward(req, res);
            return;
        }

        School school = teacher.getSchool();

        // ▼ 2. パラメータ取得
        String entYearStr = req.getParameter("ent_year");
        String classNum = req.getParameter("class_num");
        String subjectCd = req.getParameter("subject_cd");
        String numStr = req.getParameter("num");

        // ▼ 3. 初期表示用データ（DB から取得）
        ClassNumDao classNumDao = new ClassNumDao();
        SubjectDao subjectDao = new SubjectDao();
        StudentDao studentDao = new StudentDao();

        req.setAttribute("class_num_set", classNumDao.filter(school));
        req.setAttribute("subject_list", subjectDao.filter(school));
        req.setAttribute("ent_year_set", studentDao.filterEntYear(school));

        // ▼ 4. 入力チェック
        if (entYearStr == null || entYearStr.isEmpty() ||
            classNum == null || classNum.isEmpty() ||
            subjectCd == null || subjectCd.isEmpty() ||
            numStr == null || numStr.isEmpty()) {

            req.setAttribute("error", "入学年度とクラスと科目と回数を選択してください");
            req.getRequestDispatcher("/scoremanager/main/test_regist.jsp").forward(req, res);
            return;
        }

        int entYear = Integer.parseInt(entYearStr);
        int num = Integer.parseInt(numStr);

        // ▼ 5. 科目取得
        Subject subject = subjectDao.get(subjectCd, school);

        // ▼ 6. 学生一覧取得
        List<Student> studentList = studentDao.filter(school, entYear, classNum, true);

        if (studentList.isEmpty()) {
            req.setAttribute("error", "学生情報が存在しませんでした");
            req.getRequestDispatcher("/scoremanager/main/test_regist.jsp").forward(req, res);
            return;
        }

        // ▼ 7. 成績データ取得 or 新規作成
        TestDao testDao = new TestDao();
        List<Test> testList = new ArrayList<>();

        for (Student stu : studentList) {
            Test t = testDao.get(stu, subject, school, num);

            if (t == null) {
                t = new Test();
                t.setStudent(stu);
                t.setSubject(subject);
                t.setSchool(school);
                t.setClassNum(stu.getClassNum());
                t.setNo(num);
                t.setPoint(0);
            }

            testList.add(t);
        }

        // ▼ 8. 登録ボタン押下時
        if (req.getParameter("regist") != null) {

            for (Test t : testList) {
                String pointStr = req.getParameter("point_" + t.getStudent().getNo());

                if (pointStr == null || pointStr.isEmpty()) {
                    req.setAttribute("error", "点数を入力してください");
                    req.getRequestDispatcher("/scoremanager/main/test_regist.jsp").forward(req, res);
                    return;
                }

                int point = Integer.parseInt(pointStr);

                if (point < 0 || point > 100) {
                    req.setAttribute("error", "0〜100の範囲で入力してください");
                    req.getRequestDispatcher("/scoremanager/main/test_regist.jsp").forward(req, res);
                    return;
                }

                t.setPoint(point);
            }

            // ▼ 9. DB 保存
            testDao.save(testList);

            // ▼ 10. 完了画面へ
            req.getRequestDispatcher("/scoremanager/main/test_regist_done.jsp").forward(req, res);
            return;
        }

        // ▼ 11. 検索結果を JSP に渡す
        req.setAttribute("test_list", testList);
        req.setAttribute("ent_year", entYear);
        req.setAttribute("class_num", classNum);
        req.setAttribute("subject_cd", subjectCd);
        req.setAttribute("num", num);

        // ▼ 12. 検索結果表示
        req.getRequestDispatcher("/scoremanager/main/test_regist.jsp").forward(req, res);
    }
}
