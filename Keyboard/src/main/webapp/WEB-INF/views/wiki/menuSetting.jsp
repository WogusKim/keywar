<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/wiki.css">
<style>
.folder-icon {
    background-image: url('${pageContext.request.contextPath}/resources/images/icons/folder_open.png');
}

.file-icon {
    background-image: url('${pageContext.request.contextPath}/resources/images/icons/page.png');
}

.menu-icon {
	background-image: url('${pageContext.request.contextPath}/resources/images/icons/menu_setting.png');
}

.back-icon {
	background-image: url('${pageContext.request.contextPath}/resources/images/icons/back.png');
}

.plus-icon {
	background-image: url('${pageContext.request.contextPath}/resources/images/icons/plus.png');
}

.minus-icon {
	background-image: url('${pageContext.request.contextPath}/resources/images/icons/minus.png');
}

.edit-icon {
	background-image: url('${pageContext.request.contextPath}/resources/images/icons/edit.png');
}
</style>
</head>

<body>

<c:if test="${not empty sessionScope.errorMessage}">
    <script>alert('${sessionScope.errorMessage}');</script>
    <c:remove var="errorMessage" scope="session"/> <!-- 메시지 표시 후 세션에서 제거 -->
</c:if>

<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="content_outline">
	<div class="menuSetting_l">
	    <div class="menu-tree">
	    <h3>My Menu</h3>
		    <div class="menu_list">
		        <!-- <div class="icon folder-icon" onclick="selectFolder(this, 0, 'root', 0, '나의 업무노트')"></div> -->
		        <span onclick="selectFolder(this, 0, 'root', -1, '나의 업무노트')">나의 업무노트</span>
		    </div>
		    <hr>
	        <ul>
	            <c:forEach var="menu" items="${menus}">
	                <li>
	                	<div class="menu_list">
		                    <div class="icon ${menu.menuType == 'folder' ? 'folder-icon' : 'file-icon'}" data-toggle="${menu.menuType}" onclick="toggleFolder(this)"></div>
		                    <!--span onclick="selectFolder(this, ${menu.id})">${menu.title}</span -->
							<span onclick="selectFolder(this, ${menu.id}, '${menu.menuType}', ${menu.depth}, '${menu.title}')" 
							      data-id="${menu.id}" 
							      data-menu-type="${menu.menuType}" 
							      data-depth="${menu.depth}">
							    ${menu.title}
							    <font color="red">(${menu.id})</font>
							</span>
	                    </div>
	                    <c:if test="${not empty menu.children}">
	                        <ul>
	                            <c:forEach var="child1" items="${menu.children}">
	                                <li>
	                                	<div class="menu_list">
		                                    <div class="icon ${child1.menuType == 'folder' ? 'folder-icon' : 'file-icon'}" data-toggle="${child1.menuType}" onclick="toggleFolder(this)"></div>
											<span onclick="selectFolder(this, ${child1.id}, '${child1.menuType}', ${child1.depth}, '${child1.title}')" 
											      data-id="${child1.id}" 
											      data-menu-type="${child1.menuType}" 
											      data-depth="${child1.depth}">
											    ${child1.title}
											    <font color="red">(${child1.id})</font>
											</span>
	                                    </div>
	                                    <c:if test="${not empty child1.children}">
	                                        <ul>
	                                            <c:forEach var="child2" items="${child1.children}">
	                                                <li>
	                                                	<div class="menu_list">
		                                                    <div class="icon ${child2.menuType == 'folder' ? 'folder-icon' : 'file-icon'}" data-toggle="${child2.menuType}" onclick="toggleFolder(this)"></div>
															<span onclick="selectFolder(this, ${child2.id}, '${child2.menuType}', ${child2.depth}, '${child2.title}')" 
															      data-id="${child2.id}" 
															      data-menu-type="${child2.menuType}" 
															      data-depth="${child2.depth}">
															    ${child2.title}
															    <font color="red">(${child2.id})</font>
															</span>
	                                                    </div>
	                                                    <c:if test="${not empty child2.children}">
	                                                        <ul>
	                                                            <c:forEach var="child3" items="${child2.children}">
	                                                                <li><div class="menu_list">
		                                                                    <div class="icon ${child3.menuType == 'folder' ? 'folder-icon' : 'file-icon'}" data-toggle="${child3.menuType}" onclick="toggleFolder(this)"></div>
																		<span onclick="selectFolder(this, ${child3.id}, '${child3.menuType}', ${child3.depth}, '${child3.title}')" 
																		      data-id="${child3.id}" 
																		      data-menu-type="${child3.menuType}" 
																		      data-depth="${child3.depth}">
																		    ${child3.title}
																		    <font color="red">(${child3.id})</font>
																		</span>
	                                                                    </div>
	                                                                    <c:if test="${not empty child3.children}">
	                                                                        <ul>
	                                                                            <c:forEach var="child4" items="${child3.children}">
	                                                                                <li>
	                                                                                	<div class="menu_list">
		                                                                                    <div class="icon ${child4.menuType == 'folder' ? 'folder-icon' : 'file-icon'}" data-toggle="${child4.menuType}" onclick="toggleFolder(this)"></div>
																							<span onclick="selectFolder(this, ${child4.id}, '${child4.menuType}', ${child4.depth}, '${child4.title}')" 
																							      data-id="${child4.id}" 
																							      data-menu-type="${child4.menuType}" 
																							      data-depth="${child4.depth}">
																							    ${child4.title}
																							    <font color="red">(${child4.id})</font>
																							</span>
	                                                                                    </div>
	                                                                                </li>
	                                                                            </c:forEach>
	                                                                        </ul>
	                                                                    </c:if>
	                                                                </li>
	                                                            </c:forEach>
	                                                        </ul>
	                                                    </c:if>
	                                                </li>
	                                            </c:forEach>
	                                        </ul>
	                                    </c:if>
	                                </li>
	                            </c:forEach>
	                        </ul>
	                    </c:if>
	                </li>
	            </c:forEach>
	        </ul>
	    </div>
		<div class="menu_back">
		    <div class="icon-setting back-icon"></div>
		    <a href="#" onclick="history.back(); return false;">뒤로가기</a>
		</div>
		<div class="menu_plus">
		    <div class="icon-setting plus-icon"></div>
		    <a href="#" onclick="addNewItem(); return false;">추가</a>
		</div>
		<div class="menu_minus">
		    <div class="icon-setting minus-icon"></div>
		    <a href="#" onclick="deleteSelectedItem()">삭제</a>
		</div>
	</div>

	<div class="content_right">
		<div class="menu_admin">
			<!-- 아무것도클릭하지않았을때 -->
			<div class="default">
				<h1>초기화면</h1>
				<hr>
				<div>
					이곳은 메뉴를 관리하는 곳입니다~~~<br/>
					<ul>
						<li>폴더를 삭제하시면 하위 메뉴가 모두 삭제됩니다.</li>
						<li>페이지를 추가하려면 속할 폴더를 골라주세요.</li>
						<li>최상위 뎁스에 폴더나 페이지를 만드시려면 '나의 업무노트' 를 클릭 후 추가해주시면 됩니다.</li>
					</ul>
				</div>
			</div>
			<!-- 추가하기 버튼 클릭시 -->
			<div class="make_new_one" style="display: none;">
			    <h1 id="addFormTitle">추가하기</h1>
			    <div id="contextMessage"></div>
			    
			    <form action="${pageContext.request.contextPath}/addMenu" method="post">
			        <input type="hidden" id="selectedId" name="id">
			        <input type="hidden" id="selectedType" name="type">
			        <input type="hidden" id="selectedDepth" name="depth">
			        
			        <div class="form-group">
			            <label>메뉴 타입:</label>
			            <label><input type="radio" name="menuType" value="folder" checked> 폴더</label>
			            <label><input type="radio" name="menuType" value="item"> 아이템</label>
			        </div>
			        
			        <div class="form-group">
			            <label>공개 여부:</label>
			            <label><input type="radio" name="public" value="yes" checked> 공개</label>
			            <label><input type="radio" name="public" value="no"> 비공개</label>
			        </div>
			        
			        <div class="form-group">
			            <label for="title">타이틀:</label>
			            <input type="text" id="title" name="title" required>
			        </div>
			
			        <div class="form-group">
			            <label for="sharedTitle">공유용 타이틀:</label>
			            <input type="text" id="sharedTitle" name="sharedTitle">
			        </div>
			        <div class="form-group">
			            <button type="submit">추가하기</button>
			        </div>
			    </form>  
			</div>
			
			<!-- 삭제하기영역 -->
			<div style="display:none">
				<form id="delete_box" action="${pageContext.request.contextPath}/deleteMenu" method="post">
			        <input type="hidden" id="selectedId" name="id">
			        <input type="hidden" id="selectedType" name="type">
			        <input type="hidden" id="selectedDepth" name="depth">
			        <div class="form-group">
			            <button type="submit">삭제하기</button>
			        </div>
			    </form>
			</div>
		</div>
	</div>
