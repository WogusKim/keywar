<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김국민의 업무노트 : TO DO LIST</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/todo.css">
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png" />
<link rel="apple-touch-icon" href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png"  />
<style>
/* 기본 체크박스 감춤 */
input[type="checkbox"][id^="check"] {
    display: none;
}
/* off */
input[type="checkbox"][id^="check"] + label { 
    background-repeat: no-repeat; /* 반복 방지 */
    background-image: url('${pageContext.request.contextPath}/resources/images/checkbox.png'); /* off 이미지 */
}
/* on */
input[type="checkbox"][id^="check"]:checked + label {
    background-repeat: no-repeat; /* 반복 방지 */
    background-image: url('${pageContext.request.contextPath}/resources/images/checked.png'); /* on 이미지 */
}
label { 
    display: block; 
    width: 30px; 
    height: 30px;
}
/* 전체 스크롤바 스타일 */
::-webkit-scrollbar {
    width: 4px; /* 스크롤바의 너비 */
    height: 8px; /* 가로 스크롤바의 높이 (optional) */
}

/* 스크롤바의 트랙 (스크롤바 배경) */
::-webkit-scrollbar-track {
    background: #f1f1f1; /* 배경 색상 */
    border-radius: 10px; /* 모서리를 둥글게 */
}

/* 스크롤바의 핸들 (사용자가 잡는 부분) */
::-webkit-scrollbar-thumb {
    background: #888; /* 핸들의 배경 색상 */
    border-radius: 10px; /* 모서리를 둥글게 */
}

/* 스크롤바 핸들의 호버 상태 */
::-webkit-scrollbar-thumb:hover {
    background: #555; /* 핸들이 호버 상태일 때의 색상 */
}
</style>
</head>

<body>
<% 
   String userno = (String) session.getAttribute("userno");
