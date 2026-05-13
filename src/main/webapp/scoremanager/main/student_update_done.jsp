<%@ page contentType="text/html; charset=UTF-8" %>

<body class="bg-light">

<jsp:include page="/header.jsp" />

<div class="container mt-4">

    <h2 class="h3 mb-4 fw-normal bg-secondary bg-opacity-10 py-2 px-4">
        学生情報変更完了
    </h2>

    <div class="alert alert-success">
        学生情報の更新が完了しました。
    </div>

    <div class="text-end mt-4">
        <a href="<%= request.getContextPath() %>/StudentList.action"
           class="btn btn-primary">学生一覧へ戻る</a>
    </div>

</div>

<jsp:include page="/footer.html" />

</body>
