package scoremanager;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.School;
import bean.Teacher;
import dao.ClassNumDao;
import tool.Action;

public class StudentCreateAction extends Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // セッションからログインユーザー情報を取得
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");
        School school = teacher.getSchool();

        // 1. クラス一覧をDBから取得
        ClassNumDao cNumDao = new ClassNumDao();
        List<String> classNumSet = cNumDao.filter(school);

        // 2. 入学年度リストを生成（またはDBから取得）
        // 過去10年から来年までを選択肢とする例
        List<Integer> entYearSet = new ArrayList<>();
        int year = Calendar.getInstance().get(Calendar.YEAR);
        for (int i = year - 10; i <= year + 1; i++) {
            entYearSet.add(i);
        }
        // もしDBの既存データから年度を取得したい場合は以下を使用：
        // StudentDao sDao = new StudentDao();
        // List<Integer> entYearSet = sDao.filterEntYear(school);

        // 3. JSPにデータを渡す (名前をJSPのc:forEachと一致させる)
        request.setAttribute("ent_year_set", entYearSet);
        request.setAttribute("class_num_set", classNumSet);

        // JSPへフォワード
        request.getRequestDispatcher("student_create.jsp").forward(request, response);
    }
}