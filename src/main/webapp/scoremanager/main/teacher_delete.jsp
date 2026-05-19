<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/header.jsp"/>
<jsp:include page="nav.jsp"/>
<body>


<!-- ▼ メインコンテンツ -->
<div class="container mt-4">

    <h2 class="h3 mb-4 fw-normal bg-secondary bg-opacity-10 py-2 px-4">
        ユーザ情報削除
    </h2>

    <div class="card shadow-sm">
        <div class="card-body text-center py-5">

            <i class="bi bi-exclamation-triangle-fill text-danger fs-1 mb-3"></i>

            <h4 class="fw-bold mb-3">本当に削除しますか？</h4>

            <p class="fs-5 mb-4">
                『${name}』を削除してもよろしいですか
            </p>

            <form action="TeacherDeleteExecute.action" method="post" class="mt-4">
                <input type="hidden" name="id" value="${id}">

                <div class="d-grid gap-3 col-6 mx-auto">
                    <button type="submit" class="btn btn-danger btn-lg w-100">削除する</button>
                    <a href="TeacherList.action" class="btn btn-secondary btn-lg w-100">戻る</a>
                </div>
            </form>

        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
<jsp:include page="/footer.jsp"/>
