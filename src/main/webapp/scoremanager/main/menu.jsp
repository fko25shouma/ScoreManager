<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/header.jsp"/>
<jsp:include page="nav.jsp"/>


<!-- メインコンテンツ -->
	<div class="container mt-4">
	 <h2 class="h3 mb-4 fw-bord bg-secondary bg-opacity-10 py-2 px-4">メインメニュー</h2>
	
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
<jsp:include page="/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>