</div>

<!-- 페이지 수정 모달 팝업 -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h3>노트(폴더) 수정</h3>
        
        <form id="editForm" action="${pageContext.request.contextPath}/editAction" method="post">
        	<hr class="modal_hr">
        	<div class="input_outer">
	            <input type="hidden" id="editId" name="id">
	            <div class="edit_field">
	                <label for="editTitle" class="label-fixed-width">노트(폴더)제목:</label>
	                <input type="text" id="editTitle" name="title" class="edit_input">
	            </div>
	            <div class="edit_field">
	                <label for="editTitle" class="label-fixed-width">공유용 제목:</label>
	                <input type="text" id="editShareTitle" name="titleShare" class="edit_input">
	            </div>
            </div>
            <hr class="modal_hr">
            <div class="submit_buttonArea">
            	<button class="edit_submit" type="submit">확인</button>
            </div>
        </form>
    </div>
</div>

<script>
function toggleFolder(element) {
    var parentLi = element.closest('li');
    var nextUl = parentLi.querySelector('ul');
    var menuType = element.getAttribute('data-toggle');

    // 폴더 타입일 경우에만 토글 동작 수행
    if (menuType === 'folder') {
        if (!nextUl) {
            element.classList.toggle('folder-open');
            element.classList.toggle('folder-closed');
            element.style.backgroundImage = element.classList.contains('folder-open') ?
                'url("${pageContext.request.contextPath}/resources/images/icons/folder_open.png")' :
                'url("${pageContext.request.contextPath}/resources/images/icons/folder.png")';
            return;
        }

        // ul 요소가 존재하는 경우의 기존 로직 실행
        if (nextUl.style.display === 'none' || !nextUl.style.display) {
            nextUl.style.display = 'block';
            element.style.backgroundImage = 'url("${pageContext.request.contextPath}/resources/images/icons/folder_open.png")';
        } else {
            nextUl.style.display = 'none';
            element.style.backgroundImage = 'url("${pageContext.request.contextPath}/resources/images/icons/folder.png")';
        }
    }
}



