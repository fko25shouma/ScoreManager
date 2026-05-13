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
        ユーザ情報登録
    </h2>

    <form action="TeacherCreateExecute.action" method="post" class="px-4">
    

        <div class="mb-4">
            <label class="form-label fw-bold">ID</label>
            <input type="text" name="id" class="form-control"
                   value="${id}" placeholder="Idを入力してください">

            <c:if test="${not empty errorId}">
                <div class="text-warning mt-1">${errorId}</div>
            </c:if>
        </div>

        <div class="mb-4">
            <label class="form-label fw-bold">PASSWORD</label>
            <input type="text" name="password" class="form-control"
                   value="${password}" placeholder="PASSWORDを入力してください">

            <c:if test="${not empty errorPass}">
                <div class="text-warning mt-1">${errorPass}</div>
            </c:if>
        </div>
        
        <div class="mb-4">
            <label class="form-label fw-bold">PASSWORD(確認)</label>
            <input type="text" name="password2" class="form-control"
                   value="${password2}" placeholder="PASSWORD(確認)を入力してください">

            <c:if test="${not empty errorPass2}">
                <div class="text-warning mt-1">${errorPass2}</div>
            </c:if>
        </div>
        
        <div class="mb-4">
            <label class="form-label fw-bold">氏名</label>
            <input type="text" name="name" class="form-control"
                   value="${name}" placeholder="氏名を入力してください">

            <c:if test="${not empty errorName}">
                <div class="text-warning mt-1">${errorName}</div>
            </c:if>
        </div>

        <div class="mt-4">
            <button type="submit" class="btn btn-primary px-4">登録</button>
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

