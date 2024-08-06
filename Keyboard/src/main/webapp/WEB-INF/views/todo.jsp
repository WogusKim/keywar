<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김국민의 업무노트 : TO DO LIST</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/main.css">
<style>
.board_todo ul {
	list-style-type: none; /* 리스트 스타일을 없앱니다 */
	padding: 0;
}

.board_todo li {
	margin-bottom: 10px; /* 각 항목 사이에 여백을 줍니다 */
	display: flex; /* 수평 배치 설정 */
	align-items: center; /* 수직 가운데 정렬 */
}

.board_todo li.checked .task {
	text-decoration: line-through; /* 체크된 항목에만 삭선 적용 */
}

#new-task {
	flex: 1; /* 입력창이 남은 공간을 모두 차지하도록 설정 */
	padding: 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 10px;
	margin-right: 10px; /* 입력창과 버튼 사이에 오른쪽 여백 추가 */
}

.deleteButton1 {
	margin-left: 10px; /* 할 일 문구와 삭제 버튼 사이에 여백 추가 */
	margin-bottom: 10px;
	cursor: pointer; /* 커서가 포인터로 변경되도록 설정 */
	color: red; /* 삭제 버튼을 빨간색으로 설정 */
	text-decoration: none; /* 삭제 버튼에 삭선 제거 */
}

.flex_box {
	display: flex;
	align-items: center; /* 수직 가운데 정렬 */
}
</style>
</head>

<body>

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
					<style>
					.todoBox{
						padding: 20px; 
						width : 32%; 
						height: 100%;
						overflow-y: auto; 
					}
					.todoBoxTitle{
						font-size: 20px; 
						font-weight: bold;
					}
					.arrangeBox{
						display: flex;
						justify-content: space-between;
					}
					.innerTodoBox{
						border-radius: 15px; 
						/* background-color: #F2F2F2; */
			 			border: 1px solid #F2F2F2; 
						height: 150px; 
						width : 100%;
						margin-top: 20px;
						padding: 15px;
						box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
					}
					.importance{
						width : 100px;
						border-radius: 15px; 
						text-align: center;
						display: flex;
						justify-content: center;
						vertical-align: middle;
						margin-right: 10px;
					}
					.todoDetail{
						margin-top: 10px; 
						width: 100%; 
						height: 50px;  
						overflow: hidden; 
						text-overflow: ellipsis;  
						display: -webkit-box; 
						-webkit-line-clamp: 2; 
						-webkit-box-orient: vertical;  
						white-space: normal;  
						line-height: 1.5;
					}
				    /* 기본 체크박스 감춤 */
				    #check{
				        display: none;
				    }
				    /* off */
				    #check+label{ 
				        background-repeat: no-repeat; /* 반복 방지 */
				        background-image: url('${pageContext.request.contextPath}/resources/images/checkbox.png'); /*off 이미지*/
				    }
				    /* on */
				    #check:checked+label{
				        background-repeat: no-repeat; /* 반복 방지 */
				        background-image: url('${pageContext.request.contextPath}/resources/images/checked.png'); /*on 이미지*/
				    }
				    label{ 
				        display: block; 
				        width:30px;
				        height:30px;
				    }
					</style>
					<div style="height: 90%; display: flex; justify-content:  space-between; padding: 10px;">
						<div id="To do" style="" class="todoBox">
							<div class="arrangeBox" > 
								<b class="todoBoxTitle">To do</b> <img src="${pageContext.request.contextPath}/resources/images/add.png" style="width: 20px; height: 20px;" onclick="openModal2()"/>
							</div>
							<div >  <!-- 여기에 투두리스트 보여짐  -->
							<!-- 여기부터 포문 돌리는 영역 -->
							<c:forEach items="${list}" var="dto">
								<div class="innerTodoBox">
								<div class="arrangeBox" >
									<div style="display: flex; text-align: center;" > 
										<input type="checkbox" id="check"><label for="check"></label>  <div style="text-align: center; height: 30px; vertical-align: middle;">${dto.task}</div>
									</div>  
									<img src="${pageContext.request.contextPath}/resources/images/more.png" style="width: 20px; height: 20px;" onclick="openModal()" />
								</div>	
									<div  style="display: flex; margin-top: 5px;">
										<div class="importance" style="background-color: #FEA800;" >
											${dto.importance}<!-- DB에 입력되어있는 중요도 -->
										</div>
										<div class="importance" style="background-color: #9F45E3; color : white;" >
											${dto.category}<!-- DB에 입력되어있는 분류 -->
										</div>
										<div style="color: gray; width: 150px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
											${dto.duedate}
										</div>
									</div>
									<div class="todoDetail" style=""  >
										투두리스트에 대한 상세한 설명을 넣어놓는 곳입니다. 
									</div>
								</div>
								</c:forEach>
								<!-- 포문 여기서 끝 -->
								
								<div style="display: flex; justify-content: center; margin-top: 10px;">
								<img src="${pageContext.request.contextPath}/resources/images/add.png" style="width: 15px; height: 15px;" onclick="openModal2()"/> <div style="color: gray; font-size: small;"onclick="openModal2()"> Add task</div>
								</div>
							</div>
						</div>
						<div id="In progress" style="background-color: green;"class="todoBox">
							<div class="arrangeBox" >
								<b class="todoBoxTitle">In progress</b> <img src="${pageContext.request.contextPath}/resources/images/add.png" style="width: 20px; height: 20px;"/>
							</div>
						</div>
						<div id="Done" style="background-color: pink;"class="todoBox">
							<div class="arrangeBox" >
								<b class="todoBoxTitle">Done</b> <img src="${pageContext.request.contextPath}/resources/images/add.png" style="width: 20px; height: 20px;"/>
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
					</form> --%>
				</div>
			</div>
		</div>
	</div>
	
	
