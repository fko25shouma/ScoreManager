<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<body class="bg-light">

<jsp:include page="/header.jsp" />

<div class="container mt-4">

    <!-- タイトル（menu.jsp と完全一致） -->
    <h2 class="h3 mb-4 fw-normal bg-secondary bg-opacity-10 py-2 px-4">
        成績登録
    </h2>

    <!-- ▼ エラーメッセージ -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <!-- ▼ 検索フォーム（Bootstrap カード化） -->
    <form action="TestRegistExecute.action" method="post" class="card shadow-sm mb-4">
        <div class="card-body row g-3">

            <div class="col-md-3">
                <label class="form-label fw-bold">入学年度</label>
                <select name="ent_year" class="form-select">
                    <option value="">選択</option>
                    <c:forEach var="y" items="${ent_year_set}">
                        <option value="${y}" <c:if test="${y == ent_year}">selected</c:if>>${y}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="col-md-3">
                <label class="form-label fw-bold">クラス</label>
                <select name="class_num" class="form-select">
                    <option value="">選択</option>
                    <c:forEach var="c" items="${class_num_set}">
                        <option value="${c}" <c:if test="${c == class_num}">selected</c:if>>${c}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="col-md-3">
                <label class="form-label fw-bold">科目</label>
                <select name="subject_cd" class="form-select">
                    <option value="">選択</option>
                    <c:forEach var="s" items="${subject_list}">
                        <option value="${s.cd}" <c:if test="${s.cd == subject_cd}">selected</c:if>>${s.name}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="col-md-2">
                <label class="form-label fw-bold">回数</label>
                <select name="num" class="form-select">
                    <option value="">選択</option>
                    <c:forEach begin="1" end="10" var="n">
                        <option value="${n}" <c:if test="${n == num}">selected</c:if>>${n}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="col-md-1 d-flex align-items-end">
                <button type="submit" class="btn btn-primary w-100">検索</button>
            </div>

        </div>
    </form>

    <!-- ▼ 成績入力欄（検索後のみ表示） -->
    <c:if test="${not empty test_list}">
        <form action="TestRegistExecute.action" method="post" class="card shadow-sm">

            <div class="card-body">

                <!-- 検索条件を hidden で保持 -->
                <input type="hidden" name="ent_year" value="${ent_year}">
                <input type="hidden" name="class_num" value="${class_num}">
                <input type="hidden" name="subject_cd" value="${subject_cd}">
                <input type="hidden" name="num" value="${num}">
                <input type="hidden" name="regist" value="1">

                <table class="table table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>学生番号</th>
                            <th>氏名</th>
                            <th>点数</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="t" items="${test_list}">
                            <tr>
                                <td>${t.student.no}</td>
                                <td>${t.student.name}</td>
                                <td>
                                    <input type="text" name="point_${t.student.no}" value="${t.point}"
                                           class="form-control w-50">
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <div class="text-end mt-3">
                    <button type="submit" class="btn btn-primary">登録して終了</button>
                </div>

            </div>

        </form>
    </c:if>

    <!-- ▼ メニューへ戻る -->
    <div class="mt-4 text-end">
        <a href="Menu.action" class="btn btn-secondary">
            メニューへ戻る
        </a>
    </div>

</div>

<jsp:include page="/footer.html" />

</body>
