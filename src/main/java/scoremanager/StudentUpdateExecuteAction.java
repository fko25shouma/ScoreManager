package scoremanager;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.Student;
import bean.Teacher;
import dao.StudentDao;
import tool.Action;

public class StudentUpdateExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");
        StudentDao sDao = new StudentDao();

        // リクエストパラメータの取得
        String entYearStr = request.getParameter("ent_year");
        String no = request.getParameter("no");
        String name = request.getParameter("name");
        String classNum = request.getParameter("class_num");
        String isAttendStr = request.getParameter("is_attend"); 

        int entYear = Integer.parseInt(entYearStr);
        boolean isAttend = (isAttendStr != null);

        // 更新用エンティティデータの構築
        Student student = new Student();
        student.setNo(no != null ? no.trim() : "");
        student.setName(name);
        student.setEntYear(entYear);
        student.setClassNum(classNum != null ? classNum.trim() : "");
        student.setAttend(isAttend);
        student.setSchool(teacher.getSchool()); 

        // データベース更新
        boolean result = sDao.save(student);

        if (result) {
            // 【設計書準拠修正】
            // 不要なActionクラスを介さず、直接完了画面のJSPへフォワードする
            request.getRequestDispatcher("student_update_done.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "学生情報の更新に失敗しました。");
            request.getRequestDispatcher("student_update.jsp").forward(request, response);
        }
    }
}