%>
	<%@ include file="/WEB-INF/views/header.jsp"%>

	<div class="content_outline">
		<%@ include file="/WEB-INF/views/sidebar.jsp"%>
		<div class="content_right">
			<!-- 여기까지 기본세팅(흰 배경) -->

			<div class="board_back">
				<!-- 민트 배경 -->
				<div style="height: 100%;" class="board_todo">
					<!-- 흰 배경 -->
					<h2 class="card_title" >To-Do List</h2>
					<hr>
					<!-- 여기부터 성은 수정 -->
					
					<div style="height: 90%; display: flex; justify-content:  space-between; padding: 10px;">
						
						<div id="In progress" class="todoBox" style="background-color: var(--main-bgcolor); box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3); ">
							<div class="arrangeBox" >
								<b class="todoBoxTitle">Today's tasks</b> <img src="${pageContext.request.contextPath}/resources/images/add.png" style="width: 20px; height: 20px;" onclick="openModal2()"/>
							</div>
							<div style="overflow-y: auto; height: 95%; margin-top: 20px; padding-right: 10px;" >  <!-- 여기에 투두리스트 보여짐  -->
							<!-- 여기부터 포문 돌리는 영역 --> 
							<!-- 지난 거는 강조하기 -->
							<c:forEach items="${list}" var="dto">
							<c:if test="${dto.checkstatus == '0' &&dto.isdone=='0'}">
								<div class="innerTodoBox" style=" /* border: 5px solid red; */ border : none;  background-color: #FFC7CE; ">
								<div class="arrangeBox" >
									<div style="display: flex; text-align: center;" > 
										<input type="checkbox" onclick="checkTodo(${dto.todoid}, this.checked)"
									${dto.isdone == 1 ? 'checked' : ''} data-todoid="${dto.todoid}"
									data-done="${dto.isdone}"  id="check-${dto.todoid}" > <label for="check-${dto.todoid}"></label> 
									<div class="No-line-break" style="text-align: center; height: 30px; vertical-align: middle;" >${dto.task }</div> 
									</div>  
									<img src="${pageContext.request.contextPath}/resources/images/more.png" style="width: 20px; height: 20px;" onclick="openModal('${dto.todoid}', '${dto.task}','${dto.importance}','${dto.category}','${dto.progress}','${dto.duedate}','${dto.detail}')" />
								</div>	
									<div  style="display: flex; margin-top: 5px;">
										<div class="importance" style="background-color: #FEA800; width: 100px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;" >
											${dto.importance}<!-- DB에 입력되어있는 중요도 -->
										</div>
										<div class="importance" style="background-color: #9F45E3; color : white; width: 100px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;" >
											${dto.category}<!-- DB에 입력되어있는 분류 -->
										</div>
										<div style="color: gray; width: 150px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
											${dto.duedate}
										</div>
									</div>
									<div class="todoDetail" style=""  >
										${dto.detail}
									</div>
									</div>
								</c:if>
								</c:forEach>
								<!-- 포문 여기서 끝 -->
							<!-- 여기부터 포문 돌리는 영역 -->
							<c:forEach items="${list}" var="dto">
							<c:if test="${dto.checkstatus == '1' &&dto.isdone=='0'}">
								<div class="innerTodoBox">
								<div class="arrangeBox" >
									<div style="display: flex; text-align: center;" > 
										<input type="checkbox" onclick="checkTodo(${dto.todoid}, this.checked)"
									${dto.isdone == 1 ? 'checked' : ''} data-todoid="${dto.todoid}"
									data-done="${dto.isdone}"  id="check-${dto.todoid}" > <label for="check-${dto.todoid}"></label> 
									<div class="No-line-break" style="text-align: center; height: 30px; vertical-align: middle;">${dto.task}</div>
									</div>  
									<img src="${pageContext.request.contextPath}/resources/images/more.png" style="width: 20px; height: 20px;" onclick="openModal('${dto.todoid}', '${dto.task}','${dto.importance}','${dto.category}','${dto.progress}','${dto.duedate}','${dto.detail}')" />
								</div>	
									<div  style="display: flex; margin-top: 5px;">
										<div class="importance" style="background-color: #FEA800; width: 100px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;" >
											${dto.importance}<!-- DB에 입력되어있는 중요도 -->
										</div>
										<div class="importance" style="background-color: #9F45E3; color : white; width: 100px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;" >
											${dto.category}<!-- DB에 입력되어있는 분류 -->
										</div>
										<div style="color: gray; width: 150px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
											${dto.duedate}
										</div>
									</div>
									<div class="todoDetail" style=""  >
										${dto.detail}
									</div>
									</div>
								</c:if>
								</c:forEach>
								<!-- 포문 여기서 끝 -->
								<div class="todoFooter">
								<img src="${pageContext.request.contextPath}/resources/images/add.png" style="width: 15px; height: 15px;" onclick="openModal2()"/> <div style="color: gray; font-size: small;"onclick="openModal2()"> Add task</div>
								</div>
							</div>
						</div>
						
						<!-- Upcoming -->
						<div id="To do" style="" class="todoBox">
							<div class="arrangeBox" > 
								<b class="todoBoxTitle">Upcoming tasks</b> <img src="${pageContext.request.contextPath}/resources/images/add.png" style="width: 20px; height: 20px;" onclick="openModal2()"/>
							</div>
							<div style="overflow-y: auto; height: 95%; margin-top: 20px; padding-right: 10px;" ><!-- 여기에 투두리스트 보여짐  -->
							<!-- 여기부터 포문 돌리는 영역 -->
							<c:forEach items="${list}" var="dto">
							<c:if test="${dto.checkstatus == '2'&&dto.isdone=='0'}">
								<div class="innerTodoBox" >
								<div class="arrangeBox" >
									<div style="display: flex; text-align: center;" > 
										<input type="checkbox" onclick="checkTodo(${dto.todoid}, this.checked)"
									${dto.isdone == 1 ? 'checked' : ''} data-todoid="${dto.todoid}"
									data-done="${dto.isdone}"  id="check-${dto.todoid}" > <label for="check-${dto.todoid}"></label> 
									<div class="No-line-break" style="text-align: center; height: 30px; vertical-align: middle;">${dto.task}</div>
									</div>  
									<img src="${pageContext.request.contextPath}/resources/images/more.png" style="width: 20px; height: 20px;" onclick="openModal('${dto.todoid}', '${dto.task}','${dto.importance}','${dto.category}','${dto.progress}','${dto.duedate}','${dto.detail}')" />
								</div>	
									<div  style="display: flex; margin-top: 5px;">
										<div class="importance" style="background-color: #FEA800; width: 100px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;" >
											${dto.importance}<!-- DB에 입력되어있는 중요도 -->
										</div>
										<div class="importance" style="background-color: #9F45E3; color : white;  width: 100px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;" >
											${dto.category}<!-- DB에 입력되어있는 분류 -->
										</div>
										<div style="color: gray; width: 150px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
											${dto.duedate}
										</div>
									</div>
									<div class="todoDetail" style=""  >
										${dto.detail}
									</div>
									</div>
								</c:if>
								</c:forEach>
								<!-- 포문 여기서 끝 -->
								
								<div class="todoFooter">
								<img src="${pageContext.request.contextPath}/resources/images/add.png" style="width: 15px; height: 15px;" onclick="openModal2()"/> <div style="color: gray; font-size: small;"onclick="openModal2()"> Add task</div>
								</div>
							</div>
						</div>
						
						
						<div id="Done" class="todoBox">
							<div class="arrangeBox" >
								<b class="todoBoxTitle">Done</b> <img src="${pageContext.request.contextPath}/resources/images/add.png" style="width: 20px; height: 20px;"  onclick="openModal2()"/>
							</div>
							<div style="overflow-y: auto; height: 95%; margin-top: 20px;  padding-right: 10px;/* filter: blur(1px);  */">  <!-- 여기에 투두리스트 보여짐  -->
							<!-- 여기부터 포문 돌리는 영역 -->
							<c:forEach items="${list}" var="dto">
							<c:if test="${dto.isdone=='1'}">
								<div class="innerTodoBox">
								<div class="arrangeBox" >
									<div style="display: flex; text-align: center;" > 
										<input type="checkbox" onclick="checkTodo(${dto.todoid}, this.checked)"
									${dto.isdone == 1 ? 'checked' : ''} data-todoid="${dto.todoid}"
									data-done="${dto.isdone}"  id="check-${dto.todoid}" > <label for="check-${dto.todoid}"></label> 
									<div class="No-line-break" style="text-align: center; height: 30px; vertical-align: middle;">${dto.task}</div>
									</div>  
									<img src="${pageContext.request.contextPath}/resources/images/more.png" style="width: 20px; height: 20px;" onclick="openModal('${dto.todoid}', '${dto.task}','${dto.importance}','${dto.category}','${dto.progress}','${dto.duedate}','${dto.detail}')" />
								</div>	
									<div  style="display: flex; margin-top: 5px;">
										<div class="importance" style="background-color: #FEA800; width: 100px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; " >
											${dto.importance}<!-- DB에 입력되어있는 중요도 -->
										</div>
										<div class="importance" style="background-color: #9F45E3; color : white; width: 100px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;" >
											${dto.category}<!-- DB에 입력되어있는 분류 -->
										</div>
										<div style="color: gray; width: 150px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
											${dto.duedate}
										</div>
									</div>
									<div class="todoDetail" style=""  >
										${dto.detail}
									</div>
									</div>
								</c:if>
								</c:forEach>
								<!-- 포문 여기서 끝 -->
								
								<div class="todoFooter">
								<img src="${pageContext.request.contextPath}/resources/images/add.png" style="width: 15px; height: 15px;" onclick="openModal2()"/> <div style="color: gray; font-size: small;"onclick="openModal2()"> Add task</div>
								</div>
							</div>
						</div>
					</div>
			
					<!-- 성은 수정 끝 -->
