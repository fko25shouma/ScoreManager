<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログイン｜得点管理システム</title>
<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/login.css">

<script>
function togglePassword() {
    const pw = document.getElementById("password");
    pw.type = pw.type === "password" ? "text" : "password";
}
</script>

</head>
<body>

<div class="header">得点管理システム</div>

<div class="container">

    <h2>ログイン</h2>

    <!-- エラーメッセージ -->
    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <form action="LoginExecute.action" method="post">

        <label>ID</label>
        <input type="text" name="id" value="${param.id}">

        <label>パスワード</label>
        <input type="password" id="password" name="password">

        <div class="show-pass">
            <input type="checkbox" onclick="togglePassword()"> パスワードを表示
        </div>

        <button class="btn-login">ログイン</button>

    </form>
</div>

<div class="footer">© 2023 TIC 大原学園</div>

</body>
</html>