function selectFolder(element, id, menuType, depth, title) {
    // 모든 메뉴에서 'selected' 클래스 및 수정 아이콘 제거
    const previouslySelected = document.querySelectorAll('.selected');
    previouslySelected.forEach(span => {
        span.classList.remove('selected');
        const editIcon = span.parentNode.querySelector('.edit-icon'); // span의 부모 요소에서 수정 아이콘 찾기
        if (editIcon) {
            editIcon.remove(); // 수정 아이콘 제거
        }
    });

    // 현재 선택된 메뉴에 'selected' 클래스 추가
    element.classList.add('selected');
    
    // 수정 아이콘 추가 (중복 생성 방지)
    if (!element.parentNode.querySelector('.edit-icon')) {
        const editIcon = document.createElement('img');
        editIcon.className = 'edit-icon';
        editIcon.src = "${pageContext.request.contextPath}/resources/images/icons/edit.png";
        editIcon.style.cssText = "width: 16px; height: 16px; margin-left: 5px; vertical-align: middle; cursor: pointer;";
        editIcon.onclick = function(event) {
            showEditModal(id);
            event.stopPropagation(); // 이벤트 버블링 방지
        };
        element.parentNode.appendChild(editIcon);
    }

    // 선택된 폴더의 정보를 전역 변수로 저장
    window.selectedFolder = {
        id: id,
        menuType: menuType,
        depth: depth,
        title: title
    };

    // 선택된 폴더의 정보를 콘솔에 출력 (디버깅 목적)
    console.log("Selected Folder:", window.selectedFolder);
}


