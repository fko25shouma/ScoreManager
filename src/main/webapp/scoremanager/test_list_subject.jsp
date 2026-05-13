<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/header.html" />

<div class="d-flex">
    <jsp:include page="/sidebar.html" />

    <div class="container mt-4">

        <h2 class="mb-4">科目別成績一覧</h2>

        <c:if test="${empty list}">
            <div class="alert alert-warning">学生情報が存在しませんでした</div>
        </c:if>

        <c:if test="${not empty list}">
            <div class="card">
                <div class="card-body">

                    <table class="table table-bordered table-striped">
                        <thead class="table-light">
                            <tr>
                                <th>学生番号</th>
                                <th>氏名</th>
                                <th>入学年度</th>
                                <th>クラス</th>

                                <c:forEach var="i" begin="1" end="10">
                                    <th>${i}回</th>
                                </c:forEach>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach var="row" items="${list}">
                                <tr>
                                    <td>${row.studentNo}</td>
                                    <td>${row.studentName}</td>
                                    <td>${row.entYear}</td>
                                    <td>${row.classNum}</td>

                                    <c:forEach var="i" begin="1" end="10">
                                        <td>${row.points[i]}</td>
                                    </c:forEach>
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
