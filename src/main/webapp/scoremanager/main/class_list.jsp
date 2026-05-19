<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/header.jsp"/>
<jsp:include page="nav.jsp"/>
<!-- ▼ ナビバー -->
<body>


<!-- ▼ メインコンテンツ -->
<div class="container mt-4">

    <h2 class="h3 mb-4 fw-bord bg-secondary bg-opacity-10 py-2 px-4">
        クラス管理
    </h2>

    <!-- 新規登録カード -->
    <div class="row mb-4">
        <div class="col-md-12">
            <div class="card shadow-sm position-relative card-hover">
                <div class="card-body text-center">
                    <i class="bi bi-building-add fs-1 text-primary mb-2"></i>
                    <h5 class="card-title fw-bold">クラスを新規登録</h5>
                    <p class="card-text text-muted">新しいクラスを追加します</p>
                    <a href="class_create.jsp" class="stretched-link"></a>
                </div>
            </div>
        </div>
    </div>
	<c:if test="${not empty list}">
    <p class="text-muted mb-2">
        検索結果：${count} 件
    </p>
	</c:if>
    <!-- ▼ クラス一覧 -->
    <div class="card shadow-sm">
        <div class="card-body">

            <table class="table table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th>クラス番号</th>
                        <th style="width: 10%">変更</th>
                        <th style="width: 10%">削除</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="s" items="${list}">
                        <tr>
                            <td>${s}</td>
                            <td>
                                <a href="ClassUpdate.action?cd=${s}" class="text-primary fw-bold">変更</a>
                            </td>
                            <td>
                                <a href="ClassDelete.action?cd=${s}" class="text-danger fw-bold">削除</a>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty list}">
                        <tr>
                            <td colspan="3" class="text-center py-4 text-muted">
                                クラス情報が存在しませんでした。
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>

        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
<jsp:include page="/footer.jsp"/>
