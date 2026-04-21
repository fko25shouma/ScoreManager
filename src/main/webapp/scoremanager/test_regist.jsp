<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>成績管理｜得点管理システム</title>

<link rel="stylesheet" href="../css/common.css">
<link rel="stylesheet" href="../css/test_regist.css">

</head>
<body>

<div class="header">得点管理システム</div>

<div class="container">

    <h2>成績管理一覧</h2>

    <!-- エラーメッセージ -->
    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <!-- 検索フォーム -->
    <form action="TestRegist.action" method="post">

        <div class="form-row">
            <label>入学年度</label>
            <select name="entYear">
                <option value="">選択してください</option>
                <c:forEach var="y" items="${entYearList}">
                    <option value="${y}" ${param.entYear == y ? "selected" : ""}>${y}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-row">
            <label>クラス</label>
            <select name="classNum">
                <option value="">選択してください</option>
                <c:forEach var="c" items="${classList}">
                    <option value="${c}" ${param.classNum == c ? "selected" : ""}>${c}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-row">
            <label>科目</label>
            <select name="subjectCd">
                <option value="">選択してください</option>
                <c:forEach var="s" items="${subjectList}">
                    <option value="${s.cd}" ${param.subjectCd == s.cd ? "selected" : ""}>${s.name}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-row">
            <label>回数</label>
            <input type="number" name="num" min="1" max="10" value="${param.num}">
        </div>

        <button class="btn-search">検索</button>
    </form>

    <!-- 検索結果（学生一覧 + 点数入力） -->
    <c:if test="${not empty studentList}">
        <div class="table-area">
            <form action="TestRegistExecute.action" method="post">

                <!-- 検索条件を hidden で保持 -->
                <input type="hidden" name="entYear" value="${param.entYear}">
                <input type="hidden" name="classNum" value="${param.classNum}">
                <input type="hidden" name="subjectCd" value="${param.subjectCd}">
                <input type="hidden" name="num" value="${param.num}">

                <table>
                    <tr>
                        <th>学生番号</th>
                        <th>氏名</th>
                        <th>点数</th>
                    </tr>

                    <c:forEach var="st" items="${studentList}">
                        <tr>
                            <td>${st.no}</td>
                            <td>${st.name}</td>
                            <td>
                                <input type="number" name="point_${st.no}" min="0" max="100"
                                       value="${testMap[st.no]}">
                            </td>
                        </tr>
                    </c:forEach>
                </table>

                <button class="btn-submit">登録して終了</button>

            </form>
        </div>
    </c:if>

</div>

<div class="footer">© 2023 TIC 大原学園</div>

</body>
</html>
