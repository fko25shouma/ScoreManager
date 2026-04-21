<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- Bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- 共通CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">

<title>${title}</title>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <div class="container-fluid">
    <span class="navbar-brand">得点管理システム</span>

    <div class="d-flex">
      <c:if test="${not empty loginUser}">
        <span class="navbar-text me-3">
          ${loginUser.name} 様
        </span>
        <a href="${pageContext.request.contextPath}/scoremanager/logout.jsp" class="btn btn-light btn-sm">
          ログアウト
        </a>
      </c:if>
    </div>
  </div>
</nav>
