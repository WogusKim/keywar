<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김국민의 업무노트 : 인기 노트</title>
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
	height: 50px;
	padding: 7px 15px; /* 셀 패딩 */
	text-align: center; /* 텍스트 왼쪽 정렬 */
	border-bottom: 1px solid #ddd; /* 하단 경계선 */
}

th {
	height: 50px;
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
	width: 40px; /* 이미지 너비 설정 */
	height: 40px; /* 이미지 높이 설정 */
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
	width: 100%;
	overflow: auto; /* 컨텐츠가 넘치면 자동으로 처리 */
}

.sort-buttons form {
	float: left; /* 검색 폼을 왼쪽으로 정렬 */
	margin-right: 10px; /* 오른쪽 버튼과의 간격 */
	    /* 아래 속성 추가 */
    white-space: nowrap;
    display: inline-block;
}

.sort-buttons form input[type="text"] {
    /* 검색창의 너비 조정 */
    width: 200px; /* 또는 적절한 값 */
    display: inline-block;
    vertical-align: middle;
}

.sort-buttons form button[type="submit"] {
    display: inline-block;
    vertical-align: middle;
}

.sort-buttons button.sort-button {
    float: right;
    margin-left: 5px;
}

/* 
.sort-buttons button {
	float: right; 
	margin-left: 5px; 
}
 */
