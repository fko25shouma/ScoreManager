<%@page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/header.jsp" />

<style>
    body {
        background: linear-gradient(135deg, #0d6efd 0%, #4dabf7 100%);
        min-height: 100vh;
    }
    .logout-card {
        border-radius: 12px;
        padding: 40px;
        max-width: 450px;
        width: 100%;
    }
    .card-shadow {
        box-shadow: 0 8px 24px rgba(0,0,0,0.15);
    }
</style>

<body>
    <!-- ナビゲーションバー（他画面と共通） -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
        <div class="container-fluid">
            <span class="navbar-brand fw-bold">得点管理システム</span>
        </div>
    </nav>

    <!-- メインコンテンツ -->
    <div class="container d-flex justify-content-center align-items-center" style="min-height: calc(100vh - 56px);">
        <div class="card logout-card card-shadow text-center">
            
            <!-- アイコン（オプション） -->
            <div class="mb-4 text-primary">
                <i class="bi bi-check-circle-fill" style="font-size: 3rem;"></i>
            </div>

            <h2 class="fw-bold mb-3">ログアウト</h2>
            
            <div class="alert alert-info py-3 mb-4">
                <p class="m-0 logout-message">ログアウトしました。</p>
            </div>

            <!-- ログイン画面へ戻るボタン -->
            <div class="d-grid">
                <a href="Login.action" class="btn btn-primary btn-lg fw-bold">
                    ログイン画面へ
                </a>
            </div>

        </div>
    </div>

    <jsp:include page="/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
