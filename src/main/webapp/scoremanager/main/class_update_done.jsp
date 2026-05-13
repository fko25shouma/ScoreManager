<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/header.jsp"/>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
        <span class="navbar-brand fw-bold">得点管理システム</span>
        <div class="collapse navbar-collapse justify-content-end">
            <ul class="navbar-nav">

                <li class="nav-item"><a class="nav-link" href="Menu.action">ホーム</a></li>
                <li class="nav-item"><a class="nav-link" href="StudentList.action">学生管理</a></li>
                <li class="nav-item"><a class="nav-link" href="TestList.action">成績管理</a></li>
                                <li class="nav-item"><a class="nav-link" href="SubjectList.action">科目管理</a></li>
                <li class="nav-item"><a class="nav-link active" href="ClassList.action">クラス管理</a></li>
                <li class="nav-item"><a class="nav-link" href="TeacherList.action">ユーザ管理</a></li>

                <c:choose>
                    <c:when test="${not empty loginUserName}">
                        <li class="nav-item">
                            <span class="nav-link text-white">ようこそ、${loginUserName} 様</span>
                        </li>
                        <li class="nav-item"><a class="nav-link" href="Logout.action">ログアウト</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item"><a class="nav-link" href="Login.action">ログイン</a></li>
                    </c:otherwise>
                </c:choose>

            </ul>
        </div>
    </div>
</nav>

<!-- ▼ メインコンテンツ -->
<div class="container mt-4">

    <h2 class="h3 mb-4 fw-normal bg-secondary bg-opacity-10 py-2 px-4">
        クラス情報変更
    </h2>

    <div class="card shadow-sm">
        <div class="card-body text-center py-5">

            <i class="bi bi-check-circle-fill text-success fs-1 mb-3"></i>

            <h4 class="fw-bold mb-3">変更が完了しました</h4>

            <div class="d-grid gap-3 col-6 mx-auto mt-4">
                <a href="ClassList.action" class="btn btn-secondary btn-lg w-100">クラス一覧へ戻る</a>
            </div>

        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
<jsp:include page="/footer.jsp"/>