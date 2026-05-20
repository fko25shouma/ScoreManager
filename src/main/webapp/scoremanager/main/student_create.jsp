<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/header.jsp" />
<jsp:include page="nav.jsp" />
<div class="layout">

<body>
<section class="me-4">

    <h2 class="h3 mb-4 fw-normal bg-secondary bg-opacity-10 py-2 px-4 mt-3">
        学生情報登録
    </h2>

    <form action="StudentCreateExecute.action" method="post" class="px-4">

        <div class="mb-4">
            <label class="form-label fw-bold">入学年度</label>
            <select name="ent_year" class="form-select">
                <option value="">---------</option>
                <%-- 固定のループ処理を廃止し、データベースから取得した実データの一覧に切り替えます --%>
                <c:forEach var="year" items="${ent_year_set}">
                    <option value="${year}" ${ent_year == year ? "selected" : ""}>${year}</option>
                </c:forEach>
            </select>

            <c:if test="${not empty error_ent_year}">
                <div class="text-warning mt-1">${error_ent_year}</div>
            </c:if>
        </div>

        <div class="mb-4">
            <label class="form-label fw-bold">学生番号</label>
            <input type="text" name="no" class="form-control"
                   value="${no}" placeholder="学生番号を入力してください">

            <c:if test="${not empty error_no}">
                <div class="text-warning mt-1">${error_no}</div>
            </c:if>
        </div>

        <div class="mb-4">
            <label class="form-label fw-bold">氏名</label>
            <input type="text" name="name" class="form-control"
                   value="${name}" placeholder="氏名を入力してください">

            <c:if test="${not empty error_name}">
                <div class="text-warning mt-1">${error_name}</div>
            </c:if>
        </div>

        <div class="mb-4">
            <label class="form-label fw-bold">クラス</label>
            <select name="class_num" class="form-select">
                <option value="">---------</option>
                <c:forEach var="num" items="${class_num_set}">
                    <option value="${num}" ${class_num == num ? "selected" : ""}>${num}</option>
                </c:forEach>
            </select>

            <c:if test="${not empty error_class_num}">
                <div class="text-warning mt-1">${error_class_num}</div>
            </c:if>
        </div>

        <div class="mt-4">
            <button type="submit" class="btn btn-secondary px-4">登録</button>
            <a href="StudentList.action" class="btn btn-outline-secondary px-4 ms-2">戻る</a>
        </div>
    </form>
</section>
</body>
</div>
<jsp:include page="/footer.jsp" />