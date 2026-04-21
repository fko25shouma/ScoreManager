<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>成績参照検索｜得点管理システム</title>

<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/test_list.css">

</head>
<body>

<div class="header">得点管理システム</div>

<div class="container">

    <h2>成績参照検索</h2>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <!-- 科目別検索 -->
    <form action="TestListSubjectExecute.action" method="post">

        <h3>科目別成績一覧</h3>

        <div class="form-row">
            <label>入学年度</label>
            <select name="entYear">
                <option value="">選択してください</option>
                <c:forEach var="y" items="${entYearList}">
                    <option value="${y}">${y}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-row">
            <label>クラス</label>
            <select name="classNum">
                <option value="">選択してください</option>
                <c:forEach var="c" items="${classList}">
                    <option value="${c}">${c}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-row">
            <label>科目</label>
            <select name="subjectCd">
                <option value="">選択してください</option>
                <c:forEach var="s" items="${subjectList}">
                    <option value="${s.cd}">${s.name}</option>
                </c:forEach>
            </select>
        </div>

        <button class="btn-search">検索</button>
    </form>

    <hr style="margin:30px 0;">

    <!-- 学生別検索 -->
    <form action="TestListStudentExecute.action" method="post">

        <h3>学生別成績一覧</h3>

        <div class="form-row">
            <label>学生番号</label>
            <input type="text" name="studentNo">
        </div>

        <button class="btn-search">検索</button>
    </form>

</div>

<div class="footer">© 2023 TIC 大原学園</div>

</body>
</html>
