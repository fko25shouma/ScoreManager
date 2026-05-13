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
        クラス情報変更
    </h2>

    <form action="ClassUpdateExecute.action" method="post" class="px-4">

        <div class="mb-4">
            <label class="form-label fw-bold">変更前クラス番号</label>
            <input type="text" class="form-control" value="${cd}" disabled>
            <input type="hidden" name="cd" value="${cd}">
            <c:if test="${not empty deleteerror}">
        		<div class="text-warning mt-2">${deleteerror}</div>
    		</c:if>
        </div>

        <div class="mb-4">
            <label class="form-label fw-bold">変更後クラス番号</label>
            <input type="text" name="newcd" class="form-control"
                   value="${newcd}"　placeholder="クラス番号を入力してください">
            <c:if test="${not empty error}">
                <div class="text-warning mt-1">${error}</div>
            </c:if>
        </div>

        <div class="mt-4">
            <button type="submit" class="btn btn-primary px-4">変更</button>
            <a href="ClassList.action" class="btn btn-secondary px-4 ms-2">戻る</a>
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
