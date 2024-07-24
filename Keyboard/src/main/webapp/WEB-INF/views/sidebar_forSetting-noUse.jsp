<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사이드바</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<style>
.menu_list {
	display: flex;
	align-item: center;
	vertical-align: center;
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

.menu_back {
    position: absolute; /* 절대 위치 사용 */
    right: 10px; /* 우측으로부터 10px 떨어진 위치 */
    top: 10px; /* 하단으로부터 10px 떨어진 위치 */
    padding: 10px; /* 패딩 */
    display: flex; /* Flexbox 사용 */
    align-items: center; /* 세로 중앙 정렬 */
    
}

.menu_plus {
    position: absolute; /* 절대 위치 사용 */
    right: 70px; /* 우측으로부터 10px 떨어진 위치 */
    bottom: 10px; /* 하단으로부터 10px 떨어진 위치 */
    padding: 10px; /* 패딩 */
    display: flex; /* Flexbox 사용 */
    align-items: center; /* 세로 중앙 정렬 */
    
}

.menu_minus {
    position: absolute; /* 절대 위치 사용 */
    right: 10px; /* 우측으로부터 10px 떨어진 위치 */
    bottom: 10px; /* 하단으로부터 10px 떨어진 위치 */
    padding: 10px; /* 패딩 */
    display: flex; /* Flexbox 사용 */
    align-items: center; /* 세로 중앙 정렬 */
    
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

.selected {
    font-weight: bold;
    color: #0000FF; /* 블루 컬러로 강조 */
}


</style>
</head>
<body>
<div class="menuSetting_l">
    <div class="menu-tree">
        <ul>
            <c:forEach var="menu" items="${menus}">
                <li>
                	<div class="menu_list">
	                    <div class="icon ${menu.menuType == 'folder' ? 'folder-icon' : 'file-icon'}" data-toggle="folder" onclick="toggleFolder(this)"></div>
	                    <span onclick="selectFolder(this, ${menu.id})">${menu.title}</span>
                    </div>
                    <c:if test="${not empty menu.children}">
                        <ul>
                            <c:forEach var="child1" items="${menu.children}">
                                <li>
                                	<div class="menu_list">
                               			<!-- 테스트중 -->
	                                    <div class="icon ${child1.menuType == 'folder' ? 'folder-icon' : 'file-icon'}" data-toggle="folder" onclick="toggleFolder(this)"></div>
	                                    <span onclick="selectFolder(this, ${child1.id})">${child1.title}</span>
                                    </div>
                                    <c:if test="${not empty child1.children}">
                                        <ul>
                                            <c:forEach var="child2" items="${child1.children}">
                                                <li>
                                                	<div class="menu_list">
	                                                    <div class="icon ${child2.menuType == 'folder' ? 'folder-icon' : 'file-icon'}" data-toggle="folder" onclick="toggleFolder(this)"></div>
	                                                    <span onclick="selectFolder(this, ${child2.id})">${child2.title}</span>
                                                    </div>
                                                    <c:if test="${not empty child2.children}">
                                                        <ul>
                                                            <c:forEach var="child3" items="${child2.children}">
                                                                <li><div class="menu_list">
	                                                                    <div class="icon ${child3.menuType == 'folder' ? 'folder-icon' : 'file-icon'}" data-toggle="folder" onclick="toggleFolder(this)"></div>
	                                                                    <span onclick="selectFolder(this, ${child3.id})">${child3.title}</span>
                                                                    </div>
                                                                    <c:if test="${not empty child3.children}">
                                                                        <ul>
                                                                            <c:forEach var="child4" items="${child3.children}">
                                                                                <li>
                                                                                	<div class="menu_list">
	                                                                                    <div class="icon ${child4.menuType == 'folder' ? 'folder-icon' : 'file-icon'}" data-toggle="folder" onclick="toggleFolder(this)"></div>
	                                                                                    <span onclick="selectFolder(this, ${child4.id})">${child4.title}</span>
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
	    <a href="#" onclick="#">추가</a>
	</div>
	<div class="menu_minus">
	    <div class="icon-setting minus-icon"></div>
	    <a href="#" onclick="#">삭제</a>
	</div>
</div>
<script>
function toggleFolder(element) {
    // 가장 가까운 상위 li 요소를 찾아서 그 내부에서 첫 번째 ul을 선택
    var parentLi = element.closest('li'); // 가장 가까운 li 요소를 찾음
    var nextUl = parentLi.querySelector('ul'); // 해당 li 내부의 첫 번째 ul을 찾음

    if (nextUl.style.display === 'none' || !nextUl.style.display) {
        nextUl.style.display = 'block';
        element.style.backgroundImage = 'url("${pageContext.request.contextPath}/resources/images/icons/folder_open.png")';
    } else {
        nextUl.style.display = 'none';
        element.style.backgroundImage = 'url("${pageContext.request.contextPath}/resources/images/icons/folder.png")';
    }
}

function selectFolder(element, menuId) {
    // 모든 타이틀에서 'selected' 클래스 제거
    document.querySelectorAll('.menu_list span').forEach(span => {
        span.classList.remove('selected');
    });

    // 클릭된 요소에 'selected' 클래스 추가
    element.classList.add('selected');

    // 선택된 폴더 ID를 전역 변수로 저장
    window.selectedFolderId = menuId;
}

</script>
</body>
</html>  