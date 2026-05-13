package tool;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns={"*.action"})
public class FrontController extends HttpServlet {

	@Override
	public void doPost(
			HttpServletRequest request, HttpServletResponse response
		) throws ServletException, IOException {
			System.out.println("Frontcontroller!");
			PrintWriter out=response.getWriter();
	        try {
	            // ① リクエストされたURLのパスを取得
	            String path = request.getServletPath().substring(1);
	            // 例: "/chapter23/Search.action" → "chapter23/Search.action"

	            // ② パスをアクションクラス名の形式に変換
	            String name = path.replace(".a", "A").replace('/', '.');
	            // 例: "chapter23/Search.action" → "chapter23.SearchAction"

	            System.out.println("アクションクラス名 : " + name);
	            // ③ アクションクラスのインスタンスを動的に生成
	            Action action = (Action)Class.forName(name).
	                getDeclaredConstructor().newInstance();
	            // クラスを動的ロードし、コンストラクタを呼び出してインスタンスを作成

	            // ④ executeメソッドを実行し、フォワード先のURLを取得
	            String url = action.execute(request, response);
	            // 例: "/searchResult.jsp" など

	            // ⑤ 指定されたURLへフォワード
	            request.getRequestDispatcher(url).forward(request, response);

	        } catch (Exception e) {
	            e.printStackTrace(out); // エラー発生時はスタックトレースを出力
	        }
		}

	    /**
	     * GETリクエストの処理
	     * - doPostメソッドを呼び出して、POSTリクエストと同じ処理を実行
	     */
	public void doGet(
			HttpServletRequest request, HttpServletResponse response
		) throws ServletException, IOException {
			doPost(request, response);// GETリクエストもPOSTと同様に処理
		}
	}