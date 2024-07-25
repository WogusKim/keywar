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

.menu_setting {
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


</style>
</head>
<body>
<div class="content_left">
    <div class="menu-tree">
        <ul>
            <c:forEach var="menu" items="${menus}">
                <li>
                	<div class="menu_list">
	                    <div class="icon ${menu.menuType == 'folder' ? 'folder-icon' : 'file-icon'}" data-toggle="${menu.menuType}" onclick="toggleFolder(this)"></div>
	                    <span>${menu.title}</span>
                    </div>
                    <c:if test="${not empty menu.children}">
                        <ul>
                            <c:forEach var="child1" items="${menu.children}">
                                <li>
                                	<div class="menu_list">
	                                    <div class="icon ${child1.menuType == 'folder' ? 'folder-icon' : 'file-icon'}" data-toggle="${child1.menuType}" onclick="toggleFolder(this)"></div>
	                                    <div>${child1.title}</div>
                                    </div>
                                    <c:if test="${not empty child1.children}">
                                        <ul>
                                            <c:forEach var="child2" items="${child1.children}">
                                                <li>
                                                	<div class="menu_list">
	                                                    <div class="icon ${child2.menuType == 'folder' ? 'folder-icon' : 'file-icon'}" data-toggle="${child2.menuType}" onclick="toggleFolder(this)"></div>
	                                                    <span>${child2.title}</span>
                                                    </div>
                                                    <c:if test="${not empty child2.children}">
                                                        <ul>
                                                            <c:forEach var="child3" items="${child2.children}">
                                                                <li><div class="menu_list">
	                                                                    <div class="icon ${child3.menuType == 'folder' ? 'folder-icon' : 'file-icon'}" data-toggle="${child3.menuType}" onclick="toggleFolder(this)"></div>
	                                                                    <span>${child3.title}</span>
                                                                    </div>
                                                                    <c:if test="${not empty child3.children}">
                                                                        <ul>
                                                                            <c:forEach var="child4" items="${child3.children}">
                                                                                <li>
                                                                                	<div class="menu_list">
	                                                                                    <div class="icon ${child4.menuType == 'folder' ? 'folder-icon' : 'file-icon'}" data-toggle="${child4.menuType}" onclick="toggleFolder(this)"></div>
	                                                                                    <span>${child4.title}</span>
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
                'url("${pageContext.request.contextPath}/resources/images/icons/folder_open.png")' :
                'url("${pageContext.request.contextPath}/resources/images/icons/folder.png")';
            return; // ul 요소가 없으므로 여기서 함수 종료
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

</script>
</body>
</html>  