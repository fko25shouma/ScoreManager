<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/header.jsp"/>
<aside class="sidebar">
    <nav>
      <ul>
   
        <li><a href="Menu.action">メニュー</a></li>

        <li><a href="StudentList.action">学生管理</a></li>

        <li class="label">成績管理</li>
        
        <li class="child"><a href="test_regist.jsp">成績登録</a></li>
        
        <li class="child"><a href="test_list.jsp">成績参照</a></li>
        
        <li><a href="SubjectList.action">科目管理</a></li>
        
      </ul>
    </nav>
  </aside>
<section class="me-4">

    <h2 class="h3 mb-4 fw-normal bg-secondary bg-opacity-10 py-2 px-4 mt-3">
        ユーザ情報変更
    </h2>

    <form action="TeacherUpdateExecute.action" method="post" class="px-4">

        <div class="mb-4">
            <label class="form-label fw-bold">ID</label>
            <input type="text" class="form-control" value="${id}">
            <input type="hidden" name="id" value="${id}">
        </div>
        
        <div class="mb-4">
            <label class="form-label fw-bold">Password</label>
            <input type="text" class="form-control" value="${password}" disabled>
            <input type="hidden" name="password" value="${password}">
        </div>

        <div class="mb-4">
            <label class="form-label fw-bold">NAME</label>
            <input type="text" name="name" class="form-control"
                   value="${name}"　placeholder="氏名を入力してください">
        </div>
        
        <div class="mt-4">
            <button type="submit" class="btn btn-primary px-4">変更</button>
            <a href="TeacherList.action" class="btn btn-secondary px-4 ms-2">戻る</a>
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