function updateAddForm(folder) {
    const displayArea = document.querySelector('.make_new_one');
    const titleElement = document.getElementById('addFormTitle');
    const idElement = document.getElementById('selectedId');
    const typeElement = document.getElementById('selectedType');
    const depthElement = document.getElementById('selectedDepth');
    const contextMessage = document.getElementById('contextMessage'); // 메시지를 업데이트할 요소

    // 요소에 값 할당
    titleElement.textContent = `추가하기: ${folder.title}`;

    idElement.value = folder.id;
    typeElement.value = folder.menuType;
    depthElement.value = folder.depth;
    
    // 타입에 따라 적절한 메시지 설정
    if (folder.menuType === 'root') {
        contextMessage.innerHTML = "<h3>최상위에 메뉴얼(폴더)을 추가합니다.</h3>";
    } else if (folder.menuType === 'folder') {
        contextMessage.innerHTML = "<h3>선택된 폴더 하위에 메뉴얼(폴더)을 추가합니다.</h3>";
    } else if (folder.menuType === 'item') {
        contextMessage.innerHTML = "<h3>선택된 메뉴얼과 같은 위치에 메뉴얼(폴더)을 추가합니다.</h3>";
    }

    // 디스플레이 설정
    displayArea.style.display = 'block';
}


function addNewItem() {
    // '추가' 버튼 클릭 시에 선택된 폴더 정보를 사용해 폼 업데이트
    if (window.selectedFolder) {
        updateAddForm(window.selectedFolder);
        document.querySelector('.make_new_one').style.display = 'block';
        document.querySelector('.default').style.display = 'none';
    } else {
        // 폴더가 선택되지 않은 경우, 사용자에게 알림
        alert("폴더를 선택해 주세요.");
    }
}

function deleteSelectedItem() {
    if (!window.selectedFolder) {
        alert("삭제할 폴더나 아이템을 선택해 주세요.");
        return;
    }

    var message;
    if (window.selectedFolder.menuType === 'folder') {
        message = '폴더를 삭제하는 경우 하위 모든 컨텐츠들이 삭제됩니다. 삭제하시겠습니까?';
    } else if (window.selectedFolder.menuType === 'item') {
        message = '해당 페이지를 정말로 삭제하시겠습니까?';
    }

    if (confirm(message)) {
        // 폼에 선택된 폴더의 ID 및 기타 정보를 설정
        var form = document.getElementById('delete_box');
        form.elements['id'].value = window.selectedFolder.id;
        form.elements['type'].value = window.selectedFolder.menuType;
        form.elements['depth'].value = window.selectedFolder.depth;
        form.submit();
    }
}

function showEditModal(id) {
    fetch(`${pageContext.request.contextPath}/editBoardDetails?id=` + id)
        .then(response => response.json())
        .then(data => {
            document.getElementById('editId').value = data.id;
            document.getElementById('editTitle').value = data.title;
            document.getElementById('editShareTitle').value = data.titleShare;
            document.getElementById('editModal').style.display = 'block';
        })
        .catch(error => console.error('Error loading the board details:', error));
}

// 모달 닫기
document.querySelector('.close').onclick = function() {
    document.getElementById('editModal').style.display = 'none';
};

// 폼 제출
document.getElementById('editForm').addEventListener('submit', function(event) {
    var titleInput = document.getElementById('editTitle');
    if (titleInput.value.trim() === '') {
        alert('제목은 필수로 입력해야합니다.');
        titleInput.focus();
        event.preventDefault();
    }
});


document.addEventListener('click', function(event) {
    // 클릭된 요소가 menu-tree 내부에 있지만, onclick 이벤트가 있는 요소가 아닐 때만 선택 해제
    if (event.target.closest('.menu-tree') && !event.target.closest('[onclick]')) {
        document.querySelectorAll('.menu_list span').forEach(span => {
            span.classList.remove('selected');
        });
        document.querySelector('.make_new_one').style.display = 'none';
        document.querySelector('.default').style.display = 'block';
        window.selectedFolder = null; // 선택된 폴더 정보 초기화
        
        const editIcon = document.querySelector('.edit-icon');
        if (editIcon) {
            editIcon.remove();
        }
    }
});

document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('.default').style.display = 'block'; // 초기 화면 설정
});



</script>
</body>
</html>
