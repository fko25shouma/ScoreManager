<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<jsp:include page="/header.jsp"/>
<jsp:include page="nav.jsp"/>
<body>

<!-- ▼ メインコンテンツ -->
<div class="container mt-4">

    <h2 class="h3 mb-4 bg-secondary bg-opacity-10 py-2 px-4">
        ユーザ管理
    </h2>
	

	
    <!-- 新規登録カード -->
    <div class="row mb-4">
        <div class="col-md-12">
            <div class="card shadow-sm position-relative card-hover">
                <div class="card-body text-center">
                    <i class="bi bi-person-plus-fill fs-1 text-primary mb-2"></i>
                    <h5 class="card-title fw-bold">ユーザを新規登録</h5>
                    <p class="card-text text-muted">新しいユーザを追加します</p>
                    <a href="teacher_create.jsp" class="stretched-link"></a>
                </div>
            </div>
        </div>
    </div>

	<!-- ▼ 検索フォーム -->
	<form action="TeacherList.action" method="get" class="row mb-4">
	    <div class="col-md-4">
	        <input type="text" name="keyword" class="form-control"
	               value="${param.keyword}" placeholder="ID または 氏名で検索">
	    </div>
	    <div class="col-md-2">
	        <button class="btn btn-primary w-100">検索</button>
	    </div>
	</form>
	<!-- ▼ 並び替え -->
	<div class="mb-3">
	    <a href="TeacherList.action?sort=id&keyword=${param.keyword}" class="me-3">ID順</a>
	    <a href="TeacherList.action?sort=name&keyword=${param.keyword}">名前順</a>
	</div>
	
	<c:if test="${not empty list}">
	    <p class="text-muted mb-2">
	        検索結果：${count} 件
	    </p>
	</c:if>
	
    <!-- ▼ ユーザ一覧 -->
    <div class="card shadow-sm">
        <div class="card-body">

            <table class="table table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th style="width: 15%">ID</th>
                        <th>PASSWORD</th>
                        <th>NAME</th>
                        <th>SCHOOL_CD</th>
                        <th style="width: 10%">変更</th>
                        <th style="width: 10%">削除</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="s" items="${list}">
                        <tr>
                            <td>${s.id}</td>

                            <!-- パスワードは * で伏せる -->
                            <td>
                                <c:forEach begin="1" end="${fn:length(s.password)}">*</c:forEach>
                            </td>

                            <td>${s.name}</td>
                            <td>${s.school.cd}</td>

                            <td>
                                <a href="TeacherUpdate.action?id=${s.id}" class="text-primary fw-bold">変更</a>
                            </td>
                            <td>
                                <a href="TeacherDelete.action?id=${s.id}" class="text-danger fw-bold">削除</a>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty list}">
                        <tr>
                            <td colspan="6" class="text-center py-4 text-muted">
                                ユーザ情報が存在しませんでした。
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
