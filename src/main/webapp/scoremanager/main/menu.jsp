<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>得点管理システム - メインメニュー</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

    <!-- ▼ カードホバー効果 -->
    <style>
        .card-hover {
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            cursor: pointer;
        }
        .card-hover:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 18px rgba(0,0,0,0.15);
        }
        .card-hover i {
            transition: 0.2s;
        }
        .card-hover:hover i {
            transform: scale(1.15);
        }
    </style>
</head>

<body class="bg-light">

<!-- ナビバー -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
        <span class="navbar-brand fw-bold">得点管理システム</span>
        <div class="collapse navbar-collapse justify-content-end">
            <ul class="navbar-nav">

                <li class="nav-item">
                    <a class="nav-link active" href="Menu.action">ホーム</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="StudentList.action">学生管理</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="TestList.action">成績管理</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="ClassList.action">クラス管理</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="SubjectList.action">科目管理</a>
                </li>

                <!-- ▼ ログイン状態で表示切替 -->
                <c:choose>
                    <c:when test="${not empty loginUserName}">
                        <li class="nav-item">
                            <span class="nav-link text-white">ようこそ、${loginUserName} 様</span>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<%= request.getContextPath() %>/Logout.action">ログアウト</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link" href="<%= request.getContextPath() %>/Login.action">ログイン</a>
                        </li>
                    </c:otherwise>
                </c:choose>

            </ul>
        </div>
    </div>
</nav>

<!-- ▼ ログアウト後メッセージ -->
<c:if test="${not empty logoutMessage}">
    <div class="alert alert-info text-center m-0">
        ${logoutMessage}
    </div>
</c:if>

<!-- メインコンテンツ -->
<div class="container mt-4">

    <h2 class="h3 mb-4 fw-normal bg-secondary bg-opacity-10 py-2 px-4">メインメニュー</h2>

    <div class="row g-3 mb-4">

        <!-- ▼ 学生管理 -->
        <div class="col-md-6">
            <div class="card shadow-sm position-relative card-hover">
                <div class="card-body text-center">
                    <i class="bi bi-people-fill fs-1 text-primary mb-2"></i>
                    <h5 class="card-title fw-bold">学生管理</h5>
                    <p class="card-text text-muted">学生情報の一覧・登録</p>
                    <a href="StudentList.action" class="stretched-link"></a>
                </div>
            </div>
        </div>

        <!-- ▼ 成績登録 -->
        <div class="col-md-6">
            <div class="card shadow-sm position-relative card-hover">
                <div class="card-body text-center">
                    <i class="bi bi-pencil-square fs-1 text-primary mb-2"></i>
                    <h5 class="card-title fw-bold">成績登録</h5>
                    <p class="card-text text-muted">学生の成績を登録</p>
                    <a href="TestRegist.action" class="stretched-link"></a>
                </div>
            </div>
        </div>

        <!-- ▼ 成績参照 -->
        <div class="col-md-6">
            <div class="card shadow-sm position-relative card-hover">
                <div class="card-body text-center">
                    <i class="bi bi-clipboard-data fs-1 text-primary mb-2"></i>
                    <h5 class="card-title fw-bold">成績参照</h5>
                    <p class="card-text text-muted">成績を検索・確認</p>
                    <a href="TestList.action" class="stretched-link"></a>
                </div>
            </div>
        </div>

        <!-- ▼ クラス管理 -->
        <div class="col-md-6">
            <div class="card shadow-sm position-relative card-hover">
                <div class="card-body text-center">
                    <i class="bi bi-building fs-1 text-primary mb-2"></i>
                    <h5 class="card-title fw-bold">クラス管理</h5>
                    <p class="card-text text-muted">クラス情報の一覧・追加</p>
                    <a href="ClassList.action" class="stretched-link"></a>
                </div>
            </div>
        </div>

        <!-- ▼ 科目管理 -->
        <div class="col-md-6">
            <div class="card shadow-sm position-relative card-hover">
                <div class="card-body text-center">
                    <i class="bi bi-book fs-1 text-primary mb-2"></i>
                    <h5 class="card-title fw-bold">科目管理</h5>
                    <p class="card-text text-muted">科目一覧・追加・編集</p>
                    <a href="SubjectList.action" class="stretched-link"></a>
                </div>
            </div>
        </div>

        <!-- ▼ ユーザ管理 -->
        <div class="col-md-6">
            <div class="card shadow-sm position-relative card-hover">
                <div class="card-body text-center">
                    <i class="bi bi-person-gear fs-1 text-primary mb-2"></i>
                    <h5 class="card-title fw-bold">ユーザ管理</h5>
                    <p class="card-text text-muted">ユーザ一覧・追加・編集</p>
                    <a href="TeacherList.action" class="stretched-link"></a>
                </div>
            </div>
        </div>

    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
