package scoremanager;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.Student;
import bean.Teacher;
import dao.ClassNumDao;
import dao.StudentDao;
import tool.Action;

public class StudentListAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // ▼ ログインチェック（チーム仕様と統一）
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");
        if (teacher == null || !teacher.isAuthenticated()) {
            request.getRequestDispatcher("/scoremanager/main/login.jsp")
                   .forward(request, response);
            return;
        }
        

        // ▼ パラメータ取得
        String entYearStr = request.getParameter("f1");
        String classNum = request.getParameter("f2");
        String isAttendStr = request.getParameter("f3");

        if (classNum == null) classNum = "0";

        int entYear = 0;
        boolean isAttend = (isAttendStr != null);

        StudentDao sDao = new StudentDao();
        ClassNumDao cDao = new ClassNumDao();

        // ▼ プルダウン用データ
        List<Integer> entYearSet = sDao.filterEntYear(teacher.getSchool());
        List<String> classNumSet = cDao.filter(teacher.getSchool());

        // ▼ 学生一覧取得
        List<Student> students = null;

        if (entYearStr != null && !entYearStr.equals("0")) {
            entYear = Integer.parseInt(entYearStr);
        }

        if (entYear != 0 && !classNum.equals("0")) {
            students = sDao.filter(teacher.getSchool(), entYear, classNum, isAttend);

        } else if (entYear != 0) {
            students = sDao.filter(teacher.getSchool(), entYear, isAttend);

        } else {
            // クラス番号だけ or 全件 → 全件扱い
            students = sDao.filter(teacher.getSchool(), isAttend);
        }


        // ▼ JSP へ渡す
        request.setAttribute("f1", entYear);
        request.setAttribute("f2", classNum);
        request.setAttribute("f3", isAttendStr);
        request.setAttribute("ent_year_set", entYearSet);
        request.setAttribute("class_num_set", classNumSet);
        request.setAttribute("students", students);

        request.getRequestDispatcher("/scoremanager/main/student_list.jsp")
               .forward(request, response);
    }
}
