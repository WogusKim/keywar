<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사이드바</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
.content_left{
	position: relative; /* 부모 요소를 상대적 위치 컨테이너로 설정 */
	display: flex;
    flex-direction: column; /* 자식 요소들을 세로로 나열 */
    justify-content: space-between; /* 첫 번째 요소는 위에, 마지막 요소는 아래에 위치 */
    border-radius: 10px;
    background-color: white;
    padding: 20px 5px;
    width: 17%;
    height: 100%;
    margin-right: 15px;
    box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);

}

.menu_list {
	display: flex;
	align-items: center;
	vertical-align: center;
	position: relative; /* 상대 위치 설정 */
}

.menu-tree ul {
    list-style-type: none;
    padding-left: 0;
    margin: 6px;
}

.menu-tree li {
    margin-left: 6px;
    margin-bottom: 5px;
    padding-left: 0;
}
.icon {
    display: inline-block;
    width: 16px;
    height: 16px;
    background-size: contain;
    background-repeat: no-repeat;
    margin-right: 6px;
    margin-top: 2px;
    vertical-align: middle; /* 이 설정은 flex를 사용할 때는 불필요할 수 있습니다 */
}

.folder-icon {
    background-image: url('${pageContext.request.contextPath}/resources/images/icons/folder_open2.png');
}

.file-icon {
    background-image: url('${pageContext.request.contextPath}/resources/images/icons/page2.png');
}

.menu-icon {
	background-image: url('${pageContext.request.contextPath}/resources/images/icons/menu_setting.png');
}

.fold-icon {
	background-image: url('${pageContext.request.contextPath}/resources/images/icons/menu_fold.png');
}
.unfold-icon {
	background-image: url('${pageContext.request.contextPath}/resources/images/icons/menu_unfold.png');
}

.menu_setting {
    position: absolute; /* 절대 위치 사용 */
    right: 10px; /* 우측으로부터 10px 떨어진 위치 */
    bottom: 10px; /* 하단으로부터 10px 떨어진 위치 */
    padding: 10px; /* 패딩 */
    display: flex; /* Flexbox 사용 */
    align-items: center; /* 세로 중앙 정렬 */
}

.menu_onoff {
    position: absolute;
    right: 5px; /* 우측에서 10px 떨어진 위치에 배치 */
    top: 50%; /* 상단에서 50% 위치에 배치 */
    transform: translateY(-50%); /* Y축 기준 50%만큼 이동, 자신의 높이의 절반만큼 올림 */
}

.icon-fold {
    display: inline-block;
    width: 25px;
    height: 25px;
    background-size: contain;
    background-repeat: no-repeat;
    margin-right: 6px;
}


.hidden {
    visibility: hidden; /* 요소 숨김 */
}

.icon-setting {
    display: inline-block;
    width: 16px;
    height: 16px;
    background-size: contain;
    background-repeat: no-repeat;
    margin-right: 6px;
}

.folder-hover:hover {
    background-color: #f0f0f0; /* 마우스를 올렸을 때 음영 효과 */
    position: relative; /* 상대 위치 */
}

.folder-hover .add-icon {
	width: 15px;
	height: auto;
    display: none; /* 기본적으로 숨김 */
    position: absolute; /* 절대 위치 */
    right: 10px; /* 오른쪽에 배치 */
    top: 50%; /* 세로 중앙 정렬 */
    transform: translateY(-50%); /* 세로 중앙 정렬 */
}

.folder-hover:hover .add-icon {
    display: inline-block; /* 마우스를 올렸을 때 보임 */
}

.selected {
    background-color: #007BFF; /* 선택된 아이템의 배경색 */
    color: white; /* 선택된 아이템의 글자색 */
    border-radius: 5px; /* 선택된 아이템의 테두리 둥글게 */
    padding: 5px; /* 선택된 아이템의 안쪽 여백 */
}



/* 모달팝업관련 */

.modal {
    display: none; /* 기본적으로 숨겨져 있음 */
    position: fixed; /* 고정 위치 */
    z-index: 1; /* 콘텐츠 위에 표시 */
    left: 0;
    top: 0;
    width: 100%; /* 전체 너비 */
    height: 100%; /* 전체 높이 */
    overflow: auto; /* 필요할 경우 스크롤 */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* 블랙 w/ opacity */
}

