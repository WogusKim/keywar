<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김국민의 업무노트 : ${dto.username } 노트 모아보기</title>
</head>
<body>
<link rel="icon"
	href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png" />
<link rel="apple-touch-icon"
	href="${pageContext.request.contextPath}/resources/images/logo_smallSize.png" />
<style>
table {
	width: 100%; /* 테이블 너비 */
	margin: 10px auto; /* 중앙 정렬 및 상하 여백 설정 */
	border-collapse: collapse; /* 테이블 경계선 병합 */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
	overflow: hidden; /* 내부 요소가 범위를 초과할 경우 숨김 */
}

td {
	height: 40px;
	padding: 7px 15px; /* 셀 패딩 */
	text-align: center; /* 텍스트 왼쪽 정렬 */
	border-bottom: 1px solid #ddd; /* 하단 경계선 */
}

th {
	height: 40px;
	padding: 7px 15px; /* 셀 패딩 */
	text-align: center; /* 텍스트 중앙 정렬 */
	border-bottom: 1px solid #ddd; /* 하단 경계선 */
	background-color: #f4f4f4; /* 헤더 배경색 */
	color: #333; /* 헤더 폰트 색상 */
	font-weight: bold; /* 헤더 폰트 두께 */
}

.writer_td {
	display: flex;
	align-items: center;
	justify-content: flex-start; /* 왼쪽 정렬 */
}

.title_td {
	text-align: left; /* 제목 왼쪽 정렬 */
}

tr:hover {
	background-color: #f9f9f9; /* 마우스 오버 시 배경색 변경 */
}

tr:last-child td {
	border-bottom: none; /* 마지막 행의 하단 경계선 제거 */
}

.styled-link {
	color: #070707; /* 링크 색상 */
	text-decoration: none; /* 밑줄 없음 */
}

.styled-link:hover {
	text-decoration: underline; /* 마우스 오버 시 밑줄 표시 */
}

.profile-pic {
	width: 30px; /* 이미지 너비 설정 */
	height: 30px; /* 이미지 높이 설정 */
	border-radius: 50%; /* 이미지를 원형으로 만들기 */
	object-fit: cover; /* 이미지 비율 유지하면서 요소에 맞추기 */
	border: 2px solid #f4f4f4; /* 이미지 주변에 테두리 추가 */
	margin-right: 10px;
}

#pagination {
	text-align: center; /* 페이지네이션 버튼을 가운데 정렬 */
	padding: 10px 0; /* 상하 패딩 */
	margin-top: 20px; /* 페이지네이션과 테이블 사이의 간격 */
}

#pagination button {
	color: #000000; /* 버튼 텍스트 색상 */
	border: 1px solid #dee2e6; /* 버튼 테두리 */
	padding: 5px 10px; /* 버튼 내부 패딩 */
	margin: 0 5px; /* 버튼 간 간격 */
	border-radius: 5px; /* 버튼 둥근 모서리 */
	cursor: pointer; /* 마우스 오버 시 커서 모양 */
	transition: background-color 0.3s, color 0.3s; /* 색상 변경 효과 */
}

#pagination button:hover {
	background-color: #F4F4F4; /* 호버 시 버튼 배경색 */
	color: black; /* 호버 시 버튼 텍스트 색상 */
}

#pagination button.active2 {
	background-color: #F4F4F4; /* 활성화된 버튼의 배경색 */
	color: black; /* 활성화된 버튼의 텍스트 색상 */
	text-decoration: underline; /* 버튼에 언더라인 추가 */
}

.sort-buttons {
	text-align: right; /* 버튼을 가운데 정렬 */
}

.sort-button {
	padding: 5px 10px; /* 내부 패딩 */
	margin: 0 1px; /* 버튼 사이의 간격 */
	background-color: #f4f4f4; /* 버튼 배경색 */
	border: 1px solid #ccc; /* 경계선 스타일 */
	border-radius: 5px; /* 버튼 둥근 모서리 */
	cursor: pointer; /* 마우스 커서를 손가락 모양으로 변경 */
	transition: background-color 0.3s; /* 배경색 변경 애니메이션 */
}

