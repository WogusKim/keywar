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
}

.checkbox-container {
    display: flex;
    align-items: center;
}

.checkbox {
    width: 20px;
    height: 20px;
    border: 1px solid #2b2d42;
    border-radius: 5px;
    margin-right: 10px;
    cursor: pointer;
    display: flex;
    justify-content: center;
    align-items: center;
}

.checkbox.checked {
    background-color: #2b2d42;
}

.checkbox i {
    color: white;
}

#new-task {
    flex: 1;                        /* 입력창이 남은 공간을 모두 차지하도록 설정 */
    padding: 10px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 10px;
    margin-right: 10px;             /* 입력창과 버튼 사이에 오른쪽 여백 추가 */
}
</style>
</head>

<body>

    <%@ include file="/WEB-INF/views/header.jsp"%>

    <div class="content_outline">
        <%@ include file="/WEB-INF/views/sidebar.jsp"%>        
        <div class="content_right"> <!-- 여기까지 기본세팅(흰 배경) -->
        
            <div class="board_back"> <!-- 민트 배경 -->
                <div class="board_todo"> <!-- 흰 배경 -->
                    <h2 class="card_title">To-Do List</h2>
                    <hr>
                    <ul id="todo-list">
                    <c:forEach items="${list}" var="dto">
                        <li>
                            <div class="checkbox-container">
                                <div class="checkbox"></div>
                                <i>${dto.task}</i>
                            </div>
                        </li>
                    </c:forEach>
                    </ul>
                    <p>현황 3/4</p>

                    <div style="margin-top: 20px;">
                        <input type="text" id="new-task" placeholder="할 일을 입력하세요">
                        <input type="button" value="추가하기" class="addButton" onclick="addTask()">
                    </div>
                </div>
                
            </div>
        </div>
    </div>

    <script>
        function addTask() {
            var newTaskInput = document.getElementById("new-task");
            var newTaskText = newTaskInput.value;
            if (newTaskText.trim() !== "") {
                var todoList = document.getElementById("todo-list");
                var newTaskItem = document.createElement("li");
                newTaskItem.innerHTML = `
                    <li>
                        <div class="checkbox-container">
                            <div class="checkbox"></div>
                            <i>${newTaskText}</i>
                        </div>
                    </li>`;
                todoList.appendChild(newTaskItem);
                newTaskInput.value = ""; // Clear input field
            }
        }

        document.querySelectorAll('.checkbox').forEach(item => {
            item.addEventListener('click', event => {
                item.classList.toggle('checked');
            });
        });
    </script>

</body>
</html>
