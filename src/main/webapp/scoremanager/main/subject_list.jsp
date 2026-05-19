<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/header.jsp"/>
<jsp:include page="nav.jsp"/>
<body>


<!-- ▼ メインコンテンツ -->
<div class="container mt-4">

    <h2 class="h3 mb-4 fw-bord bg-secondary bg-opacity-10 py-2 px-4">科目管理</h2>

    <!-- 新規登録カード -->
    <div class="row mb-4">
	    <div class="col-md-12">
	        <div class="card shadow-sm position-relative card-hover">
	            <div class="card-body text-center">
	            	<i class="bi bi-pencil fs-1 text-primary mb-2"></i>
	                <h5 class="card-title fw-bold">科目を新規登録</h5>
	                <p class="card-text text-muted">新しい科目を追加します</p>
	                <a href="subject_create.jsp" class="stretched-link"></a>
	            </div>
	        </div>
	    </div>
	</div>
	
	<form action="SubjectList.action" method="get" class="row mb-4">
	    <div class="col-md-4">
	        <input type="text" name="keyword" class="form-control"
	               value="${param.keyword}" placeholder="科目コード または 科目名で検索">
	    </div>
	    <div class="col-md-2">
	        <button class="btn btn-primary w-100">検索</button>
	    </div>
	</form>
	
	<c:if test="${not empty list}">
	    <p class="text-muted mb-2">
	        検索結果：${count} 件
	    </p>
	</c:if>
	


    <!-- ▼ 科目一覧 -->
    <div class="card shadow-sm">
        <div class="card-body">

            <form action="SubjectMultiDelete.action" method="post" id="multiDeleteForm">

			    <table class="table table-hover align-middle">
			        <thead class="table-light">
			            <tr>
			                <th style="width:5%">
			                    <input type="checkbox" id="checkAll">
			                </th>
			                <th style="width:20%">科目コード</th>
			                <th>科目名</th>
			                <th style="width:10%">変更</th>
			                <th style="width:10%">削除</th>
			            </tr>
			        </thead>
			
			        <tbody>
			            <c:forEach var="s" items="${list}">
			                <tr>
			                    <td>
			                        <input type="checkbox" name="cdList" value="${s.cd}">
			                    </td>
			                    <td>${s.cd}</td>
			                    <td>${s.name}</td>
			                    <td><a href="SubjectUpdate.action?cd=${s.cd}" class="text-primary fw-bold">変更</a></td>
			                    <td><a href="SubjectDelete.action?cd=${s.cd}" class="text-danger fw-bold">削除</a></td>
			                </tr>
			            </c:forEach>
			
			            <c:if test="${empty list}">
			                <tr>
			                    <td colspan="5" class="text-center py-4 text-muted">
			                        科目情報が存在しませんでした。
			                    </td>
			                </tr>
			            </c:if>
			        </tbody>
			    </table>
			
			    <div class="text-end mt-3">
			        <button type="submit" class="btn btn-danger">
			            選択した科目を削除
			        </button>
			    </div>
			
			</form>

        </div>
    </div>

</div>
</body>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<jsp:include page="/footer.jsp"/>
