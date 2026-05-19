<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%-- ▼ 小数点切り捨て（平均点）の計算を行うためのタグライブラリを追加 --%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/header.jsp" />
<jsp:include page="nav.jsp"/>

<div class="container mt-4">
    <h2 class="h3 mb-4 fw-normal bg-secondary bg-opacity-10 py-2 px-4">科目別成績一覧</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <c:if test="${not empty subject}">
        <div class="mb-3 alert alert-info py-2">
            <strong>科目：</strong>${subject.name}　
            <strong>検索条件：</strong>${entYear}年度 ${classNum}クラス
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
                        <thead class="table-light text-center align-middle">
                            <tr>
                                <th>学生番号</th>
                                <th>氏名</th>
                                <th>クラス</th>
                                <c:forEach var="i" begin="1" end="10">
                                    <th style="min-width: 55px;">${i}回</th>
                                </c:forEach>
                                <th style="min-width: 125px;">総合評価</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="row" items="${list}">
                                <%-- ▼ この学生の合計点と受験回数を数えるための変数を準備 --%>
                                <c:set var="sum" value="0" />
                                <c:set var="count" value="0" />

                                <tr>
                                    <td class="text-center align-middle">${row.studentNo}</td>
                                    <td class="align-middle">${row.studentName}</td>
                                    <td class="text-center align-middle">${row.classNum}</td>
                                    
                                    <c:forEach var="i" begin="1" end="10">
                                        <td class="text-end align-middle">
                                            <c:choose>
                                                <%-- 点数が存在し、かつ-1(未受験)ではない場合 --%>
                                                <c:when test="${not empty row.points[i] and row.points[i] != -1}">
                                                    ${row.points[i]}
                                                    <%-- 合計点と回数を裏側で加算していく --%>
                                                    <c:set var="sum" value="${sum + row.points[i]}" />
                                                    <c:set var="count" value="${count + 1}" />
                                                </c:when>
                                                <c:otherwise><span class="text-muted">-</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                    </c:forEach>

                                    <%-- ▼ 追加：総合評価（平均点＆ランク表示） --%>
                                    <td class="text-center align-middle">
                                        <c:choose>
                                            <c:when test="${count > 0}">
                                                <%-- 平均点を計算し、integerOnly="true" で小数点を切り捨てる --%>
                                                <fmt:parseNumber value="${sum / count}" integerOnly="true" var="avg" />
                                                
                                                <%-- ランクの判定 --%>
                                                <c:choose>
                                                    <c:when test="${avg >= 90}">
                                                        ${avg}点 <span class="badge bg-warning ms-1">秀</span>
                                                    </c:when>
                                                    <c:when test="${avg >= 80}">
                                                        ${avg}点 <span class="badge bg-success ms-1">優</span>
                                                    </c:when>
                                                    <c:when test="${avg >= 70}">
                                                        ${avg}点 <span class="badge bg-primary ms-1">良</span>
                                                    </c:when>
                                                    <c:when test="${avg >= 60}">
                                                        ${avg}点 <span class="badge bg-secondary ms-1">可</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <%-- 59点以下（不合格）は赤文字(text-danger) ＋ 太字(fw-bold) --%>
                                                        <span class="text-danger fw-bold">${avg}点 (不合格)</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">-</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
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

<jsp:include page="/footer.html" />