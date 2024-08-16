<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>일정 관리</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.2/main.min.css' rel='stylesheet' />
<script	src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.2/main.min.js'></script>
<script	src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js'></script>
<script	src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/locale/ko.min.js'></script>
<link rel="stylesheet"	href="${pageContext.request.contextPath}/resources/css/calendar.css">
<link	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">

<style>
.btn-mint {
	background-color: #C6EFCE;
	border-color: #C6EFCE;
	color: #006100;
}

.btn-mint:hover {
	background-color: #A8CBBA;
	border-color: #A8CBBA;
	color: black;
}

.btn-pastel-pink {
	background-color: #FFC7CE;
	border-color: #FFC7CE;
	color: #9C0006;
}

.btn-pastel-pink:hover {
	background-color: #FFA0AB;
	border-color: #FFA0AB;
	color: #9C0006;
}
/* todolist 스타일 */
.todo-count {
	position: absolute;
	top: 5px;
	left: 5px;
	width: 20px;
	height: 20px;
	background-color: #007bff;
	color: white;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 12px;
	font-weight: bold;
	z-index: 10; /* 다른 요소들보다 위에 표시되도록 함 */
}

.fc-daygrid-day-top {
	position: relative;
}

.modal {
	z-index: 9999 !important;
}

.fc-shareGroup-button {
	background:
		url("${pageContext.request.contextPath}/resources/images/icons/calendar_group.png")
		no-repeat center center !important;
	background-size: contain !important;
	width: 38.78px !important; /* 이미지 크기에 맞게 너비 조정 */
	height: 38.78px !important; /* 이미지 크기에 맞게 높이 조정 */
	border: none !important; /* 버튼의 테두리를 없앱니다 */
	box-shadow: none !important; /* 버튼의 그림자를 없앱니다 */
	background-color: transparent !important; /* 배경색을 투명하게 만듭니다 */
	padding: 0 !important; /* 여백 제거 */
	margin: 0 !important; /* 외부 여백 제거 */
	cursor: pointer !important; /* 커서를 포인터로 변경 */
}

.fc-todoList-button {
	position: relative;
	background:
		url("${pageContext.request.contextPath}/resources/images/icons/calendar_todo.png")
		no-repeat center center !important;
	background-size: contain !important;
	width: 60px !important; /* 너비 고정 */
	height: 38.78px !important; /* 높이 고정 */
	border: none !important;
	box-shadow: none !important;
	background-color: transparent !important;
	padding: 0 !important;
	margin: 0 !important;
	cursor: pointer !important;
	display: flex;
	align-items: center;
	justify-content: center;
	text-indent: -9999px; /* 텍스트 숨김 */
	overflow: hidden; /* 텍스트가 버튼 크기를 넘지 않도록 */
}
</style>

</head>
<body>

	<%@ include file="/WEB-INF/views/header.jsp"%>

	<div class="content_outline">
		<%@ include file="/WEB-INF/views/sidebar.jsp"%>
		<div class="content_right">
			<div id="calendar"></div>
			<!-- 일정 캘린더가 표시될 부분 -->
		</div>
	</div>
	<!-- 일정 추가 모달 -->
	<div class="modal fade" id="addScheduleModal" tabindex="-1"
		role="dialog" aria-labelledby="addScheduleModalLabel"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="addScheduleModalLabel">일정 추가</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<!-- 일정 추가 폼 -->
					<form id="addScheduleForm">
						<div class="form-group">
							<label for="scheduleTitle">제목</label> <input type="text"
								class="form-control" id="scheduleTitle" name="title">
						</div>
						<div class="form-group">
							<label for="scheduleStartDate">시작 날짜</label> <input type="date"
								class="form-control" id="scheduleStartDate" name="startDate">
						</div>
						<div class="form-group">
							<label for="scheduleEndDate">종료 날짜</label> <input type="date"
								class="form-control" id="scheduleEndDate" name="endDate">
						</div>
						<div class="form-group">
							<label for="scheduleContent">내용</label> <input type="text"
								class="form-control" id="scheduleContent" name="content">
						</div>
						<div class="form-group">
							<label for="scheduleShareto">공유 대상</label> <select
								class="form-control" id="scheduleShareto" name="shareto">
								<option value="개인">개인</option>
								<option value="팀">팀</option>
								<option value="부서">부서</option>
								<option value="사용자 설정">사용자 설정</option>
							</select>
						</div>
						<!-- 추가적인 드롭다운은 기본적으로 숨김 -->
						<div class="form-group" id="customSharetoGroup"
							style="display: none;">
							<label for="customShareto">사용자 설정 공유 대상</label> <select
								class="form-control" id="customShareto" name="customShareto">
								<!-- 여기에 사용자 설정 항목을 추가하세요 
                            <option value="user1">User 1</option>
                            <option value="user2">User 2</option>
                            <option value="user3">User 3</option>
                            -->
							</select>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary"
						onclick="saveSchedule()">저장</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 일정 상세 모달 -->
	<div class="modal fade" id="eventDetailModal" tabindex="-1"
		role="dialog" aria-labelledby="eventDetailModalLabel"
		aria-hidden="true">
		<div class="modal-dialog" role="document" style="margin-top: 10%;">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="eventDetailModalLabel">일정 상세</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<!-- 일정 상세 내용 표시 영역 -->
					<p>
						<strong>제목:</strong> <span id="eventTitle"></span>
					</p>
					<p>
						<strong>시작 날짜:</strong> <span id="eventStartDate"></span>
					</p>
					<p>
						<strong>종료 날짜:</strong> <span id="eventEndDate"></span>
					</p>
					<p>
						<strong>내용:</strong> <span id="eventContent"></span>
					</p>
					<p>
						<strong>공유 대상:</strong> <span id="eventShareto"></span>
					</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						id="deleteEventButton" style="display: none;">삭제</button>
					<button type="button" class="btn btn-primary" id="editEventButton"
						style="display: none;">수정</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 일정 수정 모달 -->
	<div class="modal fade" id="editEventModal" tabindex="-1" role="dialog"
		aria-labelledby="editEventModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="editEventModalLabel">일정 수정</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<!-- 일정 수정 폼 영역 -->
					<form id="editEventForm">
						<input type="hidden" id="editEventId">
						<div class="form-group">
							<label for="editEventTitle">제목</label> <input type="text"
								class="form-control" id="editEventTitle">
						</div>
						<div class="form-group">
							<label for="editEventStartDate">시작일</label> <input type="date"
								class="form-control" id="editEventStartDate">
						</div>
						<div class="form-group">
							<label for="editEventEndDate">종료일</label> <input type="date"
								class="form-control" id="editEventEndDate">
						</div>
						<div class="form-group">
							<label for="editEventContent">내용</label> <input type="text"
								class="form-control" id="editEventContent">
						</div>
						<div class="form-group">
							<label for="editEventShareto">공유 대상</label> <select
								class="form-control" id="editEventShareto">
								<option value="개인">개인</option>
								<option value="팀">팀</option>
								<option value="부서">부서</option>
								<option value="사용자 설정">사용자 설정</option>
							</select>
						</div>
						<!-- 추가적인 드롭다운은 기본적으로 숨김 -->
						<div class="form-group" id="customSharetoGroupEdit"
							style="display: none;">
							<label for="customSharetoEdit">사용자 설정 공유 대상</label> <select
								class="form-control" id="customSharetoEdit"
								name="customSharetoEdit">
							</select>
						</div>
						<button type="submit" class="btn btn-primary">저장</button>
						<!-- <button type="button" class="btn btn-primary" onclick="updateSchedule()">저장</button> -->
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- 사용자 설정 그룹 관련 설정 옵션 모달 -->
	<div class="modal fade" id="settingsOptionsModal" tabindex="-1"
		role="dialog" aria-labelledby="settingsOptionsModalLabel"
		aria-hidden="true" style="margin: auto;">
		<div class="modal-dialog" role="document" style="margin-top: 10%">
			<div class="modal-content" style="">
				<div class="modal-header">
					<h5 class="modal-title" id="settingsOptionsModalLabel">설정 옵션</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<!--                 <button type="button" class="btn btn-primary btn-block mb-2" id="createGroupBtn">사용자 설정 그룹 만들기</button>
                <button type="button" class="btn btn-danger btn-block" id="inviteGroupBtn">기존 그룹에 사용자 초대하기</button>
                <button type="button" class="btn btn-danger btn-block" id="leaveGroupBtn">기존 사용자 설정 그룹 나가기</button>
 -->
					<button type="button" class="btn btn-mint btn-block mb-2"
						id="createGroupBtn">사용자 설정 그룹 만들기</button>
					<button type="button" class="btn btn-mint btn-block mb-2"
						id="inviteGroupBtn">기존 그룹에 사용자 초대하기</button>
					<button type="button" class="btn btn-pastel-pink btn-block"
						id="leaveGroupBtn">기존 사용자 설정 그룹 나가기</button>

				</div>
			</div>
		</div>
	</div>