<!--  모달창 영역  -->
<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h3>TO DO 수정하기</h3>
        <p>제목</p>
        <input type="text" value="팀 회의하기"  id="todoTitle" name="todoTitle" class="modal-input-text"/>
        <p>중요도</p>
         <select id="todoPriority" name="todoPriority" class="modal-input-text"> 
            <option value="high">High</option>
            <option value="medium">Medium</option>
            <option value="low">Low</option>
        </select>
        <p>분류</p>
        <select id="todoCategory" name="todoCategory" class="modal-input-text"> 
            <option value="high">대출관리</option>
            <option value="medium">개인</option>
            <option value="low">Other</option>
        </select>
        <p>진행상태</p>
        <select id="todoCategory" name="todoCategory" class="modal-input-text"> 
            <option value="high">To do</option>
            <option value="medium">In progress</option>
            <option value="low">Done</option>
        </select>
        <p>종료일</p>
        <input type="date" value="2024-08-05"  id="todoTitle" name="todoTitle" class="modal-input-text"/>
        <p>내용</p>
        <input type="text" value="투두리스트에 대한 상세한 설명을 넣어놓는 곳입니다. "  id="todoTitle" name="todoTitle" class="modal-input-text"/>
        
        <div style="display: flex; justify-content: right; gap: 10px; margin-top : 30px;">
        	<button  class="styled-button" >수정하기</button> <button class="styled-button" onclick="openDeleteModal2()">삭제</button> <button class="styled-button" onclick="closeModal()">닫기</button>
        </div>
    </div>
</div>

