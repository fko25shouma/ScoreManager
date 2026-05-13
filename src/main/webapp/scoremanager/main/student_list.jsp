<%@page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/header.jsp" />

<jsp:include page="nav.jsp" />
<div class="layout">


<main class="student-list-container">
        <h2>学生管理</h2>
        
  <div class="mt-2 text-end">
        <a href="StudentCreate.action">新規登録</a>
  </div>

  <form method="get">
     <div id="filter" class="row align-items-center rounded mx-0 mb-3">
         <div class="col-4">
            <label class="form-label" for="student-f1-select">入学年度</label>
               <select class="form-select" id="student-f1-select" name="f1">
                   <option value="0"></option>
                      <c:forEach var="year" items="${ent_year_set}">
                          <option value="${year}" <c:if test="${year==f1}">selected</c:if>>${year}</option>
                      </c:forEach>
                    </select>
                </div>
                <div class="col-4">
                    <label class="form-label" for="student-f2-select">クラス</label>
                    <select class="form-select" id="student-f2-select" name="f2">
                        <option value="0"></option>
                        <c:forEach var="num" items="${class_num_set}">
                            <option value="${num}" <c:if test="${num.toString() eq f2}">selected</c:if>>${num}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-2 form-check text-center">
                    <label class="form-check-label" for="student-f3-check">在学中</label>
                    <input class="form-check-input" type="checkbox" id="student-f3-check" name="f3" value="t"
                        <c:if test="${!empty f3}">checked</c:if>>
                </div>
                <div class="col-2 text-center">
                    <button class="btn btn-secondary" id="filter-button">絞込み</button>
                </div>
            </div>
            <div class="mt-2 text-warning">${errors.get("f1")}</div>
        </form>
			
        <c:choose>
            <c:when test="${students.size() > 0 }">
                <div class="mb-2">検索結果：${students.size() }件</div>
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>入学年度</th>
                            <th>学生番号</th>
                            <th>氏名</th>
                            <th>クラス</th>
                            <th class="text-center">在学中</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="student" items="${students}">
                            <tr>
                                <td>${student.entYear }</td>
                                <td>${student.no }</td>
                                <td>${student.name }</td>
                                <td>${student.classNum }</td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${student.isAttend() }">○</c:when>
                                        <c:otherwise>×</c:otherwise>
                                    </c:choose>
                                </td>
                                <td><a href="StudentUpdate.action?no=${student.no}">変更</a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="alert alert-info">学生情報が存在しませんでした。</div>
            </c:otherwise>
        </c:choose>
    </main>
</div>

<style>
{
    margin: 0;
    padding: 0;
    box-sizing: border-box; /* これで幅の計算を「線や余白込み」に固定する */
}

body {
    margin: 0;
    padding: 0;
}

.layout {
    display: flex;
    width: 100vw;      /* 画面の横幅を100%に固定 */
    min-height: 100vh;
    overflow-x: hidden; /* 横揺れを防止 */
}
/* --- menu.jspにあるcss(サイドバーの部分)をコピペ
/* --- サイドバー（白背景＋青リンク） --- */
.sidebar {
  width: 180px;
  background-color: #ffffff;
  border-right: 1px solid #ccc;
  height: 100vh;
  padding: 20px 10px;
  margin-left: 100px;
  box-sizing: border-box;
  flex-shrink: 0;
}

.sidebar ul {
  list-style: none;
  margin: 0;
  padding: 0;
}

.sidebar li {
  margin: 0;
  padding: 0;
}

/* リンク（青文字） */
.sidebar a {
  display: block;
  margin: 12px 0;
  color: #0070c0;
  text-decoration: none;
  font-size: 15px;
}

.sidebar a:hover {
  text-decoration: underline;
}

/* 成績管理  分類:label 種別:li (アイテムリスト) */
.sidebar li.label {
  color: #000001;
  background-color: #ffffff;
  font-weight: normal;
  cursor: default;
}

.sidebar li.child {
  padding-left: 15px;
}
/* --- メインエリア（studentlistのCSS） --- */
.student-list-container {
    flex: 1;
    padding: 20px 40px;
    min-width: 0;
}

h2 {
    background-color: rgba(108,117,125,0.1);
    padding: 8px 16px;
    border-radius: 4px;
    font-weight: normal;
    margin-top: 0;
    margin-bottom: 20px;
}

#filter {
    border: 1px solid #ccc;
    border-radius: 6px;
    padding: 15px;
    background-color: #fafafa;
}

.table { width: 100%; border-collapse: collapse; margin-top: 16px; }
.table th { background-color: #f0f0f0; padding: 8px; border-bottom: 2px solid #ccc; }
.table td { padding: 8px; border-bottom: 1px solid #ddd; }
.table-hover tbody tr:hover { background-color: #f7f7f7; }
</style>

<jsp:include page="/footer.html" />