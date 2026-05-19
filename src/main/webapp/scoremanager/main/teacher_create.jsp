<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/header.jsp"/>
<jsp:include page="nav.jsp"/>
<body>


<!-- ▼ メインコンテンツ -->
<div class="container mt-4">

    <h2 class="h3 mb-4 fw-normal bg-secondary bg-opacity-10 py-2 px-4">
        ユーザ情報登録
    </h2>

    <div class="card shadow-sm">
        <div class="card-body px-4 py-4">

            <form action="TeacherCreateExecute.action" method="post">

                <!-- ID -->
                <div class="mb-4">
                    <label class="form-label fw-bold">ID</label>
                    <input type="text" name="id" class="form-control"
                           value="${id}" placeholder="IDを入力してください">

                    <c:if test="${not empty errorId}">
                        <%-- error.jspの埋め込む --%>
	                    <div class="text-warning mt-1">
		              		<jsp:include page="/error.jsp">
		                 	<jsp:param name="message" value="${errorId}" />
		               		</jsp:include>
	               		</div>
                    </c:if>
                </div>

                <!-- PASSWORD -->
                <div class="mb-4">
                    <label class="form-label fw-bold">PASSWORD</label>
                    <input type="password" name="password" id="password" class="form-control"
					       placeholder="PASSWORDを入力してください">
					
					<script>
					document.getElementById("password").addEventListener("input", function () {
					    const input = this;
					    input.type = "text";
					
					    clearTimeout(input._timer);
					    input._timer = setTimeout(() => {
					        input.type = "password";
					    }, 500);
					});
					</script>

                    <c:if test="${not empty errorPass}">
                        <%-- error.jspの埋め込む --%>
	                    <div class="text-warning mt-1">
		              		<jsp:include page="/error.jsp">
		                 	<jsp:param name="message" value="${errorPass}" />
		               		</jsp:include>
	               		</div>
                    </c:if>
                </div>

                <!-- PASSWORD(確認) -->
                <div class="mb-4">
                    <label class="form-label fw-bold">PASSWORD（確認）</label>
                    <input type="password" name="password2" id="password2" class="form-control"
                           value="${password2}" placeholder="PASSWORD（確認）を入力してください">

					<script>
					document.getElementById("password2").addEventListener("input", function () {
					    const input = this;
					    input.type = "text";
					
					    clearTimeout(input._timer);
					    input._timer = setTimeout(() => {
					        input.type = "password";
					    }, 500);
					});
					</script>

                    <c:if test="${not empty errorPass2}">
	                    <%-- error.jspの埋め込む --%>
	                    <div class="text-warning mt-1">
		              		<jsp:include page="/error.jsp">
		                 	<jsp:param name="message" value="${errorPass2}" />
		               		</jsp:include>
	               		</div>
                    </c:if>
                </div>

                <!-- 氏名 -->
                <div class="mb-4">
                    <label class="form-label fw-bold">氏名</label>
                    <input type="text" name="name" class="form-control"
                           value="${name}" placeholder="氏名を入力してください">

                    <c:if test="${not empty errorName}">
	                    <%-- error.jspの埋め込む --%>
	                    <div class="text-warning mt-1">
		              		<jsp:include page="/error.jsp">
		                 	<jsp:param name="message" value="${errorName}" />
		               		</jsp:include>
	               		</div>
                    </c:if>
                </div>

                <!-- ボタン（横いっぱい） -->
                <div class="mt-4 d-grid gap-3 col-6 mx-auto">
                    <button type="submit" class="btn btn-primary btn-lg w-100">登録</button>
                    <a href="TeacherList.action" class="btn btn-secondary btn-lg w-100">戻る</a>
                </div>

            </form>

        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
<jsp:include page="/footer.jsp"/>
