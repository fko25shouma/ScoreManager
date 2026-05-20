package scoremanager;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.School;
import bean.Student;
import bean.Teacher;
import dao.ClassNumDao;
import dao.StudentDao;
import tool.Action;

public class StudentCreateExecuteAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");
        School school = (teacher != null) ? teacher.getSchool() : (School) session.getAttribute("school");

        String ent_year = request.getParameter("ent_year");
        String no = request.getParameter("no");
        String name = request.getParameter("name");
        String class_num = request.getParameter("class_num");
        
        StudentDao dao = new StudentDao();
        Student student = new Student();
        
        boolean hasError = false;

        if (ent_year == null || ent_year.isBlank()) {
            request.setAttribute("error_ent_year", "入学年度を選択してください");
            hasError = true;
        }

        if (no == null || no.isBlank()) {
            request.setAttribute("error_no", "学生番号を入力してください");
            hasError = true;
        }

        if (name == null || name.isBlank()) {
            request.setAttribute("error_name", "氏名を入力してください");
            hasError = true;
        }

        if (class_num == null || class_num.isBlank()) {
            request.setAttribute("error_class_num", "クラスを選択してください");
            hasError = true;
        }
        
        // 入力エラーにより自画面に戻る場合の再マッピング処理です
        if (hasError) {
            request.setAttribute("ent_year", ent_year);
            request.setAttribute("no", no);
            request.setAttribute("name", name);
            request.setAttribute("class_num", class_num);

            // 画面のセレクトボックス構造を維持するためデータを再充填します
            ClassNumDao cDao = new ClassNumDao();
            List<String> classList = cDao.filter(school);
            List<Integer> entYearList = dao.filterEntYear(school);
            
            request.setAttribute("class_num_set", classList);
            request.setAttribute("classList", classList);
            request.setAttribute("ent_year_set", entYearList);

            request.getRequestDispatcher("student_create.jsp").forward(request, response);
            return;
        }
        
        student.setSchool(school);
        student.setEntYear(Integer.parseInt(ent_year));
        student.setNo(no.trim());
        student.setName(name.trim());
        student.setClassNum(class_num.trim()); 
        student.setAttend(true);
        dao.save(student);
        
        request.getRequestDispatcher("student_create_done.jsp").forward(request, response);
    }
}