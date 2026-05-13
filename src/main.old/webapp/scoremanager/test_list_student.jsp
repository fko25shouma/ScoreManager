<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>学生別成績一覧｜得点管理システム</title>

<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/test_list.css">

</head>
<body>

<div class="header">得点管理システム</div>

<div class="container">

    <h2>学生別成績一覧</h2>

    <c:if test="${empty list}">
        <div class="error">成績情報が存在しませんでした</div>
    </c:if>

    <c:if test="${not empty list}">
        <div class="table-area">
            <table>
                <tr>
                    <th>科目名</th>
                    <th>科目コード</th>
                    <th>回数</th>
                    <th>点数</th>
                </tr>

                <c:forEach var="row" items="${list}">
                    <tr>
                        <td>${row.subjectName}</td>
                        <td>${row.subjectCd}</td>
                        <td>${row.num}</td>
                        <td>${row.point}</td>
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
