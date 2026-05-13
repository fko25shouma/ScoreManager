<%-- 学生一覧JSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<taglib prefix="c" uri="jakarta.tags.core" />
<c:import url="/base.jsp">
    <%-- <c:param name="title">
        得点管理システム
    </c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
            <section class="me-5">
            <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">学生管理</h2>
            <div class="mt-2 text-end">
                <a href="StudentCreate.action">新規登録</a>
            </div>
            <form method="get">
                <div class="row border mx-3 mb-3 py-2 align-items-center rounded" id="filter">
                    <div class="col-4">
                        <label class="form-label" for="student-f1-select">入学年度</label>
                        <select class="form-select" id="student-f1-select" name="f1">
                            <option value="0"></option>
                            <c:forEach var="year" items="${ent_year_set}">
                                <%-- 現在のyearと選択されていたf1が一致していた場合selectedを追加 --%>
                                <%-- <option value="${year}" <c:if test="${year==f1}">selected</c:if>>${year}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-4">
                        <label class="form-label" for="student-f2-select">クラス</label>
                        <select class="form-select" id="student-f2-select" name="f2">
                            <option value="0"></option>
                            <c:forEach var="num" items="${class_num_set}">
                                <%-- 現在のnumと選択されていたf2が一致していた場合selectedを追加 --%>
                                <%-- <option value="${num}" <c:if test="${num==f2}">selected</c:if>>${num}</option>
                            </c:forEach>
                        </select>--%>
                    <%-- </div>
                    <div class="col-2 form-check text-center">
                        <label class="form-check-label" for="student-f3-check">在学中</label>
                        <%-- f3が存在している場合checkedを追加 --%>
                        <%-- <input class="form-check-input" type="checkbox" id="student-f3-check" name="f3" value="t"
                            <c:if test="${!empty f3}">checked</c:if>>
                    </div>
                    <div class="col-2 text-center">
                        <button class="btn btn-secondary" id="filter-button">絞込み</button>
                    </div>
                </div>
                <div class="mt-2 text-warning">${errors.get("f1")}</div>
               </div>
               </form>--%>   