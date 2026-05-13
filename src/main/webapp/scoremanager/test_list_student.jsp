<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/header.html" />

<div class="d-flex">
    <jsp:include page="/sidebar.html" />

    <div class="container mt-4">

        <h2 class="mb-4">学生別成績一覧</h2>

        <c:if test="${empty list}">
            <div class="alert alert-warning">成績情報が存在しませんでした</div>
        </c:if>

        <c:if test="${not empty list}">
            <div class="card">
                <div class="card-body">

                    <table class="table table-bordered table-striped">
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
                                    <td>${row.num}</td>
                                    <td>${row.point}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                </div>
            </div>
        </c:if>

        <a href="TestList.action" class="btn btn-secondary mt-3">戻る</a>

    </div>
</div>

<jsp:include page="/footer.html" />
