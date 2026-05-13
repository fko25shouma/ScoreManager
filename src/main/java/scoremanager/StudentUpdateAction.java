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

public class StudentUpdateAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");
        
        // 1. 変更したい学生の番号をリクエストから取得
        String no = request.getParameter("no");
        
        StudentDao sDao = new StudentDao();
        // 2. DBから現在の学生情報を取得
        Student student = sDao.get(no); 
        
        // 3. クラス一覧を取得（セレクトボックス用）
        ClassNumDao cDao = new ClassNumDao();
        List<String> list = cDao.filter(teacher.getSchool());

        if (student != null) {
            // 4. 取得したデータをリクエスト属性にセットしてJSPへ送る
            request.setAttribute("no", student.getNo());
            request.setAttribute("name", student.getName());
            request.setAttribute("ent_year", student.getEntYear());
            request.setAttribute("class_num", student.getClassNum());
            request.setAttribute("is_attend", student.isAttend());
            request.setAttribute("classList", list);
        }

        // 5. 変更画面（JSP）へフォワード
        request.getRequestDispatcher("student_update.jsp").forward(request, response);
    }
}