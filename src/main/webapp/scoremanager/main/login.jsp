<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>ログイン - 得点管理システム</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #0d6efd 0%, #4dabf7 100%);
            min-height: 100vh;
        }

        .login-wrapper {
            max-width: 420px;
            width: 100%;
        }

        .login-card {
            border-radius: 12px;
            padding: 32px;
        }

        .system-title {
            font-size: 26px;
            font-weight: 800;
            color: #0d6efd;
        }

        .login-title {
            font-size: 20px;
            font-weight: 700;
        }

        .form-control {
            height: 48px;
            font-size: 15px;
        }

        .btn-login {
            height: 48px;
            font-size: 16px;
            font-weight: bold;
        }

        .card-shadow {
            box-shadow: 0 8px 24px rgba(0,0,0,0.15);
        }
    </style>
</head>

<body>

<!-- ▼ ログアウト後メッセージ -->
<c:if test="${not empty logoutMessage}">
    <div class="alert alert-info text-center m-0 rounded-0">
        ${logoutMessage}
    </div>
</c:if>

<!-- ▼ ログインカード中央配置 -->
<div class="container d-flex justify-content-center align-items-center" style="min-height: 100vh;">

    <div class="login-wrapper">

        <div class="card login-card card-shadow">

            <!-- システム名 -->
            <h1 class="text-center mb-3 system-title">得点管理システム</h1>

            <!-- ログインタイトル -->
            <h2 class="text-center login-title mb-4">ログイン</h2>

            <!-- ▼ ログインエラー -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger text-center">${error}</div>
            </c:if>

            <form action="LoginExecute.action" method="post">

                <div class="mb-3">
                    <label class="form-label fw-bold">ID</label>
                    <input type="text"
                           name="id"
                           class="form-control"
                           placeholder="IDを入力"
                           value="${id}">
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">パスワード</label>
                    <input type="password"
                           name="password"
                           id="password"
                           class="form-control"
                           placeholder="パスワードを入力">
                </div>

                <div class="form-check mb-3">
                    <input type="checkbox" id="showPass" class="form-check-input">
                    <label for="showPass" class="form-check-label">パスワードを表示</label>
                </div>

                <button type="submit" class="btn btn-primary w-100 btn-login">
                    ログイン
                </button>

            </form>

        </div>

    </div>

</div>

<script>
document.getElementById("showPass").addEventListener("change", function() {
    const pw = document.getElementById("password");
    pw.type = this.checked ? "text" : "password";
});
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