/* 모달 콘텐츠 */
.modal-content2 {
	border-radius: 10px;
    background-color: #fefefe;
    margin: 15% auto; /* 15% 상단에서부터 자동 가운데 정렬 */
    padding: 20px;
    border: 1px solid #888;
    width: 500px; /* 대부분의 화면에서 적절한 폭 */
    heigth: 400px;
}

.input_outer {
	padding:10px;
}

.edit_field {
	margin: 5px;
	padding:10px;
	display: flex;
	
}

.label-fixed-width {
    display: inline-block;
    width: 120px; /* 레이블 너비 설정 */
    margin-right: 10px; /* 인풋과의 간격 조절 */
    margin_left: 20px;
}

.edit_input {
	display: inline-block;
	width: 250px;
	height: 25px;
}

.submit_buttonArea {
	margin: 20px;
	text-align: center; /* 버튼을 중앙으로 정렬 */
}

.edit_submit {
	width : 200px;
	padding: 8px 16px;
    background-color: #007BFF;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.label_modal {
	width: 60px;
}

hr.modal_hr {
    border: 0;
    height: 1px;
    background-color: #f0f0f0; /* 색상 변경 */
    margin-top: 10px; /* 상단 여백 추가 */
}

/* 닫기 버튼 */
.close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}

.form-group {
    margin-bottom: 15px;
}

.form-group label {
    margin-right: 10px;
}