/* 필요하다면 추가적인 스타일링을 적용 */
input[type="text"] {
	padding: 5px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

button[type="submit"] {
	padding: 5px 10px;
	background-color: #4CAF50;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

button[type="submit"]:hover {
	background-color: #45a049;
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

</style>
</head>
<body>

	<%@ include file="/WEB-INF/views/header.jsp"%>

	<div class="content_outline">
		<jsp:include page="/WEB-INF/views/sidebar.jsp" />
		<div class="content_right">
			<div style="width: 50%; text-align: left;">
				<b style="font-size: 25px;">Cool Tip 게시판</b>
				<select name="categoryCool" id="categoryCool" style="margin-left: 10px;" onchange="filterByCategory()">
				    <option value="" ${selectedCategory == null || selectedCategory == '' ? 'selected' : ''}>전체</option>
				    <option value="수신" ${selectedCategory == '수신' ? 'selected' : ''}>수신</option>
				    <option value="개인여신" ${selectedCategory == '개인여신' ? 'selected' : ''}>개인여신</option>
				    <option value="기업여신" ${selectedCategory == '기업여신' ? 'selected' : ''}>기업여신</option>
				    <option value="외환" ${selectedCategory == '외환' ? 'selected' : ''}>외환</option>
				    <option value="신용카드" ${selectedCategory == '신용카드' ? 'selected' : ''}>신용카드</option>
				    <option value="퇴직연금" ${selectedCategory == '퇴직연금' ? 'selected' : ''}>퇴직연금</option>
				    <option value="WM" ${selectedCategory == 'WM' ? 'selected' : ''}>WM</option>
				    <option value="기타" ${selectedCategory == '기타' ? 'selected' : ''}>기타</option>
				</select>
			</div>
			<hr>
			<div style="width: 100%; height: 85%;">
				<div class="sort-buttons">
					<form onsubmit="searchPostsCool(event)">
						<input type="text" id="searchInputCool" placeholder="제목 검색...">
						<button type="submit">검색</button>
					</form>
					
					<button class="sort-button" onclick="sortPosts('hits_count');">조회수 순</button>
					<button class="sort-button" onclick="sortPosts('like_count');">좋아요 순</button>
					<!-- css의 .sort-buttons button {float: right;} 때문에 버튼이 오른쪽부터 정렬됨 -->

				</div>


				<table>
					<colgroup>
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 45%;">
						<col style="width: 15%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
					</colgroup>
					<thead style="font-size: large;">
						<tr>
							<th scope="col">관리번호</th>
							<th scope="col">카테고리</th>
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
        category: "${item.category}",
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

var filteredDataList = null; // 새로운 전역 변수
var originalDataList = [...dataList]; // 원본 데이터 복사본 저장

function likeUp(){
	
	
	fetch('${pageContext.request.contextPath}/likeUp', {   
      	method: 'POST',
    	headers: {
        	'Content-Type': 'application/json'
      	},
    	body: JSON.stringify({
	      	targetid : id,
      	})
  	})
  	.then(response => response.json())
  	.then(data => {
      	console.log('Success:', data);
      	if(data.status == "success"){
      		location.reload();
      	}else if(data.status == "duplicate"){
      		alert("이미 좋아하는 게시물입니다.");
      	}else{
      		
      	}
  	})
  	.catch((error) => {
      	console.error('Error:', error);
  	});
}

function filterByCategory() {
    var category = document.getElementById("categoryCool").value;
    window.location.href = "hotNote?category=" + encodeURIComponent(category);
}

let currentPage = 1;
const recordsPerPage = 10;

//페이지 로드 시 초기 테이블 렌더링
document.addEventListener('DOMContentLoaded', function() {
    renderTable(1);
});
 
function renderTable(page) {
	
	currentPage = page; // 현재 페이지 업데이트
    const dataToUse = filteredDataList || dataList; // 필터링된 데이터가 있으면 사용, 없으면 전체 데이터 사용

	
    console.log(`Rendering page: ${page}`); // 현재 렌더링하는 페이지 번호를 로그로 확인
    const start = (page - 1) * recordsPerPage;
    const end = start + recordsPerPage;
//    const paginatedItems = dataList.slice(start, end);
    const paginatedItems = dataToUse.slice(start, end);

    console.log(`Items from ${start} to ${end}:`, paginatedItems); // 페이지에 표시될 아이템 범위 로그

    let tableBody = document.getElementById("tableBody");
    tableBody.innerHTML = ""; // Clear existing table rows.

    paginatedItems.forEach(item => {
        let row = `<tr>
            <td>\${item.management_number}</td>
            <td>\${item.category}</td>
            <td class="title_td"><a href="${contextPath}/detailNote?id=\${item.id}" class="styled-link">\${item.titleShare}</a></td>
            <td>
                <div class="writer_td" onclick="goToProfile(\${item.userno})">
                    <img class="profile-pic" src="${contextPath}/getUserProfilePicture2?userno=\${item.picture}" />
                    \${item.nickname} 
                </div>
            </td>
            <td>\${item.like_count}</td>
            <td>\${item.hits_count}</td>
        </tr>`;
        tableBody.innerHTML += row;
    });
    
    //setupPagination();
    setupPagination(dataToUse.length);

}

function setupPagination(totalItems) {
    const pageCount = Math.ceil(totalItems / recordsPerPage);
    let paginationHTML = '';
    for (let i = 1; i <= pageCount; i++) {
        paginationHTML += `<button class="\${i === currentPage ? 'active2' : ''}" onclick="renderTable(\${i})">\${i}</button>`;
    }
    document.getElementById('pagination').innerHTML = paginationHTML;
}

window.onload = function() {
    originalDataList = [...dataList]; // 원본 데이터 복사본 저장

    renderTable(1);  // Render the first page
    //setupPagination();  // Setup pagination buttons
};

/* function searchPosts(e) {
    e.preventDefault(); // 폼 제출 방지
    const searchText = document.getElementById('searchInput').value.toLowerCase();

    // dataList는 페이지 로딩 시 전체 데이터를 가지고 있어야 합니다.
    const filteredData = dataList.filter(item => item.titleShare.toLowerCase().includes(searchText));
    
    currentPage = 1; // 검색 후 첫 페이지로 리셋
    renderFilteredTable(filteredData);
} */

function searchPostsCool(e) {
    e.preventDefault(); // 폼 제출 방지
    console.log('form submitted');
    const searchInputCool = document.getElementById('searchInputCool');
    console.log(searchInputCool); // searchInput 요소 확인
    const searchTextCool = document.getElementById('searchInputCool').value.toLowerCase();
	console.log(searchTextCool);
    // 전역 변수로 필터링된 데이터를 저장
    //window.filteredDataList = dataList.filter(item => item.titleShare.toLowerCase().includes(searchTextCool));
    filteredDataList = originalDataList.filter(item => item.titleShare.toLowerCase().includes(searchTextCool));

    console.log(window.filteredDataList);
    currentPage = 1; // 검색 후 첫 페이지로 리셋
    renderTable(1); // 기존의 renderTable 함수를 사용
}

function renderFilteredTable(data) {
    let tableBody = document.getElementById("tableBody");
    tableBody.innerHTML = ""; // 기존 테이블 내용을 비웁니다.

    data.forEach(item => {

        let row = '<tr>' +
        '<td>' + (item.management_number || '') + '</td>' +
        '<td>' + (item.category || '') + '</td>' +
        '<td class="title_td"><a href="' + (contextPath || '') + '/detailNote?id=' + (item.id || '') + '" class="styled-link">' + (item.titleShare || '') + '</a></td>' +
        '<td>' +
            '<div class="writer_td" onclick="goToProfile(\${item.userno})">' +
                '<img class="profile-pic" src="' + (contextPath || '') + '/getUserProfilePicture2?userno=' + (item.userno || '') + '" />' +
             '<a href="${pageContext.request.contextPath}/profile?userno=\${item.userno}" class="styled-link">'+ (item.nickname || '') +'</a>'+
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

/* function sortPosts(criteria) {
    if (criteria === 'hits_count') {
        dataList.sort((a, b) => b.hits_count - a.hits_count);
    } else if (criteria === 'like_count') {
        dataList.sort((a, b) => b.like_count - a.like_count);
    }
    renderTable(1); // 정렬 후 첫 페이지를 보여줍니다.
} */

function sortPosts(criteria) {
    const dataToSort = window.filteredDataList || dataList;
    if (criteria === 'hits_count') {
        dataToSort.sort((a, b) => b.hits_count - a.hits_count);
    } else if (criteria === 'like_count') {
        dataToSort.sort((a, b) => b.like_count - a.like_count);
    }
    
//    window.filteredDataList = dataToSort;
    filteredDataList = dataToSort;

    renderTable(1); // 정렬 후 첫 페이지를 보여줍니다.
}

function goToProfile(userno){
	
	
}
</script>
</body>
</html>