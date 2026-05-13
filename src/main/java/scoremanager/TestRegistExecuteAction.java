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
        Teacher teacher = (Teacher) req.getSession().getAttribute("user");
        if (teacher == null) {
            req.getRequestDispatcher("/scoremanager/main/login.jsp").forward(req, res);
            return;
        }
        School school = teacher.getSchool();

        // 1. パラメータ取得
        String entYearStr = req.getParameter("ent_year");
        String classNum = req.getParameter("class_num");
        String subjectCd = req.getParameter("subject_cd");
        String numStr = req.getParameter("num");
        String studentNo = req.getParameter("student_no");

        // 空白除去（CHAR型対策）
        if (studentNo != null) studentNo = studentNo.trim();
        if (classNum != null) classNum = classNum.trim();
        if (subjectCd != null) subjectCd = subjectCd.trim();

        // 2. プルダウン用データの再セット
        ClassNumDao classNumDao = new ClassNumDao();
        SubjectDao subjectDao = new SubjectDao();
        StudentDao studentDao = new StudentDao();
        req.setAttribute("class_num_set", classNumDao.filter(school));
        req.setAttribute("subject_list", subjectDao.filter(school));
        req.setAttribute("ent_year_set", studentDao.filterEntYear(school));

        // 3. 必須チェック
        if (subjectCd == null || subjectCd.isEmpty() || numStr == null || numStr.isEmpty()) {
            req.setAttribute("error", "科目と回数を選択してください");
            req.getRequestDispatcher("/scoremanager/main/test_regist.jsp").forward(req, res);
            return;
        }

        int num = Integer.parseInt(numStr);
        Subject subject = subjectDao.get(subjectCd, school);
        List<Student> studentList = new ArrayList<>();

        // 4. 検索
        if (studentNo != null && !studentNo.isEmpty()) {
            // 学生番号による個別検索
            Student student = studentDao.get(studentNo);
            // 自校の学生かどうか判定（TRIM対応したDAOを使用）
            if (student != null && student.getSchool().getCd().equals(school.getCd().trim())) {
                studentList.add(student);
            } else {
                req.setAttribute("error", "学生番号（" + studentNo + "）は見つかりませんでした。");
            }
        } else if (entYearStr != null && !entYearStr.isEmpty() && classNum != null && !classNum.isEmpty()) {
            // 年度とクラスによる一括検索
            int entYear = Integer.parseInt(entYearStr);
            studentList = studentDao.filter(school, entYear, classNum, true);
            if (studentList.isEmpty()) {
                req.setAttribute("error", "条件に一致する学生が存在しません。");
            }
        } else {
            req.setAttribute("error", "入学年度とクラス、または学生番号を入力してください。");
        }

        // 5. 成績データの準備
        TestDao testDao = new TestDao();
        List<Test> testList = new ArrayList<>();
        if (!studentList.isEmpty()) {
            testList = testDao.list(studentList, subject, school, num);
        }

        // 6. 保存処理
        if (req.getParameter("regist") != null && !testList.isEmpty()) {
            for (Test t : testList) {
                String pStr = req.getParameter("point_" + t.getStudent().getNo());
                if (pStr != null && !pStr.isEmpty()) {
                    try {
                        int point = Integer.parseInt(pStr);
                        if (point >= 0 && point <= 100) {
                            t.setPoint(point);
                        } else {
                            req.setAttribute("error", "点数は0〜100の間で入力してください。");
                            req.getRequestDispatcher("/scoremanager/main/test_regist.jsp").forward(req, res);
                            return;
                        }
                    } catch (NumberFormatException e) {
                        req.setAttribute("error", "点数には数字を入力してください。");
                        req.getRequestDispatcher("/scoremanager/main/test_regist.jsp").forward(req, res);
                        return;
                    }
                }
            }
            testDao.save(testList);
            req.getRequestDispatcher("/scoremanager/main/test_regist_done.jsp").forward(req, res);
            return;
        }

        // 7. JSPへの値セット
        req.setAttribute("test_list", testList);
        req.setAttribute("ent_year", entYearStr);
        req.setAttribute("class_num", classNum);
        req.setAttribute("subject_cd", subjectCd);
        req.setAttribute("num", num);
        req.setAttribute("student_no", studentNo);

        req.getRequestDispatcher("/scoremanager/main/test_regist.jsp").forward(req, res);
    }
}