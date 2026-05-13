<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/header.jsp"/>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
	    <div class="container-fluid">
	        <span class="navbar-brand fw-bold">得点管理システム</span>
	        <div class="collapse navbar-collapse justify-content-end">
	            <ul class="navbar-nav">
	
	                <li class="nav-item">
	                    <a class="nav-link active" href="Menu.action">ホーム</a>
	                </li>
	
	                <li class="nav-item">
	                    <a class="nav-link" href="StudentList.action">学生管理</a>
	                </li>
	
	                <li class="nav-item">
	                    <a class="nav-link" href="TestList.action">成績管理</a>
	                </li>
	                
	                <li class="nav-item">
	                    <a class="nav-link" href="SubjectList.action">科目管理</a>
	                </li>
	
	                <li class="nav-item">
	                    <a class="nav-link" href="ClassList.action">クラス管理</a>
	                </li>
	                
	                <li class="nav-item">
	                    <a class="nav-link" href="TeacherList.action">ユーザ管理</a>
	                </li>
	
	                
	
	                <!-- ▼ ログイン状態で表示切替 -->
	                <c:choose>
	                    <c:when test="${not empty loginUserName}">
	                        <li class="nav-item">
	                            <span class="nav-link text-white">ようこそ、${loginUserName} 様</span>
	                        </li>
	                        <li class="nav-item">
	                            <a class="nav-link" href="Logout.action">ログアウト</a>
	                        </li>
	                    </c:when>
	                    <c:otherwise>
	                        <li class="nav-item">
	                            <a class="nav-link" href="Login.action">ログイン</a>
	                        </li>
	                    </c:otherwise>
	                </c:choose>
	
	            </ul>
	        </div>
	    </div>
	</nav>
	
	<!-- ▼ ログアウト後メッセージ -->
	<c:if test="${not empty logoutMessage}">
	    <div class="alert alert-info text-center m-0">
	        ${logoutMessage}
	    </div>
	</c:if>

<!-- メインコンテンツ -->
	<div class="container mt-4">
	 <h2 class="h3 mb-4 bg-secondary bg-opacity-10 py-2 px-4">メインメニュー</h2>
	
	    <div class="row g-3 mb-4">
	
		
		    <!-- ▼ 学生管理 -->
		    <div class="col-md-4">
			    <div class="card shadow-lg rounded-4 border-0 position-relative card-hover"
			         style="background: linear-gradient(135deg, #bbdefb, #e3f2fd);">
			
			        <div class="card-body text-center py-4">
			
			            <div class="bg-primary bg-opacity-75 text-white rounded-circle d-inline-flex 
			                        justify-content-center align-items-center mb-3"
			                 style="width:70px; height:70px;">
			                <i class="bi bi-people-fill fs-2"></i>
			            </div>
			
			            <h5 class="fw-bold">学生管理</h5>
			            <p class="text-muted">学生情報の一覧・登録</p>
			
			            <a href="StudentList.action" class="stretched-link"></a>
			        </div>
			    </div>
			</div>
		
		
		    <!-- ▼ 成績登録 -->
		    <div class="col-md-4">
			    <div class="card shadow-lg rounded-4 border-0 position-relative card-hover"
			         style="background: linear-gradient(135deg, #bbdefb, #e3f2fd);">
			
			        <div class="card-body text-center py-4">
			
			            <div class="bg-primary bg-opacity-75 text-white rounded-circle d-inline-flex 
			                        justify-content-center align-items-center mb-3"
			                 style="width:70px; height:70px;">
			                <i class="bi bi-pencil-square fs-2"></i>
			            </div>
			
			            <h5 class="fw-bold">成績登録</h5>
			            <p class="text-muted">学生の成績を登録</p>
			
			            <a href="TestRegist.action" class="stretched-link"></a>
			        </div>
			    </div>
			</div>
		
		    <!-- ▼ 成績参照 -->
		    <div class="col-md-4">
			    <div class="card shadow-lg rounded-4 border-0 position-relative card-hover"
			         style="background: linear-gradient(135deg, #bbdefb, #e3f2fd);">
			
			        <div class="card-body text-center py-4">
			
			            <div class="bg-primary bg-opacity-75 text-white rounded-circle d-inline-flex 
			                        justify-content-center align-items-center mb-3"
			                 style="width:70px; height:70px;">
			                <i class="bi bi-clipboard-data fs-2"></i>
			            </div>
			
			            <h5 class="fw-bold">成績参照</h5>
			            <p class="text-muted">成績を検索・確認</p>
			
			            <a href="TestList.action" class="stretched-link"></a>
			        </div>
			    </div>
			</div>
		
		
		    <!-- ▼ 科目管理 -->
		    <div class="col-md-4">
			    <div class="card shadow-lg rounded-4 border-0 position-relative card-hover"
			         style="background: linear-gradient(135deg, #bbdefb, #e3f2fd);">
			
			        <div class="card-body text-center py-4">
			
			            <div class="bg-primary bg-opacity-75 text-white rounded-circle d-inline-flex 
			                        justify-content-center align-items-center mb-3"
			                 style="width:70px; height:70px;">
			                <i class="bi bi-book fs-2"></i>
			            </div>
			
			            <h5 class="fw-bold">科目管理</h5>
			            <p class="text-muted">科目一覧・登録・編集</p>
			
			            <a href="SubjectList.action" class="stretched-link"></a>
			        </div>
			    </div>
			</div>
		
		
		    <!-- ▼ クラス管理 -->
		    <div class="col-md-4">
			    <div class="card shadow-lg rounded-4 border-0 position-relative card-hover"
			         style="background: linear-gradient(135deg, #bbdefb, #e3f2fd);">
			
			        <div class="card-body text-center py-4">
			
			            <div class="bg-primary bg-opacity-75 text-white rounded-circle d-inline-flex 
			                        justify-content-center align-items-center mb-3"
			                 style="width:70px; height:70px;">
			                <i class="bi bi-building fs-2"></i>
			            </div>
			
			            <h5 class="fw-bold">クラス管理</h5>
			            <p class="text-muted">クラス情報の一覧・追加</p>
			
			            <a href="ClassList.action" class="stretched-link"></a>
			        </div>
			    </div>
			</div>
		
		
		    <!-- ▼ ユーザ管理 -->
		    <div class="col-md-4">
			    <div class="card shadow-lg rounded-4 border-0 position-relative card-hover"
			         style="background: linear-gradient(135deg, #bbdefb, #e3f2fd);">
			
			        <div class="card-body text-center py-4">
			
			            <div class="bg-primary bg-opacity-75 text-white rounded-circle d-inline-flex 
			                        justify-content-center align-items-center mb-3"
			                 style="width:70px; height:70px;">
			                <i class="bi bi-person-gear fs-2"></i>
			            </div>
			
			            <h5 class="fw-bold">ユーザ管理</h5>
			            <p class="text-muted">ユーザ一覧・追加・編集</p>
			
			            <a href="TeacherList.action" class="stretched-link"></a>
			        </div>
			    </div>
			</div>
		</div>
	</div>
</body>
<jsp:include page="/footer.html"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>



