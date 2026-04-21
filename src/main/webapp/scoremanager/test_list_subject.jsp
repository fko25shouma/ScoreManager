<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>科目別成績一覧｜得点管理システム</title>

<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/test_list.css">

</head>
<body>

<div class="header">得点管理システム</div>

<div class="container">

    <h2>科目別成績一覧</h2>

    <c:if test="${empty list}">
        <div class="error">学生情報が存在しませんでした</div>
    </c:if>

    <c:if test="${not empty list}">
        <div class="table-area">
            <table>
                <tr>
                    <th>学生番号</th>
                    <th>氏名</th>
                    <th>入学年度</th>
                    <th>クラス</th>

                    <!-- 回数（1〜10） -->
                    <c:forEach var="i" begin="1" end="10">
                        <th>${i}回</th>
                    </c:forEach>
                </tr>

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
            </table>
        </div>
    </c:if>

    <div style="margin-top:20px;">
        <a href="TestList.action" class="btn-search">戻る</a>
    </div>

</div>

<div class="footer">© 2023 TIC 大原学園</div>

</body>
</html>
