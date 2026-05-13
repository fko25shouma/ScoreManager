<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/header.jsp"/>
<jsp:include page="nav.jsp"/>
<body>


<!-- ▼ メインコンテンツ -->
<div class="container mt-4">

    <h2 class="h3 mb-4 fw-normal bg-secondary bg-opacity-10 py-2 px-4">
        科目情報変更
    </h2>

    <div class="card shadow-sm">
        <div class="card-body px-4 py-4">

            <form action="SubjectUpdateExecute.action" method="post">

                <!-- 科目コード -->
                <div class="mb-4">
                    <label class="form-label fw-bold">科目コード</label>
                    <input type="text" class="form-control" value="${cd}" disabled>
                    <input type="hidden" name="cd" value="${cd}">

                    <c:if test="${not empty deleteerror}">
                        <div class="text-warning mt-2">${deleteerror}</div>
                    </c:if>
                </div>

                <!-- 科目名 -->
                <div class="mb-4">
                    <label class="form-label fw-bold">科目名</label>
                    <input type="text" name="name" class="form-control"
                           value="${name}" placeholder="科目名を入力してください">

                    <c:if test="${not empty error}">
                        <div class="text-warning mt-1">${error}</div>
                    </c:if>
                </div>

                <!-- ボタン（横いっぱい） -->
                <div class="mt-4 d-grid gap-3 col-6 mx-auto">
                    <button type="submit" class="btn btn-primary btn-lg w-100">変更</button>
                    <a href="SubjectList.action" class="btn btn-secondary btn-lg w-100">戻る</a>
                </div>

            </form>

        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
<jsp:include page="/footer.jsp"/>