<%-- 					<ul class="todo_list">
						<c:forEach items="${list}" var="dto">
							<div class="flex_box">
								<li class="todo_item ${dto.isdone == 1 ? 'checked' : ''}">
									<input type="checkbox"
									onclick="checkTodo(${dto.todoid}, this.checked)"
									${dto.isdone == 1 ? 'checked' : ''} data-todoid="${dto.todoid}"
									data-done="${dto.isdone}"> <span class="task">${dto.todoid}&nbsp;&nbsp;${dto.task}</span>
								</li> <a href="todoStatus?todoid=${dto.todoid}&userno=${dto.userno}" class="deleteButton1">X</a>
							</div>

						</c:forEach>
					</ul>
					<div>
						<span id="todo_rate" style="text-align: center;">0 /
							${list.size()}</span>
					</div>
					<form action="todoWrite" method="post">
						<div>
							<input type="text" name="task" id="new-task"
								placeholder="할 일을 입력하세요"> <input type="submit"
								value="추가하기" class="addButton">
						</div>
					</form>--%>
				</div>
			</div>
		</div>
	</div> 
	
	
<!--  모달창 영역  -->
<div id="myModal" class="modal0">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h3>TO DO 수정하기</h3>
        <p>제목</p>
        <input type="text" value="팀 회의하기"  id="todoTitle-edit" name="todoTitle-edit" class="modal-input-text"/>
        <p>중요도</p>
         <select id="todoEditImportance" name="todoEditImportance" class="modal-input-text"> 
            <option value="High">High</option>
            <option value="Medium">Medium</option>
            <option value="Low">Low</option>
        </select>
        <p>분류</p>
        <select id="todoCategory" name="todoCategory" class="modal-input-text"> 
            <option value="개인">개인</option>
            <option value="회사">회사</option>
            <option value="대출관리">대출관리</option>
            <option value="Other">Other</option>
        </select>
        <p>종료일</p>
        <input type="date" value="2024-08-05"  id="todoDuedate" name="todoDuedate" class="modal-input-text"/>
        <p>내용</p>
        <input type="text"  placeholder="투두리스트에 대한 상세한 설명을 넣어놓는 곳입니다. "  id="todoDetail" name="todoDetail" class="modal-input-text"/>
        
        <div style="display: flex; justify-content: right; gap: 10px; margin-top : 20px;">
        	<button  class="styled-button" onclick="editTodo()">수정하기</button> <button class="styled-button" onclick="openDeleteModal2()">삭제</button> <button class="styled-button" onclick="closeModal()">닫기</button>
        </div>
    </div>
