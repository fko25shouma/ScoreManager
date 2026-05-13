<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<body class="bg-light">

<jsp:include page="/header.jsp" />

<div class="container mt-4">

    <!-- タイトル -->
    <h2 class="h3 mb-4 fw-normal bg-secondary bg-opacity-10 py-2 px-4">
        学生情報変更
    </h2>

    <!-- ▼ エラーメッセージ -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="<%= request.getContextPath() %>/StudentUpdateExecute.action"
          method="post"
          class="card shadow-sm">

        <div class="card-body row g-3">

            <!-- 学生番号（変更不可） -->
            <div class="col-md-4">
                <label class="form-label fw-bold">学生番号</label>
                <input type="text" class="form-control" value="${student.no}" disabled>
                <input type="hidden" name="no" value="${student.no}">
            </div>

            <!-- 氏名 -->
            <div class="col-md-4">
                <label class="form-label fw-bold">氏名</label>
                <input type="text" name="name" class="form-control"
                       value="${student.name}">
                <c:if test="${not empty error_name}">
                    <div class="text-danger small">${error_name}</div>
                </c:if>
            </div>

            <!-- 入学年度 -->
            <div class="col-md-4">
                <label class="form-label fw-bold">入学年度</label>
                <select name="ent_year" class="form-select">
                    <option value="">選択</option>
                    <c:forEach var="y" items="${ent_year_set}">
                        <option value="${y}" <c:if test="${y == student.entYear}">selected</c:if>>
                            ${y}
                        </option>
                    </c:forEach>
                </select>
                <c:if test="${not empty error_ent_year}">
                    <div class="text-danger small">${error_ent_year}</div>
                </c:if>
            </div>

            <!-- クラス -->
            <div class="col-md-4">
                <label class="form-label fw-bold">クラス</label>
                <select name="class_num" class="form-select">
                    <option value="">選択</option>
                    <c:forEach var="c" items="${class_num_set}">
                        <option value="${c}" <c:if test="${c == student.classNum}">selected</c:if>>
                            ${c}
                        </option>
                    </c:forEach>
                </select>
                <c:if test="${not empty error_class_num}">
                    <div class="text-danger small">${error_class_num}</div>
                </c:if>
            </div>

            <!-- ボタン -->
            <div class="col-12 text-end mt-3">
                <button type="submit" class="btn btn-primary px-4">更新する</button>
                <a href="<%= request.getContextPath() %>/StudentList.action"
                   class="btn btn-secondary ms-2">戻る</a>
            </div>

        </div>

    </form>

</div>

<jsp:include page="/footer.html" />

</body>
