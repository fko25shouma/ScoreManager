<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/header.jsp" />

<body>
    <jsp:include page="nav.jsp" />

    <div class="container mt-4">
        <h2 class="h3 mb-4 fw-normal bg-secondary bg-opacity-10 py-2 px-4">
            成績登録
        </h2>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

<form action="<%= request.getContextPath() %>/TestRegistExecute.action" method="post" class="card shadow-sm mb-4">
        <div class="card-body row g-3">

            <div class="col-md-2">
                <label class="form-label fw-bold">入学年度</label>
                <select name="ent_year" class="form-select">
                    <option value="">選択</option>
                    <c:forEach var="y" items="${ent_year_set}">
                        <option value="${y}" <c:if test="${y == ent_year}">selected</c:if>>${y}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="col-md-2">
                <label class="form-label fw-bold">クラス</label>
                <select name="class_num" class="form-select">
                    <option value="">選択</option>
                    <c:forEach var="c" items="${class_num_set}">
                        <option value="${c}" <c:if test="${c == class_num}">selected</c:if>>${c}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="col-md-2">
                <label class="form-label fw-bold">学生番号</label>
                <input type="text" name="student_no" class="form-control" placeholder="個別検索用" value="${student_no}">
            </div>

            <div class="col-md-3">
                <label class="form-label fw-bold">科目</label>
                <select name="subject_cd" class="form-select" required>
                    <option value="">選択</option>
                    <c:forEach var="s" items="${subject_list}">
                        <option value="${s.cd}" <c:if test="${s.cd == subject_cd}">selected</c:if>>${s.name}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="col-md-1">
                <label class="form-label fw-bold">回数</label>
                <select name="num" class="form-select">
                    <c:forEach var="n" begin="1" end="10">
                        <option value="${n}" <c:if test="${n == num}">selected</c:if>>${n}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="col-md-2 d-flex align-items-end">
                <button type="submit" class="btn btn-primary w-100">検索</button>
            </div>
        </div>
    </form>

        <c:if test="${not empty test_list}">
            <form action="TestRegistExecute.action" method="post">
                <%-- 検索条件を保持するための隠しパラメータ --%>
                <input type="hidden" name="ent_year" value="${ent_year}">
                <input type="hidden" name="class_num" value="${class_num}">
                <input type="hidden" name="subject_cd" value="${subject_cd}">
                <input type="hidden" name="num" value="${num}">
                <input type="hidden" name="student_no" value="${student_no}">
                <input type="hidden" name="regist" value="true">

                <div class="card shadow-sm">
                    <table class="table table-hover mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>学生番号</th>
                                <th>氏名</th>
                                <th style="width: 200px;">点数</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="t" items="${test_list}">
                                <tr class="align-middle">
                                    <td>${t.student.no}</td>
                                    <td>${t.student.name}</td>
                                    <td>
                                        <input type="number" name="point_${t.student.no}" 
                                               value="${t.point >= 0 ? t.point : ''}" 
                                               class="form-control" min="0" max="100">
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div class="card-footer text-end bg-white py-3">
                        <button type="submit" class="btn btn-success px-5">登録して終了</button>
                    </div>
                </div>
            </form>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
<jsp:include page="/footer.html" />