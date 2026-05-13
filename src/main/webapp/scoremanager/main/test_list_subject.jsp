<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/header.jsp" />

<div class="container mt-4">
    <h2 class="h3 mb-4 fw-normal bg-secondary bg-opacity-10 py-2 px-4">科目別成績一覧</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <c:if test="${not empty subject}">
        <div class="mb-3">
            <span class="fw-bold">科目：</span>${subject.name} 
            <span class="ms-3 fw-bold">条件：</span>${entYear}年度 ${classNum}クラス
        </div>
    </c:if>

    <c:choose>
        <c:when test="${empty list && empty error}">
            <div class="alert alert-warning">学生情報が存在しませんでした</div>
        </c:when>
        <c:when test="${not empty list}">
            <div class="card shadow-sm overflow-auto">
                <div class="card-body p-0">
                    <table class="table table-bordered table-hover mb-0">
                        <thead class="table-light text-center">
                            <tr>
                                <th>学生番号</th>
                                <th>氏名</th>
                                <th>クラス</th>
                                <c:forEach var="i" begin="1" end="10">
                                    <th style="min-width: 60px;">${i}回</th>
                                </c:forEach>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="row" items="${list}">
                                <tr>
                                    <td class="text-center">${row.studentNo}</td>
                                    <td>${row.studentName}</td>
                                    <td class="text-center">${row.classNum}</td>
                                    <c:forEach var="i" begin="1" end="10">
                                        <td class="text-end">
                                            <c:choose>
                                                <c:when test="${row.points[i] == -1}">-</c:when>
                                                <c:otherwise>${row.points[i]}</c:otherwise>
                                            </c:choose>
                                        </td>
                                    </c:forEach>
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

<jsp:include page="/footer.jsp" />