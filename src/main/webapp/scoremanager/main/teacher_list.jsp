<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
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
        ユーザ管理
    </h2>

    <!-- 新規登録カード -->
    <div class="row mb-4">
        <div class="col-md-12">
            <div class="card shadow-sm position-relative card-hover">
                <div class="card-body text-center">
                    <i class="bi bi-person-plus-fill fs-1 text-primary mb-2"></i>
                    <h5 class="card-title fw-bold">ユーザを新規登録</h5>
                    <p class="card-text text-muted">新しいユーザを追加します</p>
                    <a href="teacher_create.jsp" class="stretched-link"></a>
                </div>
            </div>
        </div>
    </div>

    <!-- ▼ ユーザ一覧 -->
    <div class="card shadow-sm">
        <div class="card-body">

            <table class="table table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th style="width: 15%">ID</th>
                        <th>PASSWORD</th>
                        <th>NAME</th>
                        <th>SCHOOL_CD</th>
                        <th style="width: 10%">変更</th>
                        <th style="width: 10%">削除</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="s" items="${list}">
                        <tr>
                            <td>${s.id}</td>

                            <!-- パスワードは * で伏せる -->
                            <td>
                                <c:forEach begin="1" end="${fn:length(s.password)}">*</c:forEach>
                            </td>

                            <td>${s.name}</td>
                            <td>${s.school.cd}</td>

                            <td>
                                <a href="TeacherUpdate.action?id=${s.id}" class="text-primary fw-bold">変更</a>
                            </td>
                            <td>
                                <a href="TeacherDelete.action?id=${s.id}" class="text-danger fw-bold">削除</a>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty list}">
                        <tr>
                            <td colspan="6" class="text-center py-4 text-muted">
                                ユーザ情報が存在しませんでした。
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>

        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
<jsp:include page="/footer.jsp"/>
