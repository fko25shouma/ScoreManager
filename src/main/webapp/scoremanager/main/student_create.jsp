<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/header.jsp"/>
<div class="layout">

  <!-- ▼ サイドバー -->
  <aside class="sidebar">
    <nav>
      <ul>
   
        <li><a href="Menu.action">メニュー</a></li>

        <li><a href="StudentList.action">学生管理</a></li>

        <li class="label">成績管理</li>
        
        <li class="child"><a href="test_regist.jsp">成績登録</a></li>
        
        <li class="child"><a href="test_list.jsp">成績参照</a></li>
        
        <li><a href="subject_list.jsp">科目管理</a></li>
        
      </ul>
    </nav>
  </aside>
<section class="me-4">

    <h2 class="h3 mb-4 fw-normal bg-secondary bg-opacity-10 py-2 px-4 mt-3">
        学生情報登録
    </h2>

    <form action="StudentCreateExecute.action" method="post" class="px-4">

        <div class="mb-4">
            <label class="form-label fw-bold">入学年度</label>
            <select name="ent_year" class="form-select">
            	<option value="">---------</option>
                <option value="2020" ${ent_year == 2020 ? "selected" : ""}>2020</option>
                <option value="2021" ${ent_year == 2021 ? "selected" : ""}>2021</option>
                <option value="2022" ${ent_year == 2022 ? "selected" : ""}>2022</option>
                <option value="2023" ${ent_year == 2023 ? "selected" : ""}>2023</option>
                <option value="2024" ${ent_year == 2024 ? "selected" : ""}>2024</option>
                <option value="2025" ${ent_year == 2025 ? "selected" : ""}>2025</option>
            </select>

            <c:if test="${not empty error_ent_year}">
                <div class="text-warning mt-1">${error_ent_year}</div>
            </c:if>
        </div>

        <div class="mb-4">
            <label class="form-label fw-bold">学生番号</label>
            <input type="text" name="no" class="form-control"
                   value="${no}" placeholder="学生番号を入力してください">

            <c:if test="${not empty error_no}">
                <div class="text-warning mt-1">${error_no}</div>
            </c:if>
        </div>

        <div class="mb-4">
            <label class="form-label fw-bold">氏名</label>
            <input type="text" name="name" class="form-control"
                   value="${name}" placeholder="氏名を入力してください">

            <c:if test="${not empty error_name}">
                <div class="text-warning mt-1">${error_name}</div>
            </c:if>
        </div>

        <div class="mb-4">
            <label class="form-label fw-bold">クラス</label>
            <select name="class_num" class="form-select">
            	<option value="">---------</option>
                <option value="101" ${class_num == 101 ? "selected" : ""}>101</option>
                <option value="102" ${class_num == 102 ? "selected" : ""}>102</option>
                <option value="201" ${class_num == 201 ? "selected" : ""}>201</option>
                <option value="202" ${class_num == 202 ? "selected" : ""}>202</option>
            </select>

            <c:if test="${not empty error_class_num}">
                <div class="text-warning mt-1">${error_class_num}</div>
            </c:if>
        </div>

        <div class="mt-4">
            <button type="submit" class="btn btn-primary px-4">登録して終了</button>
            <a href="StudentList.action" class="btn btn-secondary px-4 ms-2">戻る</a>
        </div>

    </form>

</section>
<style>
.sidebar {
    width: 200px;
    position: fixed;
    top: 60px; /* header の高さに合わせる */
    left: 0;
    height: 100%;
    background-color: #ffffff;
    padding: 20px;
}

section.me-4 {
    margin-left: 220px; /* サイドバーの幅 + 余白 */
}
</style>
<jsp:include page="/footer.html"/>
