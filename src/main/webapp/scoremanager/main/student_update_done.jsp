<%@page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="header.jsp" />
<body>
    <!-- ナビゲーションバー -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
        <div class="container-fluid">
            <span class="navbar-brand fw-bold">得点管理システム</span>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link" href="Menu.action">ホーム</a></li>
                    <li class="nav-item"><a class="nav-link active" href="StudentList.action">学生管理</a></li>
                    <li class="nav-item"><a class="nav-link" href="TestList.action">成績管理</a></li>
                    <li class="nav-item"><a class="nav-link" href="SubjectList.action">科目管理</a></li>
                    <li class="nav-item"><a class="nav-link" href="ClassList.action">クラス管理</a></li>
                    <li class="nav-item"><a class="nav-link" href="TeacherList.action">ユーザ管理</a></li>
                </ul>
            </div>
        </div>
    </nav>
<div class="layout">

    

    <main class="student-list-container">
        <h2>学生情報変更</h2>

        <p class="student-update-message">変更が完了しました</p>

        <ul class="student-update-menu">
            <li><a href="StudentList.action">学生一覧</a></li>
        </ul>
    </main>

</div> <jsp:include page="footer.jsp" />