.sort-button:hover, .sort-button.active {
	background-color: #007BFF; /* 호버 또는 활성화 시 배경색 */
	color: white; /* 호버 또는 활성화 시 텍스트 색상 */
}
.profilebox {
    width: 130px;
    height: 130px; 
    border-radius: 70%;
    overflow: hidden;
}
.profile-image {  
    width: 100%;
    height: 100%;
    object-fit: cover;
}
.mini-icons{
		margin-left: 15px;
		}
</style>
</head>
<body>

	<%@ include file="/WEB-INF/views/header.jsp"%>

	<div class="content_outline">
		<jsp:include page="/WEB-INF/views/sidebar.jsp" />
		<div class="content_right">
		<!-- 상단에 글 보는 사람 이름이랑 이런 거 뜨는 영역 -->
		<div style="text-align: left; padding: 15px; display: flex;">
		<!-- 사진 영역 -->
		<div class="profilebox" style="background: #BDBDBD; margin-bottom: 20px; ">
			<img class="profile-image" src="${pageContext.request.contextPath}/getUserProfilePicture2?userno=${writer.profile}" alt="Profile Picture">
		</div>
		<!--  이름이랑 게시글 등을 보는 영역 -->
		<div style="margin-left: 20px;">
		<h1 style="margin-bottom: 5px;">${writer.nickname}</h1>
		<span style="color: gray; font-size: small; margin: 0px; margin-left: 5px;">${writer.username}(${writer.userno})</span>
	
		<div style ="display: flex; margin-top: 10px; margin-left: 5px;" >
		작성한 게시글 ${redord.note_count}개 
		<img class="mini-icons" src="${pageContext.request.contextPath}/resources/images/heart16.png"> 좋아요 ${redord.like_count} 
		<img class="mini-icons" src="${pageContext.request.contextPath}/resources/images/chat16.png"> 댓글 ${redord.comment_count} 
		<img class="mini-icons" src="${pageContext.request.contextPath}/resources/images/eyes.png"> 조회수 ${redord.hits_count} 
		
		</div>
		</div>
		</div>
		
		
			<div style="width: 100%; text-align: left;">
		
			</div>
			<hr>
			<div style="width: 100%; height: 65%;">
				<div class="sort-buttons">
					<button class="sort-button" onclick="sortPosts('likes');">좋아요순</button>
					<button class="sort-button" onclick="sortPosts('views');">조회수순</button>
					<button class="sort-button" onclick="sortPosts('recent');">최신순</button>
					
				</div>


				<table>
					<colgroup>
						<col style="width: 10%;">
						<col style="width: 50%;">
						<col style="width: 20%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
					</colgroup>
					<thead style="font-size: large;">
						<tr>
							<th scope="col">관리번호</th>
							<th scope="col" style="text-align: left;">제목</th>
							<th scope="col" style="text-align: left;">작성자</th>
							<th scope="col">좋아요</th>
							<th scope="col">조회수</th>
						</tr>
					</thead>
					<tbody id="tableBody"></tbody>
				</table>


			</div>
			<div style="width: 100%; height: 5%;" id="pagination"></div>

		</div>
	</div>
<script>
    var contextPath = "${pageContext.request.contextPath}";
</script>

<script>
var dataList = [
    <c:forEach var="item" items="${list}" varStatus="status">
    {
        management_number: "${item.management_number}",
        id: ${item.id},
        titleShare: "${item.titleShare}",
        nickname: "${item.nickname}",
        userno: "${item.userno}",
        like_count: ${item.like_count},
        hits_count: ${item.hits_count},
        picture: "${item.picture}"
    }${not status.last ? ',' : ''}
    </c:forEach>
];

console.log('datalist: ');
console.log(dataList);

