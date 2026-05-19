<%@page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="error-container">
    <c:choose>
        <%-- ：入力チェックエラー（メッセージが渡された時） --%>
        <c:when test="${not empty param.message and param.message != ''}">
            <ul class="error-message list-unstyled">
                <li>⚠<c:out value="${param.message}" /></li>
            </ul>
        </c:when>

        <%-- システムエラー（直接このページが開かれた時） --%>
        <c:otherwise>
        	<jsp:include page="/header.jsp" />
        	<jsp:include page="scoremanager/main/nav.jsp"/>
            <main class="container mt-5">
            <div class="error-container alert alert-danger shadow-sm">
                <ul class="error-message list-unstyled mb-0">
                    <li>⚠エラーが発生しました</li>
                </ul>
            </div>
        </main>
            <jsp:include page="/footer.jsp" />
        </c:otherwise>
    </c:choose>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>