</div>

<script>
    // Modal 열기(수정모달)
    function openModal(todoid, task, importance, todoCategory, todoprogress, duedate, detail) {
        document.getElementById("myModal").style.display = "flex";
        $("#todoTitle-edit").val(task);
        $("#todoid").val(todoid); 
         
        $("#todoEditImportance").val(importance); 
        $("#todoCategory").val(todoCategory); 
        $("#todoprogress").val(todoprogress); 
        $("#todoDuedate").val(duedate); 
        $("#todoDetail").val(detail); 
    }

    // Modal 닫기(수정모달)
    function closeModal() {
        document.getElementById("myModal").style.display = "none";
    }

    // 사용자가 모달 창 외부를 클릭했을 때 닫기(수정모달)
    window.onclick = function(event) {
        var modal = document.getElementById("myModal");
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
    
    //수정하기 눌렀을 때 실행할 것.
    function editTodo(){
    	
    	var todoid = $("#todoid").val();   
    	var task = $("#todoTitle-edit").val();    
    	var duedate = $("#todoDuedate").val()+" 09:00:00";  
    	var importance = $("#todoEditImportance").val();  
    	var category = $("#todoCategory").val(); 
    	var detail = $("#todoDetail").val(); 
    	
        fetch('${pageContext.request.contextPath}/editTodo', {   
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                todoid: todoid,
                task : task,
                duedate: duedate,
                importance : importance,
                category : category,
                detail : detail
            })
        })
        .then(response => response.json())
        .then(data => {
            console.log('Success:', data);
            if(data.status == "success"){
            	alert("정상적으로 수정되었습니다.");
            	document.getElementById("myModal").style.display = "none";
            	location.reload();
            }
        })
        .catch((error) => {
            console.error('Error:', error);
        });
    }
    
    
