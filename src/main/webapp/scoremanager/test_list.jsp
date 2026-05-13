<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/header.html" />

<div class="d-flex">
    <jsp:include page="/sidebar.html" />

    <div class="container mt-4">

        <h2 class="mb-4">成績参照検索</h2>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <!-- 科目別検索 -->
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">科目別成績一覧</div>
            <div class="card-body">

                <form action="TestListSubjectExecute.action" method="post">

                    <div class="mb-3">
                        <label class="form-label">入学年度</label>
                        <select name="entYear" class="form-select">
                            <option value="">選択してください</option>
                            <c:forEach var="y" items="${entYearList}">
                                <option value="${y}">${y}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">クラス</label>
                        <select name="classNum" class="form-select">
                            <option value="">選択してください</option>
                            <c:forEach var="c" items="${classList}">
                                <option value="${c}">${c}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">科目</label>
                        <select name="subjectCd" class="form-select">
                            <option value="">選択してください</option>
                            <c:forEach var="s" items="${subjectList}">
                                <option value="${s.cd}">${s.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <button class="btn btn-primary">検索</button>
                </form>

            </div>
        </div>

        <!-- 学生別検索 -->
        <div class="card">
            <div class="card-header bg-primary text-white">学生別成績一覧</div>
            <div class="card-body">

                <form action="TestListStudentExecute.action" method="post">

                    <div class="mb-3">
                        <label class="form-label">学生番号</label>
                        <input type="text" name="studentNo" class="form-control">
                    </div>

                    <button class="btn btn-primary">検索</button>
                </form>

            </div>
        </div>

    </div>
</div>

<jsp:include page="/footer.html" />
