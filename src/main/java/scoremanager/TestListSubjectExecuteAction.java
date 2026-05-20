package scoremanager;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.Subject;
import bean.Teacher;
import bean.TestListSubject;
import dao.StudentDao;
import dao.SubjectDao;
import dao.TestListSubjectDao;
import tool.Action;

public class TestListSubjectExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

        HttpSession session = req.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        if (teacher == null) {
            req.getRequestDispatcher("/scoremanager/main/login.jsp").forward(req, res);
            return;
        }

        String entYearStr = req.getParameter("entYear");
        if (entYearStr == null) entYearStr = req.getParameter("ent_year");

        String classNum = req.getParameter("classNum");
        if (classNum == null) classNum = req.getParameter("class_num");

        String subjectCd = req.getParameter("subjectCd");
        if (subjectCd == null) subjectCd = req.getParameter("subject_cd");

        try {
            if (entYearStr == null || entYearStr.isEmpty() || subjectCd == null || subjectCd.isEmpty()) {
                req.setAttribute("error", "必須項目（年度、クラス、科目）を選択してください");
                
                // 検索画面に戻る際、プルダウンが崩れないよう動的データを再セットします
                StudentDao sDao = new StudentDao();
                req.setAttribute("ent_year_set", sDao.filterEntYear(teacher.getSchool()));
                
                req.getRequestDispatcher("/scoremanager/main/test_list.jsp").forward(req, res);
                return;
            }

            int entYear = Integer.parseInt(entYearStr);

            SubjectDao subjectDao = new SubjectDao();
            Subject subject = subjectDao.get(subjectCd.trim(), teacher.getSchool());

            if (subject != null) {
                TestListSubjectDao dao = new TestListSubjectDao();
                List<TestListSubject> list = dao.filter(entYear, classNum.trim(), subject, teacher.getSchool());

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

        req.getRequestDispatcher("/scoremanager/main/test_list_subject.jsp").forward(req, res);
    }
}