<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/header.jsp" />
<jsp:include page="nav.jsp"/>

<body>
<div class="container mt-4">
    <h2 class="h3 mb-4 fw-normal bg-secondary bg-opacity-10 py-2 px-4">
        成績参照
    </h2>

    <div class="card shadow-sm mb-4">
        <div class="card-header bg-white border-bottom-0 pt-3">
            <ul class="nav nav-tabs card-header-tabs" id="searchTab" role="tablist">
                <li class="nav-item">
                    <button class="nav-link ${empty student_no ? 'active' : ''}" id="subject-tab" data-bs-toggle="tab" data-bs-target="#subject-search" type="button">科目別参照</button>
                </li>
                <li class="nav-item">
                    <button class="nav-link ${not empty student_no ? 'active' : ''}" id="student-tab" data-bs-toggle="tab" data-bs-target="#student-search" type="button">学生別参照</button>
                </li>
            </ul>
        </div>
        <div class="card-body tab-content">
            <div class="tab-pane fade ${empty student_no ? 'show active' : ''}" id="subject-search">
                <form action="TestListSubjectExecute.action" method="post" class="row g-3">
                    <div class="col-md-3">
                        <label class="form-label fw-bold">入学年度</label>
                        <select name="entYear" class="form-select" required>
                            <option value="">選択してください</option>
                            <c:forEach var="y" items="${ent_year_set}">
                                <option value="${y}" <c:if test="${y == ent_year}">selected</c:if>>${y}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-bold">クラス</label>
                        <select name="classNum" class="form-select" required>
                            <option value="">選択してください</option>
                            <c:forEach var="c" items="${class_num_set}">
                                <option value="${c}" <c:if test="${c == class_num}">selected</c:if>>${c}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-bold">科目</label>
                        <select name="subjectCd" class="form-select" required>
                            <option value="">選択してください</option>
                            <c:forEach var="s" items="${subject_list}">
                                <option value="${s.cd}" <c:if test="${s.cd == subject_cd}">selected</c:if>>${s.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-2 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary w-100">検索</button>
                    </div>
                </form>
            </div>

            <div class="tab-pane fade ${not empty student_no ? 'show active' : ''}" id="student-search">
                <form action="TestListStudentExecute.action" method="post" class="row g-3">
                    <div class="col-md-10">
                        <label class="form-label fw-bold">学生番号</label>
                        <input type="text" name="studentNo" class="form-control" placeholder="学生番号を入力してください" value="${student_no}" required>
                    </div>
                    <div class="col-md-2 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary w-100">検索</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <c:choose>
        <%-- 科目別一覧 (TestListSubjectExecuteAction からの結果) --%>
        <c:when test="${not empty list && not empty list[0].points}">
            <div class="card shadow-sm overflow-auto">
                <table class="table table-bordered table-hover mb-0">
                    <thead class="table-light text-center align-middle">
                        <tr>
                            <th>学生番号</th>
                            <th>氏名</th>
                            <th>クラス</th>
                            <c:forEach var="i" begin="1" end="10">
                                <th style="min-width: 55px;">${i}回</th>
                            </c:forEach>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="row" items="${list}">
                            <tr class="align-middle text-center">
                                <td>${row.studentNo}</td>
                                <td class="text-start">${row.studentName}</td>
                                <td>${row.classNum}</td>
                                <c:forEach var="i" begin="1" end="10">
                                    <td class="text-end">
                                        <c:choose>
                                            <c:when test="${row.points[i] >= 0}">${row.points[i]}</c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
                                </c:forEach>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:when>

        <%-- 学生別一覧 (TestListStudentExecuteAction からの結果) --%>
        <c:when test="${not empty list && empty list[0].points}">
            <div class="card shadow-sm">
                <table class="table table-hover mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>科目名</th>
                            <th>科目コード</th>
                            <th class="text-center">回数</th>
                            <th class="text-end px-4">点数</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="row" items="${list}">
                            <tr>
                                <td>${row.subjectName}</td>
                                <td>${row.subjectCd}</td>
                                <td class="text-center">${row.num}回</td>
                                <td class="text-end px-4">${row.point}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:when>
        
        <%-- 結果がない場合 --%>
        <c:otherwise>
            <div class="alert alert-info">検索条件を指定して「検索」ボタンを押してください。</div>
        </c:otherwise>
    </c:choose>

    <div class="mt-4 text-end">
        <a href="Menu.action" class="btn btn-secondary px-4">
            メニューへ戻る
        </a>
    </div>
</div>

<jsp:include page="/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>