input[type="text"], input[type="radio"] {
    margin-right: 5px;
}
/* 모달팝업관련 */
</style>
</head>
<body>
<div class="content_left">
    <div class="menu-tree">
        <ul>
            <c:forEach var="menu" items="${menus}">
                <li>
                	<div class="menu_list folder-hover">
	                    <div class="icon ${menu.menuType == 'folder' ? 'folder-icon' : 'file-icon'}" data-toggle="${menu.menuType}" onclick="toggleFolder(this)"></div>
			            <!-- menuType에 따라 다른 처리 -->
			            <c:choose>
			                <c:when test="${menu.menuType == 'item'}">
			                    <!-- menuType이 item일 경우, 링크 포함 -->
			                    <a href="${pageContext.request.contextPath}/wikiDetail?id=${menu.id}">
			                        <span>${menu.title}</span>
			                    </a>
			                </c:when>
			                <c:otherwise>
			                    <!-- 기본적으로 title만 표시 -->
			                    <span>${menu.title}</span>
			                    <img src="${pageContext.request.contextPath}/resources/images/icons/plus_item.png" class="add-icon" alt="Add Item" onclick="addItem(${menu.id}, ${menu.depth})">
			                </c:otherwise>
			            </c:choose>
                    </div>
                    <c:if test="${not empty menu.children}">
                        <ul>
                            <c:forEach var="child1" items="${menu.children}">
                                <li>
                                	<div class="menu_list folder-hover">
	                                    <div class="icon ${child1.menuType == 'folder' ? 'folder-icon' : 'file-icon'}" data-toggle="${child1.menuType}" onclick="toggleFolder(this)"></div>
							            <!-- menuType에 따라 다른 처리 -->
							            <c:choose>
							                <c:when test="${child1.menuType == 'item'}">
							                    <!-- menuType이 item일 경우, 링크 포함 -->
							                    <a href="${pageContext.request.contextPath}/wikiDetail?id=${child1.id}">
							                        <span>${child1.title}</span>
							                    </a>
							                </c:when>
							                <c:otherwise>
							                    <!-- 기본적으로 title만 표시 -->
							                    <span>${child1.title}</span>
							                    <img src="${pageContext.request.contextPath}/resources/images/icons/plus_item.png" class="add-icon" alt="Add Item" onclick="addItem(${child1.id}, ${child1.depth})">
							                </c:otherwise>
							            </c:choose>
                                    </div>
                                    <c:if test="${not empty child1.children}">
                                        <ul>
                                            <c:forEach var="child2" items="${child1.children}">
                                                <li>
                                                	<div class="menu_list folder-hover">
	                                                    <div class="icon ${child2.menuType == 'folder' ? 'folder-icon' : 'file-icon'}" data-toggle="${child2.menuType}" onclick="toggleFolder(this)"></div>
											            <!-- menuType에 따라 다른 처리 -->
											            <c:choose>
											                <c:when test="${child2.menuType == 'item'}">
											                    <!-- menuType이 item일 경우, 링크 포함 -->
											                    <a href="${pageContext.request.contextPath}/wikiDetail?id=${child2.id}">
											                        <span>${child2.title}</span>
											                    </a>
											                </c:when>
											                <c:otherwise>
											                    <!-- 기본적으로 title만 표시 -->
											                    <span>${child2.title}</span>
											                    <img src="${pageContext.request.contextPath}/resources/images/icons/plus_item.png" class="add-icon" alt="Add Item" onclick="addItem(${child2.id}, ${child2.depth})">
											                </c:otherwise>
											            </c:choose>
                                                    </div>
                                                    <c:if test="${not empty child2.children}">
                                                        <ul>
                                                            <c:forEach var="child3" items="${child2.children}">
                                                                <li><div class="menu_list folder-hover">
	                                                                    <div class="icon ${child3.menuType == 'folder' ? 'folder-icon' : 'file-icon'}" data-toggle="${child3.menuType}" onclick="toggleFolder(this)"></div>
															            <!-- menuType에 따라 다른 처리 -->
															            <c:choose>
															                <c:when test="${child3.menuType == 'item'}">
															                    <!-- menuType이 item일 경우, 링크 포함 -->
															                    <a href="${pageContext.request.contextPath}/wikiDetail?id=${child3.id}">
															                        <span>${child3.title}</span>
															                    </a>
															                </c:when>
															                <c:otherwise>
															                    <!-- 기본적으로 title만 표시 -->
															                    <span>${child3.title}</span>
															                    <img src="${pageContext.request.contextPath}/resources/images/icons/plus_item.png" class="add-icon" alt="Add Item" onclick="addItem(${child3.id}, ${child3.depth})">
															                </c:otherwise>
															            </c:choose>
                                                                    </div>
                                                                    <c:if test="${not empty child3.children}">
                                                                        <ul>
                                                                            <c:forEach var="child4" items="${child3.children}">
                                                                                <li>
                                                                                	<div class="menu_list folder-hover">
	                                                                                    <div class="icon ${child4.menuType == 'folder' ? 'folder-icon' : 'file-icon'}" data-toggle="${child4.menuType}" onclick="toggleFolder(this)"></div>
																			            <!-- menuType에 따라 다른 처리 -->
																			            <c:choose>
																			                <c:when test="${child4.menuType == 'item'}">
																			                    <!-- menuType이 item일 경우, 링크 포함 -->
																			                    <a href="${pageContext.request.contextPath}/wikiDetail?id=${child4.id}">
																			                        <span>${child4.title}</span>
																			                    </a>
																			                </c:when>
																			                <c:otherwise>
																			                    <!-- 기본적으로 title만 표시 -->
																			                    <span>${child4.title}</span>
																			                    <img src="${pageContext.request.contextPath}/resources/images/icons/plus_item.png" class="add-icon" alt="Add Item" onclick="addItem(${child4.id}, ${child4.depth})">
																			                </c:otherwise>
																			            </c:choose>
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
	<div class="menu_setting">
	    <div class="icon-setting menu-icon"></div>
	    <a href="${pageContext.request.contextPath}/menuSetting">메뉴 설정</a>
	</div>
	<div class="menu_onoff">
		<div class="icon-fold fold-icon"></div>
		<div class="icon-fold unfold-icon" style="display:none"></div>
	</div>
</div>