let currentPage = 1;
const recordsPerPage = 10;



//페이지 로드 시 초기 테이블 렌더링
document.addEventListener('DOMContentLoaded', function() {
    renderTable(1);
});



function renderTable(page) {
	
	currentPage = page; // 현재 페이지 업데이트
	
    console.log(`Rendering page: ${page}`); // 현재 렌더링하는 페이지 번호를 로그로 확인
    const start = (page - 1) * recordsPerPage;
    const end = start + recordsPerPage;
    const paginatedItems = dataList.slice(start, end);
    console.log(`Items from ${start} to ${end}:`, paginatedItems); // 페이지에 표시될 아이템 범위 로그

    let tableBody = document.getElementById("tableBody");
    tableBody.innerHTML = ""; // Clear existing table rows.

    paginatedItems.forEach(item => {
        let row = `<tr>
            <td>\${item.management_number}</td>
            <td class="title_td"><a href="${pageContext.request.contextPath}/detailNote?id=\${item.id}" class="styled-link">\${item.titleShare}</a></td>
            <td>
                <div class="writer_td">
                    <img class="profile-pic" src="${pageContext.request.contextPath}/getUserProfilePicture2?userno=\${item.picture}" />
                    \${item.nickname} 
                </div>
            </td>
            <td>\${item.like_count}</td>
            <td>\${item.hits_count}</td>
        </tr>`;
        tableBody.innerHTML += row;
    });
    
    setupPagination();
}

function setupPagination() {
    const pageCount = Math.ceil(dataList.length / recordsPerPage);
    let paginationHTML = '';
    for (let i = 1; i <= pageCount; i++) {
        paginationHTML += `<button class="\${i === currentPage ? 'active2' : ''}" onclick="renderTable(\${i})">\${i}</button>`;
    }
    document.getElementById('pagination').innerHTML = paginationHTML;
}

window.onload = function() {
    renderTable(1);  // Render the first page
    setupPagination();  // Setup pagination buttons
};




function searchPosts(e) {
    e.preventDefault(); // 폼 제출 방지
    const searchText = document.getElementById('searchInput').value.toLowerCase();

    // dataList는 페이지 로딩 시 전체 데이터를 가지고 있어야 합니다.
    const filteredData = dataList.filter(item => item.titleShare.toLowerCase().includes(searchText));
    renderFilteredTable(filteredData);
}

function renderFilteredTable(data) {
    let tableBody = document.getElementById("tableBody");
    tableBody.innerHTML = ""; // 기존 테이블 내용을 비웁니다.

    data.forEach(item => {

        let row = '<tr>' +
        '<td>' + (item.management_number || '') + '</td>' +
        '<td class="title_td"><a href="' + (contextPath || '') + '/detailNote?id=' + (item.id || '') + '" class="styled-link">' + (item.titleShare || '') + '</a></td>' +
        '<td>' +
            '<div class="writer_td">' +
                '<img class="profile-pic" src="' + (contextPath || '') + '/getUserProfilePicture2?userno=' + (item.userno || '') + '" />' +
                (item.nickname || '') +
            '</div>' +
        '</td>' +
        '<td>' + (item.like_count || 0) + '</td>' +
        '<td>' + (item.hits_count || 0) + '</td>' +
    	'</tr>';

        tableBody.innerHTML += row;
    });

    // 필터링된 데이터가 없을 경우 메시지 출력
    if (data.length === 0) {
        tableBody.innerHTML = '<tr><td colspan="5">검색 결과가 없습니다.</td></tr>';
    }
}



function sortPosts(criteria) {
    if (criteria === 'hits_count') {
        dataList.sort((a, b) => b.hits_count - a.hits_count);
    } else if (criteria === 'like_count') {
        dataList.sort((a, b) => b.like_count - a.like_count);
    }
    renderTable(1); // 정렬 후 첫 페이지를 보여줍니다.
}

</script>
</body>
</html>