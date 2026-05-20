package scoremanager;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.School;
import bean.Teacher;
import dao.ClassNumDao;
import dao.StudentDao;
import tool.Action;

public class StudentCreateAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");
        
        School school = null;
        if (teacher != null) {
            school = teacher.getSchool();
        } else {
            school = (School) session.getAttribute("school");
        }

        // データベースから本物のクラス一覧および入学年度一覧を取得します
        ClassNumDao cDao = new ClassNumDao();
        StudentDao sDao = new StudentDao();
        
        List<String> classList = cDao.filter(school);
        List<Integer> entYearList = sDao.filterEntYear(school);

        // JSPのプルダウン生成で使用できるようにリクエスト属性へ格納します
        request.setAttribute("class_num_set", classList);
        request.setAttribute("classList", classList);
        request.setAttribute("ent_year_set", entYearList);
        
        if (school != null) {
            request.setAttribute("school_cd", school.getCd());
        }
        
        request.getRequestDispatcher("student_create.jsp").forward(request, response);
    }
}