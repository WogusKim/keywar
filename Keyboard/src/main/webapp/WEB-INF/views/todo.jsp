<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/main.css">
<style>
ul {
	list-style-type: none; /* 리스트 스타일을 없앱니다 */
	padding: 0;
}

li {
	margin-bottom: 10px; /* 각 항목 사이에 여백을 줍니다 */
	display: flex; /* 수평 배치 설정 */
	align-items: center; /* 수직 가운데 정렬 */
}

li.checked .task {
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
				<div class="board_todo">
					<!-- 흰 배경 -->
					<h2 class="card_title">To-Do List</h2>
					<hr>

					<ul class="todo_list">
						<c:forEach items="${list}" var="dto">
							<div class="flex_box">
								<li class="todo_item ${dto.isdone == 1 ? 'checked' : ''}">
									<input type="checkbox"
									onclick="checkTodo(${dto.todoid}, this.checked)"
									${dto.isdone == 1 ? 'checked' : ''} data-todoid="${dto.todoid}"
									data-done="${dto.isdone}"> <span class="task">${dto.todoid}&nbsp;&nbsp;${dto.task}</span>
								</li> <a href="#" class="deleteButton1">X</a>
							</div>

						</c:forEach>
					</ul>
					<div>
						<span id="todo_rate" style="text-align: center;">0 /
							${list.size()}</span>
					</div>
					<form action="todoWrite" method="post">
						<div style="margin-top: 20px;">
							<input type="text" name="task" id="new-task"
								placeholder="할 일을 입력하세요"> <input type="submit"
								value="추가하기" class="addButton">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

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
</body>
</html>