<style>
.searchArea {
	width: 100%;
	max-height: 100px;
	overflow-y: auto;
	padding: 10px;
	background-color: #F2F2F2;
	border-radius: 10px;
}

.delete-btn-seongeun {
	background-color: #DA3343;
	border: none;
	color: #ffffff;
	border-radius: 5px;
	font-size: small;
	/* width: 25px;
height : 25px; */
	text-align: center;
}
</style>
	<!--  20240814 성은 여기 수정중 !  -->
	<!-- 사용자 설정 그룹 만들기 모달 -->
	<div class="modal fade" id="createGroupModal" tabindex="-1"
		role="dialog" aria-labelledby="customGroupModalLabel"
		aria-hidden="true">
		<div class="modal-dialog" role="document" style="margin-top: 7%;">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="customGroupModalLabel">사용자 설정 그룹
						만들기</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close" onclick="closeUserCostomGroup()">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<!-- 사용자 설정 그룹명 입력 -->
					<div class="form-group">
						<label for="groupName">사용자 설정 그룹명:</label> <input type="text"
							class="form-control" id="groupName">
					</div>
					<!-- 사용자 초대 검색 -->
					<div class="form-group">
						<label for="userSearch">사용자 초대:</label>
						<div style="display: flex;">
							<input type="text" class="form-control" style="width: 87%;"
								id="userSearch">
							<button type="button" class="btn btn-primary"
								id="searchUserButton">검색</button>
						</div>
					</div>
					<!-- 검색 결과 -->
					<div id="searchResults" style=""></div>
					<hr id="searchUser-hr" style="display: none;">
					<!-- 선택된 사용자 목록 -->
					<div id="selectedUsers"
						style="width: 100%; max-height: 100px; overflow-y: auto; padding: 10px;"></div>
					<!-- 색상 선택 -->
					<div class="form-group">
						<label for="colorPicker">색깔 선택:</label>
						<!-- 기본 색상 파랑으로 설정 + 칸 너비 좀 더 줘서 클릭 할 수 있도록 유도 -->
						<input type="color" class="form-control" id="colorPicker"
							value="#007BFF" style="height: 38px;">
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="saveGroupButton">저장</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal" onclick="closeUserCostomGroup()">닫기</button>
				</div>
			</div>
		</div>
	</div>



	<!-- 기존 그룹에 사용자 초대하기 모달 -->
	<div class="modal fade" id="inviteGroupModal" tabindex="-1"
		role="dialog" aria-labelledby="inviteGroupModalLabel"
		aria-hidden="true">
		<div class="modal-dialog" role="document" style="margin-top: 10%;">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="inviteGroupModalLabel">그룹에 사용자
						초대하기</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<!-- 그룹 선택 -->
					<div class="form-group">
						<label for="groupSelect">그룹 선택:</label> <select
							class="form-control" id="groupSelect"></select>
					</div>
					<!-- 사용자 초대 검색 -->
					<div class="form-group" >
						<label for="inviteUserSearch">사용자 초대:</label> 
						<div style="display: flex; ">
						<input type="text"
							class="form-control" id="inviteUserSearch" style="width: 87%;">
						<button type="button" class="btn btn-primary"
							id="inviteSearchUserButton">검색</button>
						</div>
					</div>
					<!-- 검색 결과 -->
					<div id="inviteSearchResults"></div>
					<hr id="inviteSearchUser-hr" style="display: none;">
					<!-- 선택된 사용자 목록 -->
					<div id="inviteSelectedUsers" style="width: 100%; max-height: 100px; overflow-y: auto; padding: 10px;"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						id="inviteUsersButton">초대하기</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>



	<!-- 기존 그룹 나가기 모달 -->
	<div class="modal fade" id="leaveGroupModal" tabindex="-1"
		role="dialog" aria-labelledby="leaveGroupModalLabel"
		aria-hidden="true">
		<div class="modal-dialog" role="document" style="margin-top: 10%;">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="leaveGroupModalLabel">사용자 설정 그룹 나가기</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<!-- 그룹 선택 -->
					<div class="form-group">
						<label for="groupSelectForExit">그룹 선택:</label> <select
							class="form-control" id="groupSelectForExit"></select>
					</div>
					<!-- 검색 결과 -->
					<div id="inviteSearchResults"></div>
				</div>
				<div class="modal-footer"><!-- 08161534 -->
					<button type="button" class="btn btn-primary btn-pastel-pink" id="leaveButton">그룹 나가기</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<div id="loading-spinner" class="spinner-overlay">
		<iframe src="https://giphy.com/embed/yWzaP4UGjYVzFXjlyw" width="150"
			height="150" style="pointer-events: none;" frameBorder="0"
			class="giphy-embed" allowFullScreen class="custom-spinner"></iframe>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.11.3/main.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

	<script>
    var calendar;
    var currentDate;
    let todoCountData = {};    
    let selectedUsers = [];
	let inviteSelectedUsers = [];
    $(document).ready(function() {
       //let selectedUsers = [];

        // 그룹명 중복 체크
        $('#groupName').on('blur', function() {
            const groupName = $(this).val();
            $.ajax({
                url: '${pageContext.request.contextPath}/checkGroupName',
                method: 'POST',
                data: JSON.stringify({ groupName: groupName }),
                contentType: 'application/json',
                success: function(response) {
                    if (response.exists) {
                        alert('동일한 그룹명이 이미 존재합니다.');
                        $('#groupName').val('').focus();
                    }
                }
            });
        });

        // 사용자 검색
		$('#searchUserButton').on('click', function() {
		    const userName = $('#userSearch').val();
		    $.ajax({
		        url: '${pageContext.request.contextPath}/searchUser',
		        method: 'POST',
		        data: JSON.stringify({ username: userName }),
		        contentType: 'application/json',
		        success: function(response) {
		            const resultsContainer = $('#searchResults');
		            resultsContainer.empty();
		
		            console.log('Server response:', response); // 디버깅을 위한 로그
		            console.log('selectedUsers:', selectedUsers); // 디버깅을 위한 로그
					
		            if (response.users && Array.isArray(response.users) && response.users.length > 0) {
		                response.users.forEach(user => {
		                    const userno = user.userno || '';
		                    const name = user.name || '';
		                    const deptname = user.deptname || '';
		                    const teamname = user.teamname || '';
		
		                    console.log('test userno:', userno); // 디버깅을 위한 로그
		                    console.log('test name:', name); // 디버깅을 위한 로그
		                    console.log('test deptname:', deptname); // 디버깅을 위한 로그
		                    console.log('test teamname:', teamname); // 디버깅을 위한 로그
		
		                    const isSelected = selectedUsers.some(u => u.userno === user.userno);
		                    console.log('isSelected:', isSelected); // isSelected 값을 확인하기 위한 로그
		                    
		                    // 체크 박스 체크 안되게 하는 거 살짝 주석해볼게요 ?
		                    // 파란 선택 박스도 일단 잠깐 없애봄 
		                    const userHtml = 
		                      //  '<div class="search-result ' + (isSelected ? 'selected' : '') + '">' +
		                        '<div class="search-result ' + '">' +
		                        '<input type="checkbox" name="userSelect" value="' + userno + '" ' + (isSelected ? 'checked ' : '') + '> ' +
		                        '<span>' + name + ' (' + userno + ') - ' + deptname + ' / ' + teamname + '</span>' +
		                        '</div>';
		                    console.log('userHtml:', userHtml); // userHtml 값을 확인하기 위한 로그
		
		                    resultsContainer.append(userHtml);
		                }); 
		                    $('#searchResults').addClass('searchArea');
		                    $('#searchUser-hr').css('display', 'block');
		            } else {
		                resultsContainer.append('<p style="margin : 0px; margin-left : 10px;"> 검색 결과가 없습니다.</p>');
		                $('#searchUser-hr').css('display', 'none');
		                
		            }
		        },
		        error: function(xhr, status, error) {
		            console.error('사용자 검색 중 오류가 발생했습니다:', error);
		            alert('사용자 검색 중 오류가 발생했습니다. 다시 시도해주세요.');
		        }
		    });
		});

        // 사용자 선택
        $('#searchResults').on('change', 'input[name="userSelect"]', function() {
            const $this = $(this);
        	const userno = $(this).val();
        	const findUserno = $(this).val(); // 성은 추가
            const userSpan = $(this).next('span');
            const userName = userSpan.text().split('(')[0].trim();
            const deptName = userSpan.text().split('-')[1].split('/')[0].trim();
            const teamName = userSpan.text().split('/')[1].trim();
            console.log('choose userno:', userno); // 디버깅을 위한 로그
            console.log('choose userName:', userName); // 디버깅을 위한 로그
            console.log('choose deptName:', deptName); // 디버깅을 위한 로그
            console.log('choose teamName:', teamName); // 디버깅을 위한 로그

            if ($this.is(':checked')) {
                // 사용자 선택
                if (selectedUsers.some(user => user.userno === userno)) {
                    alert('이미 선택된 사용자입니다.');
                    $this.prop('checked', false);
                    return;
                }
                
                selectedUsers.push({
                    userno: userno,
                    name: userName,
                    deptname: deptName,
                    teamname: teamName
                });
                
                const selectedUserHtml = 
                    '<div class="selected-user" data-userno="' + userno + '">' +
                    '<span>' + userName + ' (' + userno + ') - ' + deptName + ' / ' + teamName + '</span>' +
                    ' <button type="button"  class="remove-user delete-btn-seongeun" style="margin-left : 5px; margin-top : 5px;">X</button>' +
                    '</div>';
                   /* border:none; background-color : #DA3343; */
                $('#selectedUsers').append(selectedUserHtml);
                
                //$this.closest('.search-result').addClass('selected');
            } else {
                // 사용자 선택 해제
                // 체크박스 해제될 때 
                selectedUsers = selectedUsers.filter(user => user.userno !== userno);
                $('#selectedUsers').find('.selected-user[data-userno="'+findUserno+'"]').remove();
                $this.closest('.search-result').removeClass('selected'); 
            }

        });

        // 사용자 제거 (지우는 버튼 눌렀을 때)
        $('#selectedUsers').on('click', '.remove-user', function() {
        	const userno = String($(this).closest('.selected-user').data('userno'));
            console.log('Removing user with userno :'+userno);
            
            selectedUsers = selectedUsers.filter(user => String(user.userno) !== userno);
        	
            $(this).closest('.selected-user').remove();
            
            // 검색 결과에서 해당 사용자의 체크박스 체크 해제 및 'selected' 클래스 제거
            $('#searchResults').find('input[name="userSelect"][value='+userno+']') 
                .prop('checked', false)
                .closest('.search-result')
                .removeClass('selected');
        });
        

        // 그룹 저장
        $('#saveGroupButton').on('click', function() {
            const groupName = $('#groupName').val();
            const sharecolor = $('#colorPicker').val();
            if (!groupName) {
                alert('그룹명을 입력해주세요.');
                return;
            }
            
            const groupData = selectedUsers.map(user => ({
                userno: user.userno,
                customname: groupName,
                sharecolor: sharecolor
            }));
            
            $.ajax({
                url: '${pageContext.request.contextPath}/saveGroup',
                method: 'POST',
                data: JSON.stringify(groupData),
                contentType: 'application/json',
                success: function(response) {
                    alert('그룹이 성공적으로 생성되었습니다.');
                    $('#customGroupModal').modal('hide');
                    $('#createGroupModal').modal('hide');
                    closeUserCostomGroup();
                },
                error: function(xhr, status, error) {
                    console.error('그룹 저장 중 오류가 발생했습니다:', error);
                    alert('그룹 저장 중 오류가 발생했습니다. 다시 시도해주세요.');
                }
            });
        });
    });
    

    
    $(document).ready(function() {
        $('#scheduleShareto').change(function() {
            if ($(this).val() === '사용자 설정') {
                // 사용자 설정을 선택했을 때 Ajax 호출
                $.ajax({
                    url: '${pageContext.request.contextPath}/customsharetoload',
                    method: 'POST',
                    contentType: 'application/json',
                    success: function(response) {
                        $('#customShareto').empty();

                        if (response.length > 0) {
                            $.each(response, function(index, item) {
                                $('#customShareto').append($('<option>', {
                                    value: item.sharedepth3,
                                    text: item.customname
                                }));
                            });
                            $('#customSharetoGroup').show();
                        } else {
                            alert('사용자 설정 그룹이 없습니다.');
                            $('#customSharetoGroup').hide();
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('사용자 설정 불러오기 중 오류가 발생했습니다:', error);
                        alert('사용자 설정 불러오기 중 오류가 발생했습니다. 다시 시도해주세요.');
                    }
                });
            } else {
                $('#customSharetoGroup').hide();
            }
        });
        
        $('#editEventShareto').change(function() {
            if ($(this).val() === '사용자 설정') {
                $.ajax({
                    url: '${pageContext.request.contextPath}/customsharetoload',
                    method: 'POST',
                    contentType: 'application/json',
                    success: function(response) {
                        $('#customSharetoEdit').empty();
                        if (response.length > 0) {
                            $.each(response, function(index, item) {
                                $('#customSharetoEdit').append($('<option>', {
                                    value: item.sharedepth3,
                                    text: item.customname
                                }));
                            });
                            $('#customSharetoGroupEdit').show();
                        } else {
                            alert('사용자 설정 그룹이 없습니다.');
                            $('#customSharetoGroupEdit').hide();
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('사용자 설정 불러오기 중 오류가 발생했습니다:', error);
                        alert('사용자 설정 불러오기 중 오류가 발생했습니다. 다시 시도해주세요.');
                    }
                });
            } else {
                $('#customSharetoGroupEdit').hide();
            }
        });
        
        // 모달이 닫힐 때 추가 작업을 수행하는 이벤트 리스너
        $('#createGroupModal').on('hidden.bs.modal', function (e) {
            closeUserCostomGroup();
        });

        
    });
	//성은 만들고 있는 스크립트(0816)
	//검색 결과 영역과 선택 사용자 영역을 모두 지워주고, 선택된 사용자 들을 저장하는 배열을 초기화함
    function closeUserCostomGroup(){
   	 	console.log('Before clearing selectedUsers:', selectedUsers); // 배열 초기화 전 상태 확인
    	    
   	    $("#searchResults").empty();  
   	    $("#searchResults").removeClass('searchArea');
   	    $("#selectedUsers").empty();
   	    $('#searchUser-hr').css('display', 'none');
   	 	$("#groupName").val('');
   	 	$("#userSearch").val('');
   	 
   	    selectedUsers.length = 0; // 배열 초기화
   	    
   	    console.log('After clearing selectedUsers:', selectedUsers); // 배열 초기화 후 상태 확인
		

    }
    
    
    function handleDateClickTo(info) {
    	handleDateClick(info);
    }
    
    function handleDateClick(info) {
        $('#addScheduleModal').modal('show');
        $('#addScheduleForm #scheduleStartDate').val(info.dateStr);
        $('#addScheduleForm #scheduleEndDate').val(info.dateStr); // 종료 날짜 일단 시작날짜
    } 
    
    function showEventDetailModal(event) {
        var sessionUserno = '${sessionScope.userno}'; // 서버에서 세션 userno를 가져옴
        console.log('Session userno:', sessionUserno);
        console.log('Event id:', event.extendedProps.userid);
        
        $('#eventTitle').text(event.title);
        $('#eventStartDate').text(moment(event.start).format('YYYY-MM-DD'));
        $('#eventEndDate').text(event.extendedProps.realEndDate || moment(event.end).subtract(1, 'days').format('YYYY-MM-DD'));
        $('#eventContent').text(event.extendedProps.content);
        $('#eventShareto').text(event.extendedProps.customname);
        $('#eventCategory').text(event.extendedProps.category);

        // 수정 및 삭제 버튼 표시 여부 결정
        if (sessionUserno === event.extendedProps.userid) {
            $('#editEventButton').show();
            $('#deleteEventButton').show();
        } else {
            $('#editEventButton').hide();
            $('#deleteEventButton').hide();
        }

        $('#editEventButton').data('event', event);
        $('#eventDetailModal').modal('show');
    }

    function saveSchedule() {
        const title = $('#addScheduleForm #scheduleTitle').val();
        const startDate = $('#addScheduleForm #scheduleStartDate').val();
        let endDate = $('#addScheduleForm #scheduleEndDate').val();
        const content = $('#addScheduleForm #scheduleContent').val();
        const shareto = $('#addScheduleForm #scheduleShareto').val();
        let customShare = $('#customShareto').val() || null;

        if (!title) {
            alert("제목을 입력해주세요.");
            return;
        }
        
        // 날짜 문자열을 Date 객체로 변환
        const startDateObj = new Date(startDate);
        const endDateObj = new Date(endDate || startDate);
        
        
        if (startDateObj > endDateObj) {
            alert("종료일자는 시작일자보다 이전 일자로 등록할 수 없습니다.");
            return;
        }
        
        // FullCalendar 표시용 종료일 (다음날)
        const displayEndDate = new Date(endDateObj);
        displayEndDate.setDate(displayEndDate.getDate() + 1);
        
        
        const eventData = {
                title: title,
                startDate: startDate,
                endDate: endDate || startDate,
                content: content,
                shareto: shareto,
                customShare: customShare
            };
        
        console.log('Event Data:', eventData);

        $.ajax({
            url: '${pageContext.request.contextPath}/calendarsave',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(eventData),
            success: function(response) {
                console.log('일정이 성공적으로 저장되었습니다.');
                calendar.addEvent({
                    title: title,
                    start: startDate,
                    //end: endDate,
	                end: displayEndDate.toISOString().split('T')[0],
                    allDay: true,
                    extendedProps: {
                        content: content,
                        shareto: shareto,
                        customShare: customShare,
                        realEndDate: endDate  // 실제 종료일 저장
                    }
                });
                //calendar.refetchEvents();
                $('#addScheduleModal').modal('hide');
                calendar.refetchEvents();
                location.reload(); // 페이지 새로고침
            },
            error: function(xhr, status, error) {
                console.error('일정 저장 중 오류가 발생했습니다:', error);
                console.log('XHR Object:', xhr);
                console.log('Status:', status);
                console.log('Error:', error);
                alert('일정 저장 중 오류가 발생했습니다. 다시 시도해주세요.');
            }
        });
    }

    function updateSchedule() {
        // event.preventDefault(); // 폼의 기본 제출 동작 방지

        const scheduleid = $('#editEventId').val();
        const title = $('#editEventTitle').val();
        const startDate = $('#editEventStartDate').val();
        let endDate = $('#editEventEndDate').val();
        const content = $('#editEventContent').val();
        const shareto = $('#editEventForm #editEventShareto').val();
        let customShare = $('#customSharetoEdit').val() || null; 

        if (!title) {
            alert("제목을 입력해주세요.");
            return;
        }

        // 날짜 유효성 검사
        const startDateObj = new Date(startDate);
        const endDateObj = new Date(endDate);
        if (startDateObj > endDateObj) {
            alert("종료일자는 시작일자보다 이전 일자로 등록할 수 없습니다.");
            return;
        }

        
        const eventData = { 
            scheduleid: scheduleid,
            title: title,
            startDate: startDate,
            endDate: endDate,
            content: content,
            shareto: shareto,
            customShare: customShare
        };
        
        console.log('Sending event data:', eventData);  // 데이터 확인용 로그
        
        $.ajax({
            url: '${pageContext.request.contextPath}/calendaredit',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(eventData),
            success: function(response) {
                console.log('일정이 성공적으로 업데이트되었습니다.');
                $('#editEventModal').modal('hide');

                // 서버에서 최신 데이터를 다시 가져옵니다.
                $.ajax({
                    url: "${pageContext.request.contextPath}/calendarData",
                    method: "GET",
                    dataType: "json",
                    success: function(response) {
                        console.log("Received data:", response); // 받은 데이터 구조 확인

                        calendar.removeAllEvents();
                        
                        // 서버 응답 구조에 따라 이 부분을 수정하세요
                        const events = response.map(event => ({
                            id: event.id,
                            title: event.title,
                            start: event.start,
                            end: adjustEndDate(event.end),
                            allDay: true,
                            extendedProps: {
                                content: event.extendedProps.content,
                                sharecolor: event.extendedProps.sharecolor,
                                category: event.extendedProps.category,
                                customname: event.extendedProps.customname,
                                userid: event.extendedProps.userid
                            },
                            backgroundColor: event.extendedProps.sharecolor,
                            borderColor: event.extendedProps.sharecolor
                        }));

                        calendar.addEventSource(events);
                       	                         
                        // 현재 날짜 말고 수정한 위치로 이동.
                        if (calendar && currentDate) {
                            calendar.gotoDate(eventData.startDate); 
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('캘린더 데이터 가져오기 실패:', error);
                    }
                });
            },
            error: function(xhr, status, error) {
                console.error('일정 업데이트 중 오류가 발생했습니다:', error);
                alert('일정 업데이트 중 오류가 발생했습니다. 다시 시도해주세요.');
            }
        });
    }

    // 캘린더 뷰 업데이트 함수 (예시)
    function updateCalendarView() {
        calendar.refetchEvents();
        // 필요한 경우 추가적인 UI 업데이트 로직
    }
    
    function adjustEndDate(endDate) {
        if (!endDate) return null;
        const date = new Date(endDate);
        date.setDate(date.getDate() + 1);
        return date.toISOString().split('T')[0]; // ISO 형식의 날짜 문자열로 변환
    }

    function handleEventDropTo(info) {
    	handleEventDrop(info.event);
    }
    
    function handleEventDrop(event) {
        var sessionUserno = '${sessionScope.userno}';
         console.log(event.extendedProps.userid);
        console.log(sessionUserno);

        if (sessionUserno !== event.extendedProps.userid) {
            alert('일정 이동 권한이 없습니다.');
            location.reload(); // 캘린더 새로고침
            return;
        }
        
        const scheduleid = event.id;
        const title = event.title;
        const startDate = event.start.toLocaleDateString('ko-KR', { timeZone: 'Asia/Seoul', year: 'numeric', month: '2-digit', day: '2-digit' }).replace(/\. /g, '-').replace('.', '');
        let endDate = event.end ? event.end.toLocaleDateString('ko-KR', { timeZone: 'Asia/Seoul', year: 'numeric', month: '2-digit', day: '2-digit' }).replace(/\. /g, '-').replace('.', '') : null;
        const content = event.extendedProps.content;
        const shareto = event.extendedProps.category;
        const customShare = event.extendedProps.sharedepth3;

        // endDate의 exclusive -> inclusive 변환부분 되돌리기 위해 endDate를 하루 줄임
        if (endDate) {
            let endDateObj = new Date(endDate);
            endDateObj.setDate(endDateObj.getDate() - 1);
            endDate = endDateObj.toLocaleDateString('ko-KR', { timeZone: 'Asia/Seoul', year: 'numeric', month: '2-digit', day: '2-digit' }).replace(/\. /g, '-').replace('.', '');
        }
        
        const eventData = { scheduleid: scheduleid, title, startDate, endDate, content, shareto, customShare };

        console.log('Sending event data:', eventData);  // 데이터 확인용 로그
        
        $.ajax({
            url: '${pageContext.request.contextPath}/calendaredit',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(eventData),
            success: function(response) {
                console.log('일정이 성공적으로 업데이트 되었습니다.');
                //location.reload();
                calendar.refetchEvents();
                // 필요에 따라 모달 숨기기 등의 추가 작업을 할 수 있습니다.
                if (currentDate) {
                //console.log(eventData.endDate);
                calendar.gotoDate(currentDate);
            	}
            },
            error: function(xhr, status, error) {
                console.error('일정 업데이트 중 오류가 발생했습니다:', error);
                alert('일정 업데이트 중 오류가 발생했습니다. 다시 시도해주세요.');
                location.reload();
                //calendar.refetchEvents();
            }
        });
    }
    
    function loadTodoCountData() {
    	return new Promise((resolve, reject) => {
            $.ajax({
                url: "/countTodoList",
                method: "GET",
                dataType: "json"
            }).done(function (data) {
                console.log("Received countTodoList data:", data);
                todoCountData = data.reduce((acc, item) => {
                	if (item.duedate && item.todocount) {
                        acc[item.duedate] = parseInt(item.todocount, 10);
                    }
                    return acc;
                }, {});
                resolve(todoCountData);
            }).fail(function(jqXHR, textStatus, errorThrown) {
                console.error("countTodo AJAX request failed: " + textStatus, errorThrown);
                reject(errorThrown);
            });
        });
	}
    

     function loadCalendarData(calendarEl) {
         $.ajax({
             url: "${pageContext.request.contextPath}/calendarData",
             method: "GET",
             dataType: "json"
         }).done(function (data) {
             console.log("Received data:", data);
             createCalendar(calendarEl, data);
         }).fail(function(jqXHR, textStatus, errorThrown) {
             console.error("loadCalendar AJAX request failed: " + textStatus, errorThrown);
         });
     }

     function createCalendar(calendarEl, data) {
         calendar = new FullCalendar.Calendar(calendarEl, {
             initialView: 'dayGridMonth',
             locale: 'ko',
             timeZone: 'Asia/Seoul',
             headerToolbar: {
                 left: 'prev next today',
                 center: 'title',
                 right: 'todoList shareGroup'
             },
             customButtons: {
                 shareGroup: {
                     text: '',
                     click: function() { 
                         $('#settingsOptionsModal').modal('show');
                     }
                 },
                 todoList: {
                	 text: 'todolist',
                     click: function() {
                         window.location.href = '/todo';
                     }
                 }
             },
             navLinks: false,
             editable: true,
             selectable: true,
             droppable: true,
             dayMaxEvents: true,
             contentHeight: 650,
             datesSet: handleDatesSet,
             events: formatEvents(data),
             eventClick: handleEventClick,
             eventDrop: handleEventDropTo,
             dateClick: // handleDateClickTo,
            	 function(info) {
                 // 클릭된 요소가 todo-count 클래스를 가진 요소의 자식이 아닌지 확인
                 if (!info.jsEvent.target.closest('.todo-count')) {
                     handleDateClickTo(info);
                 }
             },
             dayCellDidMount: function(arg) {
                 const date = arg.date.toISOString().split('T')[0];
                 const todoCount = todoCountData[date];
                 if (todoCount > 0) {
                     const countElement = document.createElement('div');
                     countElement.className = 'todo-count';
                     countElement.textContent = todoCount;
                     
                     countElement.style.cursor = 'pointer'; // 커서 모양을 포인터로 변경
                     // 클릭 이벤트 리스너 추가
                     countElement.addEventListener('click', function(e) {
                         e.stopPropagation(); // 이벤트 전파 중단
                         window.location.href = '/todo';
                     });
                     
                     const dayTopElement = arg.el.querySelector('.fc-daygrid-day-top'); // 날짜 셀의 상단 부분을 선택
                     if (dayTopElement) {
                         dayTopElement.style.position = 'relative'; // 상대 위치 지정
                         dayTopElement.appendChild(countElement); // countElement를 dayTopElement에 추가
                     }
                 }
             }
         });
         calendar.render();
     }

     function handleDatesSet(dateInfo) {
         currentDate = new Date(dateInfo.view.currentStart.getFullYear(), dateInfo.view.currentStart.getMonth(), 15);
         console.log('Current date set to:', currentDate);
     }

     function formatEvents(data) {
         return data.map(event => ({
             ...event,
             end: adjustEndDate(event.end),
             backgroundColor: event.extendedProps.sharecolor,
             borderColor: event.extendedProps.sharecolor,
             shareCategory: event.extendedProps.category,
             customname: event.extendedProps.customname,
             userid: event.extendedProps.userid,
             allDay: true
         }));
     }

     function handleEventClick(info) {
         showEventDetailModal(info.event);
     }


     function handleEditEventClick() {
	    var event = $(this).data('event');
	    setEditModalValues(event);
	    loadCustomShareto(event)
	        .then(() => {
	            $('#eventDetailModal').modal('hide');
	            $('#editEventModal').modal('show');
	            setupEditModalEventHandlers(event);
	        })
	        .catch(error => {
	            console.error('Error:', error);
	        });
	}
	
	function setEditModalValues(event) {
	    $('#editEventId').val(event.id);
	    $('#editEventTitle').val(event.title);
	    $('#editEventStartDate').val(moment(event.start).format('YYYY-MM-DD'));
	    $('#editEventEndDate').val($('#eventEndDate').text());
	    $('#editEventContent').val(event.extendedProps.content);
	    $('#editEventShareto').val(event.extendedProps.shareCategory);
	    
	    console.log('ShareCategory set:', event.extendedProps.shareCategory);
	    console.log('CustomName set:', event.extendedProps.customname);
	
	    $('#editEventModal').data('event', event);
	}
	
	function loadCustomShareto(event) {
	    return new Promise((resolve, reject) => {
	        if (event.extendedProps.shareCategory === '사용자 설정') {
	            $.ajax({
	                url: '${pageContext.request.contextPath}/customsharetoload',
	                method: 'POST',
	                contentType: 'application/json',
	                success: function(response) {
	                    populateCustomSharetoOptions(response);
	                    resolve();
	                },
	                error: function(xhr, status, error) {
	                    console.error('사용자 설정 불러오기 중 오류가 발생했습니다:', error);
	                    reject(error);
	                }
	            });
	        } else {
	            $('#customSharetoGroupEdit').hide();
	            resolve();
	        }
	    });
	}
	
	function populateCustomSharetoOptions(response) {
	    $('#customSharetoEdit').empty();
	    if (response.length > 0) {
	        $.each(response, function(index, item) {
	            $('#customSharetoEdit').append($('<option>', {
	                value: item.customname,
	                text: item.customname,
	                'data-sharedepth3': item.sharedepth3
	            }));
	        });
	        $('#customSharetoGroupEdit').show();
	    }
	}
	
	function setupEditModalEventHandlers(event) {
	    $('#editEventModal').off('shown.bs.modal').on('shown.bs.modal', function (e) {
	        $('#editEventShareto').val(event.extendedProps.shareCategory);
	        
	        if (event.extendedProps.shareCategory === '사용자 설정') {
	            $('#customSharetoEdit').val(event.extendedProps.customname);
	            $('#customSharetoGroupEdit').show();
	        } else {
	            $('#customSharetoGroupEdit').hide();
	        }
	        
	        setupEditEventSharetoChangeHandler(event);
	        logFinalValues();
	    });
	}
	
	function setupEditEventSharetoChangeHandler(event) {
	    $('#editEventShareto').off('change').on('change', function() {
	        if ($(this).val() === '사용자 설정') {
	            $('#customSharetoGroupEdit').show();
	            if (!$('#customSharetoEdit').val()) {
	                $('#customSharetoEdit').val(event.extendedProps.customname);
	            }
	        } else {
	            $('#customSharetoGroupEdit').hide();
	        }
	    });
	}
	
	function logFinalValues() {
	    console.log('Final values set:');
	    console.log('editEventShareto:', $('#editEventShareto').val());
	    console.log('customSharetoEdit:', $('#customSharetoEdit').val());
	}

     function handleDeleteEventClick() {
         var event = $('#editEventButton').data('event');
         if (confirm('정말로 이 일정을 삭제하시겠습니까?')) {
             deleteEvent(event.id);
         }
     }

     function handleAddScheduleSubmit(e) {
         e.preventDefault();
         saveSchedule();
     }

     function handleEditEventSubmit(e) {
         e.preventDefault();
         updateSchedule();
     }
     
     
    
	//let inviteSelectedUsers = [];
     $(document).ready(function() {
    	 
    	 
   	    // 사용자 설정 그룹 만들기 버튼 클릭 시
   	    $('#createGroupBtn').on('click', function() {
   	        $('#settingsOptionsModal').modal('hide');
   	        $('#createGroupModal').modal('show');
   	    });

   	    // 기존 그룹에 사용자 초대하기 버튼 클릭 시
   	    $('#inviteGroupBtn').on('click', function() {
   	    	inviteSelectedUsers = [];
   	        $('#settingsOptionsModal').modal('hide');
   	        loadUserGroupsForInvite();
   	    });

    	    // 사용자 검색 버튼 클릭 이벤트
    	    $('#inviteSearchUserButton').on('click', function() {
    	        searchUsersForInvite();
    	    });
    	    
    	    // 사용자 선택 이벤트 리스너 추가
    	    $('#inviteSearchResults').on('change', 'input[name="userSelect"]', handleUserSelection);

    	    // 사용자 제거 이벤트 리스너 추가
    	    $('#inviteSelectedUsers').on('click', '.remove-user', removeSelectedUser);
    	    
    	    // 초대하기 버튼 클릭 이벤트
    	    $('#inviteUsersButton').on('click', function() {
    	        inviteUsersToGroup();
    	    });
   	    
   		// 기존 사용자 설정 그룹 나가기 버튼 클릭 시
   	    $('#leaveGroupBtn').on('click', function() {
   	        $('#settingsOptionsModal').modal('hide');
   	     	loadUserGroupsForExit();
   	        
   	    });
   		
   		// 모달에서 그룹 선택후 나가기 클릭시
   	    $('#leaveButton').on('click', function() {
   	        $('#leaveGroupModal').modal('hide');
   	     	leaveGroup();
   	    });
   	});
     
	// 사용자가 속한 그룹 로드
	function loadUserGroupsForExit() {
	    $.ajax({
	        url: '${pageContext.request.contextPath}/getUserGroupsForExit',
	        method: 'POST',
	        // contentType: 'application/json',
	        success: function(response) {
	            showLeaveGroupModal(response);
	   	     	// $('#leaveGroupModal').modal('show');
	            setTimeout(function() {
	                $('#leaveGroupModal').modal('show');
	            }, 100);
	        },
	        error: function(xhr, status, error) {
	            console.error('그룹 로드 중 오류 발생:', error);
	            alert('그룹 정보를 불러오는 데 실패했습니다.');
	        }
	    });
	}
	
	// 그룹 선택 옵션 채우기
	function showLeaveGroupModal(groups) {
	    const $select = $('#groupSelectForExit');
	    console.log('showLeaveGroupModal 진입');
	    $select.empty();
	    
	    if (!Array.isArray(groups)) {
	        console.error('groups is not an array:', groups);
	        return;
	    }
	    
	    groups.forEach(function(group) {
	        
	        $select.append($('<option>', {
	            value: group.sharedepth3,
	            text: group.customname
	        }));
	        
	        // 방금 추가된 option 요소의 내용을 확인
	        const $lastOption = $select.find('option:last');
	    });
	
	}
	
	function leaveGroup(groups) {
	    const groupId = $('#groupSelectForExit').val();
	    const groupName = $('#groupSelectForExit option:selected').text();
	    console.log('groupName:', groupName);
	    console.log('groupId:', groupId);

	    if (groupName.length === 0) {
	        alert('그룹을 선택해야 합니다.');
	        return;
	    }

	    $.ajax({
	        url: '${pageContext.request.contextPath}/leaveGroup',
	        method: 'POST',
	        data: JSON.stringify({
	            groupId: groupId
	        }),
	        contentType: 'application/json',
	        success: function(response) {
	            alert(groupName + ' 그룹에서 나갔습니다.');
	            $('#leaveGroupModal').modal('hide');
	            // 선택된 사용자 목록 초기화
	          	calendar.refetchEvents();
	        },
	        error: function(xhr, status, error) {
	            console.error('그룹 나가기 중 에러 발생:', error);
	            alert('그룹 나가기 중 오류가 발생했습니다. 다시 시도해주세요.');
	        }
	    });
	}
 	 
    // 사용자의 그룹 목록 로드 (초대용)
	function loadUserGroupsForInvite() {
	    $.ajax({
	        url: '${pageContext.request.contextPath}/getUserGroupsForInvite',
	        method: 'POST',
            contentType: 'application/json',
	        success: function(response) {
	            populateGroupSelect(response);
	            $('#inviteGroupModal').modal('show');
	        },
	        error: function(xhr, status, error) {
	            console.error('그룹 로드 중 오류 발생:', error);
	            alert('그룹 정보를 불러오는 데 실패했습니다.');
	        }
	    });
	}
    
	function searchUsersForInvite() {

	    const userName = $('#inviteUserSearch').val();
	    const groupNum = $('#groupSelect').val();
	    
	    console.log('userName:', userName);
	    console.log('groupNum:', groupNum);

	    $.ajax({
	        url: '${pageContext.request.contextPath}/searchUsersForInvite',
	        method: 'POST',
	        data: JSON.stringify({ username: userName, groupNum: groupNum }),
	        contentType: 'application/json',
	        success: function(response) {
	        	displayInviteSearchResults(response);
	        },
	        error: function(xhr, status, error) {
	            console.error('AJAX 요청 실패');
	            console.error('Status:', status);
	            console.error('Error:', error);
	            console.error('Response Text:', xhr.responseText);
	            console.error('Status Code:', xhr.status);
	            alert('사용자 검색 중 오류가 발생했습니다. 다시 시도해주세요.');
	        }
	    });
	}
    
	// 그룹 선택 옵션 채우기
	function populateGroupSelect(groups) {
	    const $select = $('#groupSelect');
	    $select.empty();
	    groups.forEach(function(group) {
	        $select.append($('<option>', {
	            value: group.sharedepth3,
	            text: group.customname
	        }));
	        console.log(group.sharedepth3);
	        console.log(group.customname);
	    });
	}
	
	function displayInviteSearchResults(response) {
	    const resultsContainer = $('#inviteSearchResults');
	    resultsContainer.empty();
	    console.log('Server response:', response);

	    if (response.users && Array.isArray(response.users) && response.users.length > 0) {
	        response.users.forEach(user => {
	            const userno = user.userno || '';
	            const name = user.name || '';
	            const deptname = user.deptname || '';
	            const teamname = user.teamname || '';

	            console.log('test userno:', userno);
	            console.log('test name:', name);
	            console.log('test deptname:', deptname);
	            console.log('test teamname:', teamname);

	            const isSelected = inviteSelectedUsers.some(u => u.userno === user.userno);
	            console.log('isSelected:', isSelected);

	            const userHtml = 
	                '<div class="search-result ">' +
	                '<input type="checkbox" name="userSelect" value="' + userno + '" ' + (isSelected ? 'checked ' : '') + '> ' +
	                '<span> ' + name + ' (' + userno + ') - ' + deptname + ' / ' + teamname + '</span>' +
	                '</div>';
	                
	            console.log('userHtml:', userHtml);
	            resultsContainer.append(userHtml);
	        });
            $('#inviteSearchResults').addClass('searchArea');
            $('#inviteSearchUser-hr').css('display', 'block');
	    } else {
	        resultsContainer.append('<p>검색 결과가 없습니다.</p>');
	        $('#inviteSearchUser-hr').css('display', 'none');
	    }
	}
	
	// 성은 여기 수정 중 0816
	function handleUserSelection() {
	    const $this = $(this);
	    const userno = $this.val();
	    const userSpan = $this.next('span');
	    const userName = userSpan.text().split('(')[0].trim();
	    const deptName = userSpan.text().split('-')[1].split('/')[0].trim();
	    const teamName = userSpan.text().split('/')[1].trim();

	    if ($this.is(':checked')) {  
	        // 사용자 선택
	        if (inviteSelectedUsers.some(user => user.userno === userno)) {
	            alert('이미 선택된 사용자입니다.');
	            $this.prop('checked', false);
	            return;
	        }
	        
	        inviteSelectedUsers.push({
	            userno: userno,
	            name: userName,
	            deptname: deptName,
	            teamname: teamName
	        });
	        
	        const selectedUserHtml = 
	            '<div class="selected-user" data-userno="' + userno + '">' +
	            '<span>' + userName + ' (' + userno + ') - ' + deptName + ' / ' + teamName + '</span>' +
	            ' <button type="button"  class="remove-user delete-btn-seongeun" style="margin-left : 5px; margin-top : 5px;">X</button>' +
	            '</div>';
	        
	        $('#inviteSelectedUsers').append(selectedUserHtml);
	        
	        //$this.closest('.search-result').addClass('selected');
	    } else {
	        removeUserFromSelection(userno);
	    }
	}
	function removeSelectedUser() {
	    const userno = $(this).closest('.selected-user').data('userno');
	    console.log('지우기 버튼 클릭.. !');
	    removeUserFromSelection(userno);
	}

	function removeUserFromSelection(userno) {
		
		inviteSelectedUsers = inviteSelectedUsers.filter(user => {
	        return String(user.userno) !== String(userno);
	    });
        $(this).closest('.selected-user').remove();
		
		
	    inviteSelectedUsers = inviteSelectedUsers.filter(user => user.userno !== userno);
	    $('#inviteSelectedUsers').find('.selected-user[data-userno="'+userno+'"]').remove();
	    $('#inviteSearchResults').find('input[name="userSelect"][value="'+userno+'"]')
	        .prop('checked', false)
	        .closest('.search-result')
	        .removeClass('selected');
	}
	
	// 선택된 사용자들을 그룹에 초대
	function inviteUsersToGroup() {
	    const groupId = $('#groupSelect').val();
	    const groupName = $('#groupSelect option:selected').text();
	    const selectedUsers = [];
	    $('#inviteSearchResults input:checked').each(function() {
	        selectedUsers.push($(this).val());
	    });

	    if (selectedUsers.length === 0) {
	        alert('초대할 사용자를 선택해주세요.');
	        return;
	    }

	    $.ajax({
	        url: '${pageContext.request.contextPath}/inviteUsersToGroup',
	        method: 'POST',
	        data: JSON.stringify({
	            groupId: groupId,
	            groupName: groupName,
	            userIds: selectedUsers
	        }),
	        contentType: 'application/json',
	        success: function(response) {
	            alert('선택한 사용자(들)을 그룹에 성공적으로 초대했습니다.');
	            $('#inviteGroupModal').modal('hide');
	            // 선택된 사용자 목록 초기화
	            inviteSelectedUsers = [];
	            $('#inviteSelectedUsers').empty();
	            $('#inviteSearchResults').empty();
	            location.reload(); // 페이지 새로고침
	        },
	        error: function(xhr, status, error) {
	            console.error('사용자 초대 중 오류 발생:', error);
	            alert('사용자 초대 중 오류가 발생했습니다. 다시 시도해주세요.');
	        }
	    });
	}

    
	function deleteEvent(eventId) {
	    $.ajax({
	        url: '${pageContext.request.contextPath}/calendardelete',
	        method: 'POST',
	        data: { scheduleid: eventId },  // JSON.stringify 제거
	        // contentType: 'application/json', 제거
	        success: function(response) {
	            console.log('일정이 성공적으로 삭제되었습니다.');
	            $('#eventDetailModal').modal('hide');
	            //calendar.refetchEvents();
	            location.reload(); // 페이지 새로고침
	            if (currentDate) {
               		calendar.gotoDate(currentDate);
           		}
	        },
	        error: function(xhr, status, error) {
	        	console.log('eventId: ' + eventId);
	        	console.error('일정 삭제 중 오류가 발생했습니다:', error);
	            alert('일정 삭제 중 오류가 발생했습니다. 다시 시도해주세요.');
	        }
	    });
	}    


	// Initialize everything
    function initializeCalendar() {
        document.addEventListener('DOMContentLoaded', function() {
        	
            var calendarEl = document.getElementById('calendar');
            /* loadCalendarData(calendarEl);
            loadCountTodoList(); */
            loadTodoCountData()
            .then(() => {
                loadCalendarData(calendarEl);
                
            }) 
            .catch(error => {
                console.error("Failed to load Todo count data:", error);
                // Todo 데이터 로드에 실패해도 캘린더는 계속 로드
                loadCalendarData(calendarEl);
            });
        });
    }

    function setupEventListeners() {
        $('#editEventButton').off('click').on('click', handleEditEventClick);
        $('#deleteEventButton').on('click', handleDeleteEventClick);
        $('#addScheduleForm').on('submit', handleAddScheduleSubmit);
        $('#editEventForm').on('submit', handleEditEventSubmit);

    }
    
   //로딩 이미지 테스트
    function showSpinner() {
        document.getElementById('loading-spinner').style.visibility = 'visible';
    }

    function hideSpinner() {
        document.getElementById('loading-spinner').style.visibility = 'hidden';
    }

    document.addEventListener('DOMContentLoaded', function() {
            hideSpinner(); 
        
    });  
    
    initializeCalendar();
    setupEventListeners();
      
</script>

	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

</body>


</html>
