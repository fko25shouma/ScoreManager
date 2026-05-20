<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/header.jsp" />
<jsp:include page="nav.jsp" />

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
                <form action="TestListSubjectExecute.action" method="post">
                    <div class="row align-items-end">
                        <div class="col-md-3 mb-3">
                            <label class="form-label fw-bold">入学年度</label>
                            <select name="entYear" class="form-select">
                                <option value="">選択してください</option>
                                <%-- 固定のループ処理を撤去し、データベースから動的に取得した年度リストを展開します --%>
                                <c:forEach var="year" items="${ent_year_set}">
                                    <option value="${year}" ${entYear == year ? "selected" : ""}>${year}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="form-label fw-bold">クラス</label>
                            <select name="classNum" class="form-select">
                                <option value="">選択してください</option>
                                <c:forEach var="num" items="${class_num_set}">
                                    <option value="${num}" ${classNum == num ? "selected" : ""}>${num}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="form-label fw-bold">科目</label>
                            <select name="subjectCd" class="form-select">
                                <option value="">選択してください</option>
                                <c:forEach var="sub" items="${subjects}">
                                    <option value="${sub.cd}" ${subjectCd == sub.cd ? "selected" : ""}>${sub.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-3 mb-3">
                            <button type="submit" class="btn btn-secondary w-100">検索</button>
                        </div>
                    </div>
                </form>
            </div>

            <div class="tab-pane fade ${not empty student_no ? 'show active' : ''}" id="student-search">
                <form action="TestListStudentExecute.action" method="post">
                    <div class="row align-items-end">
                        <div class="col-md-9 mb-3">
                            <label class="form-label fw-bold">学生番号</label>
                            <input type="text" name="studentNo" class="form-control" value="${student_no}" placeholder="学生番号を入力してください">
                        </div>
                        <div class="col-md-3 mb-3">
                            <button type="submit" class="btn btn-secondary w-100">検索</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger mb-4">${error}</div>
    </c:if>

    <c:choose>
        <c:when test="${not empty list}">
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
</body>
</html>