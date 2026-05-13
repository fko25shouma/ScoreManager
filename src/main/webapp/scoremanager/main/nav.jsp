<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- 現在のリクエストURLを取得して変数に格納 --%>
<c:set var="uri" value="${pageContext.request.requestURI}" />

<nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4 shadow-sm">
    <div class="container-fluid">
        <span class="navbar-brand fw-bold">得点管理システム</span>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav px-3">
                
                <li class="nav-item">
                    <a class="nav-link ${uri.contains('menu.jsp') || uri.contains('Menu.action') ? 'active fw-bold border-bottom' : ''}" 
                       href="Menu.action">ホーム</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link ${uri.contains('student') ? 'active fw-bold border-bottom' : ''}" 
                       href="StudentList.action">学生管理</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link ${uri.contains('test') ? 'active fw-bold border-bottom' : ''}" 
                       href="TestList.action">成績管理</a>
                </li>
                
                <li class="nav-item">
                    <a class="nav-link ${uri.contains('subject') ? 'active fw-bold border-bottom' : ''}" 
                       href="SubjectList.action">科目管理</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link ${uri.contains('class') ? 'active fw-bold border-bottom' : ''}" 
                       href="ClassList.action">クラス管理</a>
                </li>
                
                <li class="nav-item">
                    <a class="nav-link ${uri.contains('teacher') ? 'active fw-bold border-bottom' : ''}" 
                       href="TeacherList.action">ユーザ管理</a>
                </li>

                <c:choose>
                    <c:when test="${not empty loginUserName}">
                        <li class="nav-item ms-lg-3">
                            <span class="nav-link text-white-50 small">ようこそ、${loginUserName} 様</span>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="Logout.action">ログアウト</a>
                        </li>
                    </c:when>
                </c:choose>

            </ul>
        </div>
    </div>
</nav>

<style>
/* 現在のページをより目立たせるための追加スタイル */
.navbar-dark .navbar-nav .nav-link.active {
    color: #fff !important;
    border-bottom: 2px solid #fff; /* 白い下線を表示 */
    padding-bottom: 2px;
}
.nav-link {
    transition: all 0.3s;
    margin-right: 10px;
}
.nav-link:hover {
    background-color: rgba(255, 255, 255, 0.1);
    border-radius: 4px;
}
</style>