</script>
<!-- 모달창 영역 2 (추가하기) -->
<div id="myModal2" class="modal0">
    <div class="modal-content">
        <span class="close" onclick="closeModal2()">&times;</span>
        <h3>TO DO 추가하기</h3>
        <p>제목</p>
        <input type="text" value="" placeholder="일정 제목을 입력하세요." id="todoTitle-add" name="todoTitle-add" class="modal-input-text"/>
        <p>중요도</p>
         <select id="todoEditImportance-add" name="todoEditImportance-add" class="modal-input-text"> 
            <option value="Low">Low</option>
            <option value="Medium">Medium</option>
            <option value="High">High</option>
        </select>
        <p>분류</p>
        <select id="todoCategory-add" name="todoCategory-add" class="modal-input-text"> 
            <option value="개인">개인</option>
            <option value="회사">회사</option>
            <option value="대출관리">대출관리</option>
            <option value="Other">Other</option>
        </select>
        <p>종료일</p>
        <input type="date" value=""  id="todoDuedate-add" name="todoDuedate-add" class="modal-input-text"/>
        <p>내용</p>
        <input type="text" placeholder="투두리스트에 대한 상세한 설명을 넣어놓는 곳입니다. "  id="todoDetail-add" name="todoDetail-add" class="modal-input-text"/>
        
        <div style="display: flex; justify-content: right; gap: 10px; margin-top : 20px;">
        	<button  class="styled-button" onclick="addTodo()">등록하기</button> <button class="styled-button" onclick="closeModal2()">닫기</button>
        </div>
    </div>
</div>

<div id="deleteModal" class="modal2" >
	<div style="	background-color: #fefefe; margin : auto; padding: 20px; border: 1px solid #888; width: 30%; height: 30%;  text-align: center;">
	<span class="close" onclick="closeDeleteModal()">&times;</span>
	<img src="${pageContext.request.contextPath}/resources/images/warning.png" style="margin-top: 20px;"/>
		<h2 style="margin-top: 10px;">정말 삭제하시겠습니까 ?</h2>
		<p>삭제한 일정은 복구할 수 없습니다.</p>
		<div style="display: flex; justify-content: center; gap: 30px; margin-top : 20px;">
			<button class="styled-button" onclick="closeDeleteModal()">취소</button><button class="styled-button" onclick="deleteTodo()">삭제</button>
		</div>
	</div>
</div>

    <input type="hidden" id="todoid" name="todoid" value=""/>
    <input type="hidden" id="userno" name="userno" value=""/>
    <input type="hidden" id="task" name="task" value=""/>
    <input type="hidden" id="startdate" name="startdate" value=""/>
    <input type="hidden" id="duedate" name="duedate" value=""/>
    <input type="hidden" id="isdone" name="isdone" value=""/>
    <input type="hidden" id="importance" name="importance" value=""/>
    <input type="hidden" id="progress" name="progress" value=""/>
    <input type="hidden" id="category" name="category" value=""/>

