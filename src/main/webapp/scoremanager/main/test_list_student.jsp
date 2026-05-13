<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- header.jspはwebapp直下のため /header.jsp --%>
<jsp:include page="/header.jsp" />
<jsp:include page="/nav.jsp"/>

<div class="container mt-4">
    <h2 class="h3 mb-4 fw-normal bg-secondary bg-opacity-10 py-2 px-4">学生別成績一覧</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <c:if test="${not empty student}">
        <div class="mb-3 border-bottom pb-2">
            <span class="fw-bold">氏名：</span>${student.name} (${student.no})
        </div>
    </c:if>

    <c:choose>
        <c:when test="${empty list && empty error}">
            <div class="alert alert-warning">成績情報が存在しません</div>
        </c:when>
        <c:when test="${not empty list}">
            <div class="card shadow-sm">
                <div class="card-body p-0">
                    <table class="table table-hover mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>科目名</th>
                                <th>科目コード</th>
                                <th>回数</th>
                                <th>点数</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="row" items="${list}">
                                <tr>
                                    <td>${row.subjectName}</td>
                                    <td>${row.subjectCd}</td>
                                    <td>${row.num}回</td>
                                    <td>${row.point}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:when>
    </c:choose>

    <div class="mt-4 text-end">
        <a href="TestList.action" class="btn btn-secondary">戻る</a>
    </div>
</div>

<%-- footer.htmlはwebapp直下のため /footer.html --%>
<jsp:include page="/footer.html" />