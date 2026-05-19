package scoremanager;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.Student;
import bean.Teacher;
import bean.TestListStudent;
import dao.StudentDao;
import dao.TestListStudentDao;

@WebServlet("/scoremanager/main/TestListStudentExecute.action")
public class TestListStudentExecuteAction extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        if (teacher == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String studentNo = req.getParameter("studentNo");

        try {
            // 学生の存在を確認
            StudentDao sDao = new StudentDao();
            Student student = sDao.get(studentNo);

            if (student != null) {
                // 学生が存在する場合、成績一覧（科目横断）を取得
                TestListStudentDao dao = new TestListStudentDao();
                List<TestListStudent> list = dao.filter(student);
                
                // ==================================================
                // ▼ ここから追加：複数回ある科目の平均点計算ロジック ▼
                // ==================================================
                java.util.Map<String, Integer> sumMap = new java.util.LinkedHashMap<>();
                java.util.Map<String, Integer> countMap = new java.util.LinkedHashMap<>();

                // 科目ごとの合計点と回数を集計
                for (TestListStudent t : list) {
                    String subjectName = t.getSubjectName();
                    sumMap.put(subjectName, sumMap.getOrDefault(subjectName, 0) + t.getPoint());
                    countMap.put(subjectName, countMap.getOrDefault(subjectName, 0) + 1);
                }

                // 2回以上テストがある科目だけ平均を計算
                java.util.Map<String, String> avgMap = new java.util.LinkedHashMap<>();
                for (String subjectName : countMap.keySet()) {
                    int count = countMap.get(subjectName);
                    if (count > 1) {
                        double avg = (double) sumMap.get(subjectName) / count;
                        // 小数点第1位までにフォーマットして格納
                        avgMap.put(subjectName, String.format("%.1f", avg));
                    }
                }
                // 計算結果をJSPへ渡す
                req.setAttribute("avg_map", avgMap);
                // ==================================================
                // ▲ 追加ここまで ▲
                // ==================================================

                req.setAttribute("student", student);
                req.setAttribute("list", list);
            } else {
                req.setAttribute("error", "学生情報が見つかりませんでした");
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "システムエラーが発生しました");
        }

        // パス構成：webapp/scoremanager/main/test_list_student.jsp
        req.getRequestDispatcher("/scoremanager/main/test_list_student.jsp").forward(req, resp);
    }
}