<!-- 페이지 추가 모달 팝업 -->
<div id="addModal" class="modal">
    <div class="modal-content2">
        <span class="close">&times;</span>
        <h3>업무노트 추가</h3>
        
        <form id="addForm" action="${pageContext.request.contextPath}/fastAddItem" method="post">
        	<hr class="modal_hr">
        	<div class="input_outer">
        	
	            <input type="hidden" id="selectedId" name="id">
		        <input type="hidden" id="selectedType" name="type">
		        <input type="hidden" id="selectedDepth" name="depth">
		        
		        
		        <div class="edit_field">
		        	<label class="label-fixed-width">공개 여부:</label>
		        	<input type="radio" name="public" value="yes">
                    <label for="isOpenYes" class="label_modal">공개</label>
                    <input type="radio" name="public" value="no">
                    <label for="isOpenNo" class="label_modal">비공개</label>
		        </div>
		        
	            <div class="edit_field">
	                <label class="label-fixed-width">노트(폴더)제목:</label>
	                <input type="text" id="addTitle" name="title" class="edit_input">
	            </div>

	            <div class="edit_field">
	                <label class="label-fixed-width">공유용 제목:</label>
	                <input type="text" name="sharedTitle" class="edit_input">
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
    var parentLi = element.closest('li'); // 가장 가까운 li 요소를 찾음
    var nextUl = parentLi.querySelector('ul'); // 해당 li 내부의 첫 번째 ul을 찾음
    var menuType = element.getAttribute('data-toggle'); // 메뉴 타입을 읽어옴

    // 폴더 타입일 때만 토글 동작 수행
    if (menuType === 'folder') {
        // nextUl이 존재하지 않는 경우, 폴더 아이콘만 토글하고 함수 종료
        if (!nextUl) {
            element.classList.toggle('folder-open');
            element.classList.toggle('folder-closed');
            element.style.backgroundImage = element.classList.contains('folder-open') ?
                'url("${pageContext.request.contextPath}/resources/images/icons/folder_open2.png")' :
                'url("${pageContext.request.contextPath}/resources/images/icons/folder2.png")';
            return; // ul 요소가 없으므로 여기서 함수 종료
        }

        // ul 요소가 존재하는 경우의 기존 로직 실행
        if ($(nextUl).is(':visible')) {
            $(nextUl).slideUp(300); // jQuery slideUp 함수로 부드럽게 접음
            element.style.backgroundImage = 'url("${pageContext.request.contextPath}/resources/images/icons/folder2.png")';
        } else {
            $(nextUl).slideDown(300); // jQuery slideDown 함수로 부드럽게 펼침
            element.style.backgroundImage = 'url("${pageContext.request.contextPath}/resources/images/icons/folder_open2.png")';
        }
    }
}


$(document).ready(function() {
	// 모든 ul 요소의 기본 display를 block으로 설정
    $('.menu-tree ul').css('display', 'block');

    // 페이지 로드 시 저장된 사이드바 상태 확인
    var isCollapsed = localStorage.getItem('isCollapsed') === 'true';

    if (isCollapsed) {
        // 사이드바를 접은 상태로 설정
        $('.menu-tree, .menu_setting').hide();
        $('.content_left').css('width', '50px');
        $('.fold-icon').hide();
        $('.unfold-icon').show();
    } else {
        // 사이드바를 펼친 상태로 설정
        $('.menu-tree, .menu_setting').show();
        $('.content_left').css('width', '17%');
        $('.unfold-icon').hide();
        $('.fold-icon').show();
    }

    // 접기 버튼 클릭 이벤트
    $('.menu_onoff .fold-icon').click(function() {
        $('.menu-tree, .menu_setting').slideUp(300);
        $('.content_left').animate({ width: '50px' }, 300);
        $('.fold-icon').hide();
        $('.unfold-icon').show();
        localStorage.setItem('isCollapsed', 'true'); // 상태 저장
    });

    // 펼치기 버튼 클릭 이벤트
    $('.menu_onoff .unfold-icon').click(function() {
        $('.menu-tree, .menu_setting').slideDown(300);
        $('.content_left').animate({ width: '17%' }, 300);
        $('.unfold-icon').hide();
        $('.fold-icon').show();
        localStorage.setItem('isCollapsed', 'false'); // 상태 저장
    });

});

// 아이템 추가 함수
function addItem(folderId, depth) {
    
    //depth가 4인 경우 거절해야함.
    if (depth >= 4) {
    	alert('최대 허용 depth 를 초과하였습니다.');
    } else {
        // 모달을 띄우기 전에 폴더 ID와 depth 값을 설정합니다.
        $('#selectedId').val(folderId);
        $('#selectedDepth').val(depth);
        $('#selectedType').val('item'); // 기본 타입을 설정합니다.
        
        // 모달을 띄웁니다.
        $('#addModal').show();
    }
}

// 모달을 닫는 함수
$('.close').click(function() {
    $('#addModal').hide();
});

$(window).click(function(event) {
    if (event.target == $('#addModal')[0]) {
        $('#addModal').hide();
    }
});

</script>
</body>
</html>