<script>
    // Modal 열기
    function openModal2() {
        document.getElementById("myModal2").style.display = "flex";
        setTodayDate();
    }
    
    //등록하기 눌렀을 때 실행할 것.
    function addTodo(){
    	var task = $("#todoTitle-add").val();    
    	var duedate = $("#todoDuedate-add").val()+" 09:00:00";  
    	var importance = $("#todoEditImportance-add").val();  
    	//var progress = $("#todoprogress-add").val();   
    	var category = $("#todoCategory-add").val(); 
    	var detail = $("#todoDetail-add").val(); 
    	var userno = '<%= userno %>';
    	
    	if(task==""||task==null){
    		alert("제목을 입력하세요.");
    		return;
    	}
    	
        fetch('${pageContext.request.contextPath}/addTodo', {   
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
            	userno : userno,
                task : task,
                duedate: duedate,
                importance : importance,
                category : category,
                detail : detail
            })
        })
        .then(response => response.json())
        .then(data => {
            console.log('Success:', data);
            if(data.status == "success"){
            	alert("정상적으로 등록되었습니다.");
            	document.getElementById("myModal2").style.display = "none";
            	location.reload();
            }
            	
        })
        .catch((error) => {
            console.error('Error:', error);
        });
    }
    
    //삭제하기 눌렀을 때 실행할 것.
    function deleteTodo(){
    	var todoid = $("#todoid").val(); 
    	
        fetch('${pageContext.request.contextPath}/deleteTodo', {   
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
            	todoid : todoid
            })
        })
        .then(response => response.json())
        .then(data => {
            console.log('Success:', data);
            if(data.status == "success"){
            	alert("정상적으로 삭제되었습니다.");
            	document.getElementById("deleteModal").style.display = "none";
            	document.getElementById("myModal2").style.display = "none";
            	location.reload();
            }
        })
        .catch((error) => {
            console.error('Error:', error);
        });
    }
    
    // Modal2 열기 (삭제여부 묻는 창)
    function openDeleteModal2() {
        document.getElementById("deleteModal").style.display = "flex";
    }

    // Modal 닫기
    function closeModal2() {
        document.getElementById("myModal2").style.display = "none";
    }
    function closeDeleteModal() {
        document.getElementById("deleteModal").style.display = "none";
    }

    // 사용자가 모달 창 외부를 클릭했을 때 닫기
    window.onclick = function(event) {
        var modal = document.getElementById("myModal2");
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
    window.onclick = function(event) {
        var modal = document.getElementById("deleteModal");
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
    
    // ESC 키를 눌렀을 때 모달 닫기
    document.onkeydown = function(event) {
        if (event.key === 'Escape') {
            closeModal();
            closeModal2();
            closeDeleteModal();
        }
    }

// TODOLIST 업데이트 로직
function checkTodo(todoid, isChecked) {
    console.log("Todo ID:", todoid);
    var isCheckedNum = isChecked ? 1 : 0;
    console.log("상태확인", isChecked);
    console.log("Is Done:", isCheckedNum);
    
    var checkbox = document.querySelector('input[data-todoid="' + todoid + '"]');
    checkbox.dataset.done = isCheckedNum;
    
    fetch('${pageContext.request.contextPath}/todolistCheck', {   
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            todoid: todoid,
            isdone: isCheckedNum
        })
    })
    .then(response => response.json())
    .then(data => {
        console.log('Success:', data);
        location.reload();
    })
    .catch((error) => {
        console.error('Error:', error);
    });
}

    // 현재 날짜를 가져와서 'YYYY-MM-DD' 형식으로 변환
    function setTodayDate() {
        const today = new Date();
        const year = today.getFullYear();
        const month = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더합니다.
        const day = String(today.getDate()).padStart(2, '0'); // 날짜를 두 자리로 맞춥니다.
        const formattedDate = year+'-'+month+'-'+ day;
        console.log(formattedDate);
        // 날짜 입력 필드에 오늘 날짜를 설정합니다.
        document.getElementById('todoDuedate-add').value = formattedDate;
    }

</script>
</body>
</html>
