<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사이드바</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="//code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

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

			
			<ul id="sortable">
			    <c:forEach var="menu" items="${menus}">
			        <li class="ui-state-default" style="margin-left: ${menu.depth * 20}px;">${menu.title}</li>
			    </c:forEach>
			</ul>

		</div>

	</div>
	
<script>
$(function() {
    $("#sortable").sortable({
        placeholder: "ui-state-highlight",
        update: function(event, ui) {
            var newOrder = $(this).sortable('toArray', {attribute: 'data-id'});
            // AJAX를 사용하여 서버에 새 순서 전송
            $.post('/update-menu-order', {order: newOrder});
        }
    });
    $("#sortable").disableSelection();
});
</script>
</body>
</html>  