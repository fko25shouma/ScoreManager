<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>成績登録完了</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

    <!-- ヘッダ -->
    <jsp:include page="/header.jsp" />
    <jsp:include page="/nav.jsp"/>

    <div class="d-flex">

       

        <!-- メインコンテンツ -->
        <main class="flex-grow-1 p-4" style="margin-left:220px;">

            <div class="container">

                <div class="card shadow-sm">
                    <div class="card-body text-center py-5">

                        <h2 class="mb-4">成績登録が完了しました</h2>

                        <p class="text-muted mb-4">
                            入力された成績は正常に保存されました。
                        </p>

                        <a href="<%= request.getContextPath() %>/scoremanager/main/menu.jsp"
                           class="btn btn-primary px-4">
                            トップに戻る
                        </a>

                    </div>
                </div>

            </div>

        </main>
    </div>

</body>
</html>
