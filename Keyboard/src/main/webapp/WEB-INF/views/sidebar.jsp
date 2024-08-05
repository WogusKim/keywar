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
			                </c:otherwise>
			            </c:choose>
                    </div>
                    <c:if test="${not empty menu.children}">
                        <ul>
                            <c:forEach var="child1" items="${menu.children}">
                                <li>
                                	<div class="menu_list">
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
							                </c:otherwise>
							            </c:choose>
                                    </div>
                                    <c:if test="${not empty child1.children}">
                                        <ul>
                                            <c:forEach var="child2" items="${child1.children}">
                                                <li>
                                                	<div class="menu_list">
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
											                </c:otherwise>
											            </c:choose>
                                                    </div>
                                                    <c:if test="${not empty child2.children}">
                                                        <ul>
                                                            <c:forEach var="child3" items="${child2.children}">
                                                                <li><div class="menu_list">
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
															                </c:otherwise>
															            </c:choose>
                                                                    </div>
                                                                    <c:if test="${not empty child3.children}">
                                                                        <ul>
                                                                            <c:forEach var="child4" items="${child3.children}">
                                                                                <li>
                                                                                	<div class="menu_list">
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

</script>
</body>
</html>  