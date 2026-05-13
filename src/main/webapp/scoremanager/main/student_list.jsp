<%@page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/header.jsp" />

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

    <main class="container">
        <div class="row">
            <div class="col-12">
                <h2 class="h4 mb-4 pb-2 border-bottom">学生管理</h2>

                <div class="d-flex justify-content-end mb-3">
                    <a href="StudentCreate.action" class="btn btn-success">
                        <i class="bi bi-plus-lg"></i> 新規登録
                    </a>
                </div>

                <!-- 検索・フィルターエリア -->
                <div class="card shadow-sm mb-4">
                    <div class="card-body">
                        <form method="get">
                            <div class="row align-items-end g-3">
                                <div class="col-md-4">
                                    <label class="form-label fw-bold" for="student-f1-select">入学年度</label>
                                    <select class="form-select" id="student-f1-select" name="f1">
                                        <option value="0">選択してください</option>
                                        <c:forEach var="year" items="${ent_year_set}">
                                            <option value="${year}" <c:if test="${year==f1}">selected</c:if>>${year}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label fw-bold" for="student-f2-select">クラス</label>
                                    <select class="form-select" id="student-f2-select" name="f2">
                                        <option value="0">選択してください</option>
                                        <c:forEach var="num" items="${class_num_set}">
                                            <option value="${num}" <c:if test="${num.toString() eq f2}">selected</c:if>>${num}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-2 mb-2">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="student-f3-check" name="f3" value="t"
                                            <c:if test="${!empty f3}">checked</c:if>>
                                        <label class="form-check-label" for="student-f3-check">在学中</label>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <button class="btn btn-secondary w-100" id="filter-button">絞込み</button>
                                </div>
                            </div>
                            <c:if test="${not empty errors.get('f1')}">
                                <div class="mt-2 text-danger small">${errors.get("f1")}</div>
                            </c:if>
                        </form>
                    </div>
                </div>

                <!-- 結果一覧エリア -->
                <c:choose>
                    <c:when test="${students.size() > 0 }">
                        <div class="mb-2 text-muted">検索結果：<strong>${students.size()}</strong> 件</div>
                        <div class="card shadow-sm">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th>入学年度</th>
                                            <th>学生番号</th>
                                            <th>氏名</th>
                                            <th>クラス</th>
                                            <th class="text-center">在学中</th>
                                            <th class="text-center">操作</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="student" items="${students}">
                                            <tr class="align-middle">
                                                <td>${student.entYear}</td>
                                                <td>${student.no}</td>
                                                <td>${student.name}</td>
                                                <td>${student.classNum}</td>
                                                <td class="text-center">
                                                    <c:choose>
                                                        <c:when test="${student.isAttend()}">
                                                            <span class="badge bg-success">○</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary">×</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="text-center">
                                                    <a href="StudentUpdate.action?no=${student.no}" class="btn btn-sm btn-outline-primary">変更</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-info shadow-sm">学生情報が存在しませんでした。</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

<jsp:include page="/footer.jsp" />