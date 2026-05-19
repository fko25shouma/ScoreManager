<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/header.jsp"/>
<jsp:include page="nav.jsp"/>
<body>

<!-- ▼ メインコンテンツ -->
<div class="container mt-4">

    <h2 class="h3 mb-4 fw-normal bg-secondary bg-opacity-10 py-2 px-4">
        クラス情報変更
    </h2>

    <div class="card shadow-sm">
        <div class="card-body px-4 py-4">

            <form action="ClassUpdateExecute.action" method="post">

                <!-- 変更前クラス番号 -->
                <div class="mb-4">
                    <label class="form-label fw-bold">変更前クラス番号</label>
                    <input type="text" class="form-control" value="${cd}" disabled>
                    <input type="hidden" name="cd" value="${cd}">

                    <c:if test="${not empty deleteerror}">
                        <%-- error.jspの埋め込む --%>
	                    <div class="text-warning mt-1">
		              		<jsp:include page="/error.jsp">
		                 	<jsp:param name="message" value="${deleteerror}" />
		               		</jsp:include>
	               		</div>
                    </c:if>
                </div>

                <!-- 変更後クラス番号 -->
                <div class="mb-4">
                    <label class="form-label fw-bold">変更後クラス番号</label>
                    <input type="text" name="newcd" class="form-control"
                           value="${newcd}" placeholder="クラス番号を入力してください">

                    <c:if test="${not empty error}">
                        <%-- error.jspの埋め込む --%>
                    <div class="text-warning mt-1">
	              		<jsp:include page="/error.jsp">
	                 	<jsp:param name="message" value="${error}" />
	               		</jsp:include>
               		</div>
                    </c:if>
                </div>

                <!-- ボタン（横いっぱい） -->
                <div class="mt-4 d-grid gap-3 col-6 mx-auto">
                    <button type="submit" class="btn btn-primary btn-lg w-100">変更</button>
                    <a href="ClassList.action" class="btn btn-secondary btn-lg w-100">戻る</a>
                </div>

            </form>

        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
<jsp:include page="/footer.jsp"/>
