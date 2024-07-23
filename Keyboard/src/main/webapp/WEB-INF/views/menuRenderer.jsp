<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${not empty menus}">
    <ul>
        <c:forEach var="menu" items="${menus}">
            <li>
                <div>${menu.title}</div> <!-- 메뉴 제목 출력 -->
                <c:if test="${not empty menu.children}">
                    <!-- 자식 메뉴가 있다면, 재귀적으로 이 부분을 포함시킵니다. -->
                    <jsp:include page="menuRenderer.jsp">
                        <jsp:param name="menus" value="${menu.children}" />
                    </jsp:include>
                </c:if>
            </li>
        </c:forEach>
    </ul>
</c:if>