<script>
    // Modal 열기
    function openModal() {
    	updateFormAction("${pageContext.request.contextPath}/editTodo");
        document.getElementById("myModal").style.display = "flex";
    }

    // Modal 닫기
    function closeModal() {
        document.getElementById("myModal").style.display = "none";
    }

    // 사용자가 모달 창 외부를 클릭했을 때 닫기
    window.onclick = function(event) {
        var modal = document.getElementById("myModal");
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>
<!-- 모달창 영역 2 (추가하기) -->
<div id="myModal2" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal2()">&times;</span>
        <h3>TO DO 추가하기</h3>
        <p>제목</p>
        <input type="text" value="" placeholder="일정 제목을 입력하세요." id="task" name="todoTitle" class="modal-input-text"/>
        <p>중요도</p>
         <select id="todoPriority" name="todoPriority" class="modal-input-text"> 
            <option value="low">Low</option>
            <option value="medium">Medium</option>
            <option value="high">High</option>
        </select>
        <p>분류</p>
        <select id="todoCategory" name="todoCategory" class="modal-input-text"> 
            <option value="medium">개인</option>
            <option value="high">대출관리</option>
            <option value="low">Other</option>
        </select>
        <p>진행상태</p>
        <select id="todoCategory" name="todoCategory" class="modal-input-text"> 
            <option value="high">To do</option>
            <option value="medium">In progress</option>
            <option value="low">Done</option>
        </select>
        <p>종료일</p>
        <input type="date" value="2024-08-05"  id="duedate" name="duedate" class="modal-input-text"/>
        <p>내용</p>
        <input type="text" placeholder="투두리스트에 대한 상세한 설명을 넣어놓는 곳입니다. "  id="todoTitle" name="todoTitle" class="modal-input-text"/>
        
        <div style="display: flex; justify-content: right; gap: 10px; margin-top : 30px;">
        	<button  class="styled-button" >등록하기</button> <button class="styled-button" onclick="closeModal2()">닫기</button>
        </div>
    </div>
</div>
<div id="deleteModal" class="modal2">
	<div class="modal-content">
	<span class="close" onclick="closeDeleteModal()">&times;</span>
		정말 삭제하시겠습니까 ?
	</div>
</div>
<form id="addTodo" method="post" action="/submit-url">
    <input type="hidden" id="todoid" name="todoid" value=""/>
    <input type="hidden" id="userno" name="userno" value=""/>
    <input type="hidden" id="task" name="task" value=""/>
    <input type="hidden" id="startdate" name="startdate" value=""/>
    <input type="hidden" id="duedate" name="duedate" value=""/>
    <input type="hidden" id="isdone" name="isdone" value=""/>
    <input type="hidden" id="importance" name="importance" value=""/>
    <input type="hidden" id="progress" name="progress" value=""/>
    <input type="hidden" id="category" name="category" value=""/>
</form>
<script>
    // Modal 열기
    function openModal2() {
    	updateFormAction("${pageContext.request.contextPath}/addTodo");
        document.getElementById("myModal2").style.display = "flex";
    }
    // Modal2 열기
    function openDeleteModal2() {
    	updateFormAction("${pageContext.request.contextPath}/deleteTodo");
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
</script>

<style>
/* Modal Container */
.modal { 
 	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgb(0, 0, 0);
	background-color: rgba(0, 0, 0, 0.4);
	justify-content: center;
 	text-align: center;  
} 
/* Modal2 Container */
.modal2 { 
 	display: none;
	position: fixed;
	z-index: 2;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgb(0, 0, 0);
	background-color: rgba(0, 0, 0, 0.4);
	justify-content: center;
 	text-align: center;  
} 
/* Modal Content */
.modal-content {
	background-color: #fefefe;
	margin : auto;
	padding: 20px; 
	border: 1px solid #888;
	width: 25%;
	height: 73%; 
	text-align: left;
}
/* Close Button */
.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}
.modal-input-text{
	width: 100%;
	padding:10px;
	font-size: 12px;
	border: 1px solid gray; 
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	transition: border-color 0.3s, box-shadow 0.3s;
	outline: none;
}
.styled-button {
    background-color: #6200ea;
    color: white;
	padding : 10px;
    font-size: 12px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s, transform 0.3s;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    text-transform: uppercase;
}

.styled-button:hover {
    background-color: #3700b3;
    transform: scale(1.05);
}

.styled-button:active {
    background-color: #1a00e6;
    transform: scale(1);
}

.styled-button:focus {
    outline: none;
    box-shadow: 0 0 0 3px rgba(98, 0, 234, 0.5);
}

</style>


	<script>
// TODOLIST 업데이트 로직
function checkTodo(todoid, isChecked) {
    console.log("Todo ID:", todoid);
    var isCheckedNum = isChecked ? 1 : 0;
    console.log("상태확인", isChecked);
    console.log("Is Done:", isCheckedNum);
    
    var checkbox = document.querySelector('input[data-todoid="' + todoid + '"]');
    checkbox.dataset.done = isCheckedNum;
    updateTodoCount();
    
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
    })
    .catch((error) => {
        console.error('Error:', error);
    });
}

// 전체 할 일의 완료 현황을 업데이트하는 함수
function updateTodoCount() {
    var checkboxes = document.querySelectorAll('.todo_list input[type="checkbox"]');
    var total = checkboxes.length;
    var completed = Array.from(checkboxes).filter(cb => cb.checked).length;

    document.getElementById('todo_rate').textContent = completed + ' / ' + total;
}

document.addEventListener('DOMContentLoaded', (event) => {
    const todos = document.querySelectorAll('.todo_list input[type="checkbox"]');
    todos.forEach(checkbox => {
        const listItem = checkbox.closest('li');
        if (checkbox.checked) {
            listItem.classList.add('checked');
        } else {
            listItem.classList.remove('checked');
        }

        checkbox.addEventListener('change', function() {
            if (this.checked) {
                listItem.classList.add('checked');
            } else {
                listItem.classList.remove('checked');
            }
            checkTodo(this.getAttribute('data-todoid'), this.checked);
        });
    });

    updateTodoCount();
});
</script>
    <script>
        // 현재 날짜를 가져와서 'YYYY-MM-DD' 형식으로 변환
        function setTodayDate() {
            const today = new Date();
            const year = today.getFullYear();
            const month = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더합니다.
            const day = String(today.getDate()).padStart(2, '0'); // 날짜를 두 자리로 맞춥니다.
            const formattedDate = `${year}-${month}-${day}`;

            // 날짜 입력 필드에 오늘 날짜를 설정합니다.
            document.getElementById('duedate').value = formattedDate;
        }
        function updateFormAction(newActionUrl) {
            // 폼 요소를 가져옵니다.
            var form = document.getElementById('addTodo');
            // 새로운 action URL을 설정합니다.
            form.action = newActionUrl;
        }

        // 페이지 로드 시 현재 날짜를 설정합니다.
        window.onload = setTodayDate;
    </script>
</body>
</html>
