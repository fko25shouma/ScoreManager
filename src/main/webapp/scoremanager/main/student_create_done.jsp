<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/header.jsp"/>
<div class="layout">

  
<section class="me-4">

    <h2 class="h3 mb-4 fw-normal bg-secondary bg-opacity-10 py-2 px-4 mt-3">
        学生情報登録
    </h2>

    <div class="alert alert-success mx-4" role="alert">
        登録が完了しました
    </div>

    <div class="px-4 mt-3">
        <a href="StudentCreate.action" class="me-3">戻る</a>
        <a href="StudentList.action">学生一覧</a>
    </div>

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