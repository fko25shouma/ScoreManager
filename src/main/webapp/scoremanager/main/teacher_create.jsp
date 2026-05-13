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
                <li class="nav-item"><a class="nav-link" href="ClassList.action">クラス管理</a></li>
                <li class="nav-item"><a class="nav-link active" href="TeacherList.action">ユーザ管理</a></li>

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
        ユーザ情報登録
    </h2>

    <div class="card shadow-sm">
        <div class="card-body px-4 py-4">

            <form action="TeacherCreateExecute.action" method="post">

                <!-- ID -->
                <div class="mb-4">
                    <label class="form-label fw-bold">ID</label>
                    <input type="text" name="id" class="form-control"
                           value="${id}" placeholder="IDを入力してください">

                    <c:if test="${not empty errorId}">
                        <div class="text-warning mt-1">${errorId}</div>
                    </c:if>
                </div>

                <!-- PASSWORD -->
                <div class="mb-4">
                    <label class="form-label fw-bold">PASSWORD</label>
                    <input type="password" name="password" class="form-control"
                           value="${password}" placeholder="PASSWORDを入力してください">

                    <c:if test="${not empty errorPass}">
                        <div class="text-warning mt-1">${errorPass}</div>
                    </c:if>
                </div>

                <!-- PASSWORD(確認) -->
                <div class="mb-4">
                    <label class="form-label fw-bold">PASSWORD（確認）</label>
                    <input type="password" name="password2" class="form-control"
                           value="${password2}" placeholder="PASSWORD（確認）を入力してください">

                    <c:if test="${not empty errorPass2}">
                        <div class="text-warning mt-1">${errorPass2}</div>
                    </c:if>
                </div>

                <!-- 氏名 -->
                <div class="mb-4">
                    <label class="form-label fw-bold">氏名</label>
                    <input type="text" name="name" class="form-control"
                           value="${name}" placeholder="氏名を入力してください">

                    <c:if test="${not empty errorName}">
                        <div class="text-warning mt-1">${errorName}</div>
                    </c:if>
                </div>

                <!-- ボタン（横いっぱい） -->
                <div class="mt-4 d-grid gap-3 col-6 mx-auto">
                    <button type="submit" class="btn btn-primary btn-lg w-100">登録</button>
                    <a href="TeacherList.action" class="btn btn-secondary btn-lg w-100">戻る</a>
                </div>

            </form>

        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
<jsp:include page="/footer.jsp"/>
