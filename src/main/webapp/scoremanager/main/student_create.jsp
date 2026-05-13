<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/header.jsp"/>

<body>
    <jsp:include page="nav.jsp" />

    <div class="container mt-4">
        <h2 class="h3 mb-4 fw-normal bg-secondary bg-opacity-10 py-2 px-4">
            学生情報登録
        </h2>

        <form action="StudentCreateExecute.action" method="post" class="px-4">

            <%-- 入学年度（データベースから取得したリストを使用） --%>
            <div class="mb-4">
                <label class="form-label fw-bold">入学年度</label>
                <select name="ent_year" class="form-select">
                    <option value="">---------</option>
                    <c:forEach var="year" items="${ent_year_set}">
                        <option value="${year}" <c:if test="${year == ent_year}">selected</c:if>>${year}</option>
                    </c:forEach>
                </select>

                <c:if test="${not empty error_ent_year}">
                    <div class="text-warning mt-1">${error_ent_year}</div>
                </c:if>
            </div>

            <%-- 学生番号 --%>
            <div class="mb-4">
                <label class="form-label fw-bold">学生番号</label>
                <input type="text" name="no" class="form-control"
                       value="${no}" placeholder="学生番号を入力してください">

                <c:if test="${not empty error_no}">
                    <div class="text-warning mt-1">${error_no}</div>
                </c:if>
            </div>

            <%-- 氏名 --%>
            <div class="mb-4">
                <label class="form-label fw-bold">氏名</label>
                <input type="text" name="name" class="form-control"
                       value="${name}" placeholder="氏名を入力してください">

                <c:if test="${not empty error_name}">
                    <div class="text-warning mt-1">${error_name}</div>
                </c:if>
            </div>

            <%-- クラス（データベースから取得したリストを使用） --%>
            <div class="mb-4">
                <label class="form-label fw-bold">クラス</label>
                <select name="class_num" class="form-select">
                    <option value="">---------</option>
                    <c:forEach var="c_num" items="${class_num_set}">
                        <option value="${c_num}" <c:if test="${c_num == class_num}">selected</c:if>>${c_num}</option>
                    </c:forEach>
                </select>

                <c:if test="${not empty error_class_num}">
                    <div class="text-warning mt-1">${error_class_num}</div>
                </c:if>
            </div>

            <div class="mt-4">
                <button type="submit" class="btn btn-primary px-4">登録して終了</button>
                <a href="StudentList.action" class="btn btn-secondary px-4 ms-2">戻る</a>
            </div>

        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

<jsp:include page="/footer.html"/>