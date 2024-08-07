<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김국민의 업무노트 : 인기 노트 </title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png" />
<link rel="apple-touch-icon" href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png"  />
<style>
table {
    width: 80%; /* 테이블 너비 */
    margin: 20px auto; /* 중앙 정렬 및 상하 여백 설정 */
    border-collapse: collapse; /* 테이블 경계선 병합 */
    background-color: #fff; /* 배경색 */
    box-shadow: 0 4px 8px rgba(0,0,0,0.1); /* 그림자 효과 */
    border-radius: 8px; /* 테이블 둥근 모서리 */
    overflow: hidden; /* 내부 요소가 범위를 초과할 경우 숨김 */
}

th, td {
    padding: 7px 15px; /* 셀 패딩 */
    text-align: center; /* 텍스트 중앙 정렬 */
    border-bottom: 1px solid #ddd; /* 하단 경계선 */
}

th {
    background-color: #f4f4f4; /* 헤더 배경색 */
    color: #333; /* 헤더 폰트 색상 */
    font-weight: bold; /* 헤더 폰트 두께 */
}


.writer_td {
	display: flex;
	align-items: center;
    justify-content: center;
}

tr:hover {
    background-color: #f9f9f9; /* 마우스 오버 시 배경색 변경 */
}

tr:last-child td {
    border-bottom: none; /* 마지막 행의 하단 경계선 제거 */
}

.styled-link {
    color: #007BFF; /* 링크 색상 */
    text-decoration: none; /* 밑줄 없음 */
}

.styled-link:hover {
    text-decoration: underline; /* 마우스 오버 시 밑줄 표시 */
}

.profile-pic {
    width: 40px; /* 이미지 너비 설정 */
    height: 40px; /* 이미지 높이 설정 */
    border-radius: 50%; /* 이미지를 원형으로 만들기 */
    object-fit: cover; /* 이미지 비율 유지하면서 요소에 맞추기 */
    border: 2px solid #f4f4f4; /* 이미지 주변에 테두리 추가 */
    margin-right: 10px; 
}


</style>
</head>
<body>

<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="content_outline">
	<jsp:include page="/WEB-INF/views/sidebar.jsp" />
	<div class="content_right">
		<div style="width: 100%; height: 10%; text-align: center;"><b style="font-size: 35px;  ">⭐ BEST 게시물 모아보기 ⭐</b></div>
		<div style=" width: 100%; height: 80%; overflow-y: auto; text-align: center;  ">
		<table style="text-align: center; width: 80%; margin: auto;">
			<colgroup>
				<col style="width: 10%;">
			    <col style="width: 50%;">
			    <col style="width: 20%;">
			    <col style="width: 10%;">
			    <col style="width: 10%;"> 
			</colgroup>
		    <thead style="font-size: large;">
		        <tr>
		        	<th scope="col" >관리번호</th>
		            <th scope="col" >제목</th>
		            <th scope="col" >작성자</th>
		            <th scope="col" >좋아요</th>
		            <th scope="col" >조회수</th>
		        </tr>				            
		    </thead>
					     
			<c:forEach var="list" items="${list}">
				<tr>
					<td>${list.management_number}</td>
					<td>
			        	<a href="${pageContext.request.contextPath}/detailNote?id=${list.id}" class="styled-link"><span>${list.titleShare } </span></a><br>
					</td>
					<td>
					<div class="writer_td">
						<span><img class="profile-pic" src="${pageContext.request.contextPath}/getUserProfilePicture2?userno=${list.userno}"></span>
						<span class="writer_nickname">${list.nickname}<%-- (${list.username}) --%></span>
					</div>

					</td>
					<td>${list.like_count}</td>
					<td>${list.hits_count}</td>
				</tr>
	        </c:forEach>
		
		</table>
		
		
		</div>
		<div style="background-color: pink; width: 100%; height: 10%;">페이지네이션 영역</div>
	</div>
</div>
</body>
</html>