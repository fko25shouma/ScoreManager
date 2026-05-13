<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/header.jsp"/>

<div class="layout">


    <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4 mt-3">
        科目管理
    </h2>

    <div class="text-end mb-3 px-4">
        <a href="subject_create.jsp" class="btn btn-secondary">新規登録</a>
    </div>

    <div class="px-4">
        <table class="table table-bordered align-middle">
            <thead class="table-light">
                <tr>
                    <th style="width: 15%">科目コード</th>
                    <th>科目名</th>
                    <th style="width: 10%">変更</th>
                    <th style="width: 10%">削除</th>
                </tr>
            </thead>

            <tbody>
                <c:forEach var="s" items="${list}">
                    <tr>
                        <td>${s.cd}</td>
                        <td>${s.name}</td>
                        <td>
                            <a href="SubjectUpdate.action?cd=${s.cd}" class="text-primary fw-bold">
                                変更
                            </a>
                        </td>
                        <td>
                            <a href="SubjectDelete.action?cd=${s.cd}" class="text-danger fw-bold">
                                削除
                            </a>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty list}">
                    <tr>
                        <td colspan="4" class="text-center py-4">
                            科目情報が存在しませんでした。
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</section>
</div>
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
