package scoremanager;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import bean.ClassNum;
import bean.School;
import dao.ClassNumDao;
import tool.Action;

public class ClassCreateExecuteAction extends Action {
    
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

        // セッションからログイン中の学校情報を取得します
        HttpSession session = request.getSession();
        School school = (School) session.getAttribute("school");

        // 入力されたクラス番号をリクエストパラメータから取得します
        String cd = request.getParameter("cd");
        
        boolean hasError = false;
        
        // 入力値の必須チェックおよび文字数バリデーションを行います
        if (cd == null || cd.isEmpty()) {
            request.setAttribute("errorCd", "このフィールドを入力してください");
            hasError = true;
        } else if (cd.length() != 3) {
            request.setAttribute("errorCd", "クラス番号は3文字で入力してください");
            hasError = true;
        }
        
        // 既に同じクラス番号が登録されていないか重複チェックを行います
        ClassNumDao dao = new ClassNumDao();
        ClassNum exists = dao.get(cd, school);
        if (exists != null) {
            request.setAttribute("errorCd", "このクラス番号は既に登録されています");
            hasError = true;
        }
        
        // バリデーションエラーが検知された場合は入力画面へ戻します
        if (hasError) {
            request.setAttribute("cd", cd);
            request.setAttribute("school_cd", school.getCd());

            request.getRequestDispatcher("class_create.jsp").forward(request, response);
            return;
        }

        // 登録用エンティティに値をセットし、永続化層へ保存を依頼します
        ClassNum class_num = new ClassNum();
        class_num.setSchool(school);
        class_num.setClass_num(cd);
        
        // データの重複引き渡しを解消し、Beanのみを引数に指定して保存メソッドを呼び出します
        dao.save(class_num);

        // 登録完了画面へ遷移させます
        request.getRequestDispatcher("class_create_done.jsp").forward(request, response);
    }
}