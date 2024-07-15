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
.menu-tree ul {
    list-style: none;
    padding: 0;
}

.menu-item > .submenu {
    display: block; /* 모든 서브메뉴를 기본적으로 표시 */
    margin-left: 20px;
}

.menu-item.closed > .submenu {
    display: none; /* closed 클래스가 있는 경우에만 숨김 */
}
</style>
</head>
<body>
	<div class="content_left">
		<div class="menu-tree">
		    <ul>
		        <li class="menu-item">Menu 1
		            <ul class="submenu">
		                <li class="menu-item">Submenu 1-1
		                    <ul class="submenu">
		                        <li>Submenu 1-1-1</li>
		                        <li>Submenu 1-1-2</li>
		                    </ul>
		                </li>
		                <li>Submenu 1-2</li>
		            </ul>
		        </li>
		        <li class="menu-item">Menu 2
		            <ul class="submenu">
		                <li>Submenu 2-1</li>
		                <li>Submenu 2-2</li>
		            </ul>
		        </li>
		        <li>Menu 3</li>
		    </ul>
		</div>
	</div>
<script>
document.querySelectorAll('.menu-item').forEach(item => {
    item.addEventListener('click', function(event) {
        this.classList.toggle('closed');
        event.stopPropagation(); // 상위 메뉴의 이벤트가 발생하지 않도록 함
    });
});
</script>
</body>
</html>  