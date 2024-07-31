<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>일정 관리</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.2/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.2/main.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/locale/ko.min.js'></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/calendar.css">
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="content_outline">
    <%@ include file="/WEB-INF/views/sidebar.jsp" %>
    <div class="content_right">
        <div id="calendar"></div> <!-- 일정 캘린더가 표시될 부분 -->
    </div> 
</div>

<!-- 일정 추가 모달 -->
<div class="modal fade" id="addScheduleModal" tabindex="-1" role="dialog" aria-labelledby="addScheduleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addScheduleModalLabel">일정 추가</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- 일정 추가 폼 -->
                <form id="addScheduleForm">
                    <div class="form-group">
                        <label for="scheduleTitle">제목</label>
                        <input type="text" class="form-control" id="scheduleTitle" name="title">
                    </div>
                    <div class="form-group">
                        <label for="scheduleStartDate">시작 날짜</label>
                        <input type="date" class="form-control" id="scheduleStartDate" name="startDate">
                    </div>
                    <div class="form-group">
                        <label for="scheduleEndDate">종료 날짜</label>
                        <input type="date" class="form-control" id="scheduleEndDate" name="endDate">
                    </div>
                    <div class="form-group">
                        <label for="scheduleContent">내용</label>
                        <input type="text" class="form-control" id="scheduleContent" name="content">
                    </div>
                    <div class="form-group">
                        <label for="scheduleShareto">공유 대상</label>
                        <select class="form-control" id="scheduleShareto" name="shareto">
                            <option value="개인">개인</option>
                            <option value="팀">팀</option>
                            <option value="부서">부서</option>
                            <option value="사용자 설정">사용자 설정</option>
                        </select>
                    </div>
                    <!-- 추가적인 드롭다운은 기본적으로 숨김 -->
                    <div class="form-group" id="customSharetoGroup" style="display: none;">
                        <label for="customShareto">사용자 설정 공유 대상</label>
                        <select class="form-control" id="customShareto" name="customShareto">
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
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" onclick="saveSchedule()">저장</button>
            </div>
        </div>
    </div>
</div>

<!-- 일정 상세 모달 -->
<div class="modal fade" id="eventDetailModal" tabindex="-1" role="dialog" aria-labelledby="eventDetailModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="eventDetailModalLabel">일정 상세</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- 일정 상세 내용 표시 영역 -->
                <p><strong>제목:</strong> <span id="eventTitle"></span></p>
                <p><strong>시작 날짜:</strong> <span id="eventStartDate"></span></p>
                <p><strong>종료 날짜:</strong> <span id="eventEndDate"></span></p>
                <p><strong>내용:</strong> <span id="eventContent"></span></p>
                <p><strong>공유 대상:</strong> <span id="eventShareto"></span></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="editEventButton">수정</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<!-- 일정 수정 모달 -->
<div class="modal fade" id="editEventModal" tabindex="-1" role="dialog" aria-labelledby="editEventModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editEventModalLabel">일정 수정</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- 일정 수정 폼 영역 -->
                <form id="editEventForm">
                    <input type="hidden" id="editEventId">
                    <div class="form-group">
                        <label for="editEventTitle">제목</label>
                        <input type="text" class="form-control" id="editEventTitle">
                    </div>
                    <div class="form-group">
                        <label for="editEventStartDate">시작일</label>
                        <input type="date" class="form-control" id="editEventStartDate">
                    </div>
                    <div class="form-group">
                        <label for="editEventEndDate">종료일</label>
                        <input type="date" class="form-control" id="editEventEndDate">
                    </div>
                    <div class="form-group">
                        <label for="editEventContent">내용</label>
                        <input type="text" class="form-control" id="editEventContent">
                    </div>
                    <div class="form-group">
                        <label for="editEventShareto">공유 대상</label>
                        <select class="form-control" id="editEventShareto">
                            <option value="개인">개인</option>
                            <option value="팀">팀</option>
                            <option value="부서">부서</option>
                            <option value="사용자 설정">사용자 설정</option>
                        </select>
                    </div>
                    <!-- 추가적인 드롭다운은 기본적으로 숨김 -->
					<div class="form-group" id="customSharetoGroupEdit" style="display: none;">
					    <label for="customSharetoEdit">사용자 설정 공유 대상</label>
					    <select class="form-control" id="customSharetoEdit" name="customSharetoEdit">
					    </select>
					</div>
					<button type="submit" class="btn btn-primary">저장</button>
                    <!-- <button type="button" class="btn btn-primary" onclick="updateSchedule()">저장</button> -->
                </form>
            </div>
        </div>
    </div>
</div>



<!-- 공유그룹 모달 -->
<!-- 
<div class="modal fade" id="settingsModal" tabindex="-1" role="dialog" aria-labelledby="eventDetailModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="eventDetailModalLabel">일정 상세</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p><strong>제목:</strong> <span id="eventTitle"></span></p>
                <p><strong>시작 날짜:</strong> <span id="eventStartDate"></span></p>
                <p><strong>종료 날짜:</strong> <span id="eventEndDate"></span></p>
                <p><strong>내용:</strong> <span id="eventContent"></span></p>
                <p><strong>공유 대상:</strong> <span id="eventShareto"></span></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="editEventButton">수정</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
 -->

<div class="modal fade" id="settingsModal" tabindex="-1" role="dialog" aria-labelledby="customGroupModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="customGroupModalLabel">사용자 설정 그룹 만들기</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- 사용자 설정 그룹명 입력 -->
                <div class="form-group">
                    <label for="groupName">사용자 설정 그룹명:</label>
                    <input type="text" class="form-control" id="groupName">
                </div>
                <!-- 사용자 초대 검색 -->
                <div class="form-group">
                    <label for="userSearch">사용자 초대:</label>
                    <input type="text" class="form-control" id="userSearch">
                    <button type="button" class="btn btn-primary" id="searchUserButton">검색</button>
                </div>
                <!-- 검색 결과 -->
                <div id="searchResults"></div>
                <!-- 선택된 사용자 목록 -->
                <div id="selectedUsers"></div>
                <!-- 색상 선택 -->
                <div class="form-group">
                    <label for="colorPicker">색깔 선택:</label>
                    <input type="color" class="form-control" id="colorPicker">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="saveGroupButton">저장</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>




<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.11.3/main.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    var calendar;

    $(document).ready(function() {
        let selectedUsers = [];

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
	                    
	                    const userHtml = 
	                        '<div class="search-result ' + (isSelected ? 'selected' : '') + '">' +
	                        '<input type="checkbox" name="userSelect" value="' + userno + '" ' + (isSelected ? 'checked disabled' : '') + '>' +
	                        '<span>' + name + ' (' + userno + ') - ' + deptname + ' / ' + teamname + '</span>' +
	                        '</div>';
	                    console.log('userHtml:', userHtml); // userHtml 값을 확인하기 위한 로그
	
	                    resultsContainer.append(userHtml);
	                });
	            } else {
	                resultsContainer.append('<p>검색 결과가 없습니다.</p>');
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
            const userSpan = $(this).next('span');
            const userName = userSpan.text().split('(')[0].trim();
            const deptName = userSpan.text().split('-')[1].split('/')[0].trim();
            const teamName = userSpan.text().split('/')[1].trim();
            console.log('choose userno:', userno); // 디버깅을 위한 로그
            console.log('choose userName:', name); // 디버깅을 위한 로그
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
                    '<button type="button" class="btn btn-danger btn-sm remove-user">x</button>' +
                    '</div>';
                
                $('#selectedUsers').append(selectedUserHtml);
                
                $this.closest('.search-result').addClass('selected');
            } else {
                // 사용자 선택 해제
                selectedUsers = selectedUsers.filter(user => user.userno !== userno);
                $('#selectedUsers').find(`.selected-user[data-userno="${userno}"]`).remove();
                $this.closest('.search-result').removeClass('selected');
            }
            
            /* if (selectedUsers.some(user => user.userno === userno)) {
                alert('이미 선택된 사용자입니다.');
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
                '<button type="button" class="btn btn-danger btn-sm remove-user">x</button>' +
                '</div>';
                
            $('#selectedUsers').append(selectedUserHtml);

            $(this).prop('disabled', true)
            	.closest('.search-result')
            	.addClass('selected'); */

        });

        // 사용자 제거
        $('#selectedUsers').on('click', '.remove-user', function() {
            const userno = $(this).closest('.selected-user').data('userno');
            selectedUsers = selectedUsers.filter(user => user.userno !== userno);
            $(this).closest('.selected-user').remove();
            
            // 검색 결과에서 해당 사용자의 체크박스 체크 해제 및 'selected' 클래스 제거
            $('#searchResults').find(`input[name="userSelect"][value="${userno}"]`)
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
    });

    
    function handleDateClick(info) {
        $('#addScheduleModal').modal('show');
        $('#addScheduleForm #scheduleStartDate').val(info.dateStr);
        $('#addScheduleForm #scheduleEndDate').val(info.dateStr); // 종료 날짜 일단 시작날짜
    } 

    function handleEditModal(event) {
//    	$('#eventTitle').text(event.scheduleid);
//    console.log('Event Data:', event); // 로그 추가
//    console.log('Extended Props:', event.extendedProps); // 로그 추가
    	$('#eventTitle').text(event.title);
        $('#eventStartDate').text(moment(event.start).format('YYYY-MM-DD'));
        $('#eventEndDate').text(event.extendedProps.realEndDate || moment(event.end).subtract(1, 'days').format('YYYY-MM-DD'));
//        $('#eventEndDate').text(event.end ? moment(event.end).format('YYYY-MM-DD') : '미설정');
        $('#eventContent').text(event.extendedProps.content);
        $('#eventShareto').text(event.extendedProps.customname);
        $('#eventCategory').text(event.extendedProps.category);
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
        
        /* if (!endDate) {
            endDate = startDate; // 종료 날짜가 비어있다면 시작 날짜로 설정
            endDateObj = new Date(startDate);
        } */
        
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
                calendar.refetchEvents();
                $('#addScheduleModal').modal('hide');
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

/*     function updateSchedule() {
     
        const title = $('#editEventForm #editEventTitle').val();
        const startDate = $('#editEventForm #editEventStartDate').val();
        let endDate = $('#editEventForm #editEventEndDate').val();
        const content = $('#editEventForm #editEventContent').val();
        const shareto = $('#editEventForm #editEventShareto').val();
        const scheduleid = $('#editEventId').val();
        let customShare = $('#customSharetoEdit').val() || null; 

        if (!title) {
            alert("제목을 입력해주세요.");
            return;
        }

        // 날짜 문자열을 Date 객체로 변환
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
            //data: JSON.stringify({ id: scheduleid, title, startDate, endDate, content, shareto }),
            data: JSON.stringify(eventData),
            success: function(response) {
                console.log('일정이 성공적으로 업데이트되었습니다.');
                calendar.refetchEvents();
                $('#editEventModal').modal('hide');
                location.reload(); // 페이지 새로고침
            },
            error: function(xhr, status, error) {
                console.error('일정 업데이트 중 오류가 발생했습니다:', error);
                alert('일정 업데이트 중 오류가 발생했습니다. 다시 시도해주세요.');
            }
        });
    } */
    
    function updateSchedule() {
        // event.preventDefault(); // 폼의 기본 제출 동작 방지

        const scheduleid = $('#editEventId').val();
        const title = $('#editEventTitle').val();
        const startDate = $('#editEventStartDate').val();
        let endDate = $('#editEventEndDate').val();
        const content = $('#editEventContent').val();
/*         const sharedepth1 = $('#editEventShareto').val();
        const sharedepth2 = $('#sharedepth2').val() || null; // sharedepth2 선택 요소 가정
        const sharedepth3 = $('#sharedepth3').val() || null; // sharedepth3 선택 요소 가정 */
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
                calendar.refetchEvents();
                $('#editEventModal').modal('hide');
                location.reload(); // 페이지 새로고침 대신 특정 부분만 업데이트하는 것이 좋습니다.
                // updateCalendarView(); // 캘린더 뷰 업데이트 함수 (별도 정의 필요)
            },
            error: function(xhr, status, error) {
                console.error('일정 업데이트 중 오류가 발생했습니다:', error);
                alert('일정 업데이트 중 오류가 발생했습니다. 다시 시도해주세요.');
            }
        });
    }

    // 폼 제출 이벤트 리스너
//    $('#editEventForm').on('submit', updateSchedule);

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


    function handleEventDrop(event) {
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
                console.log('일정이 성공적으로 업데이트되었습니다.');
                calendar.refetchEvents();
                // 필요에 따라 모달 숨기기 등의 추가 작업을 할 수 있습니다.
            },
            error: function(xhr, status, error) {
                console.error('일정 업데이트 중 오류가 발생했습니다:', error);
                alert('일정 업데이트 중 오류가 발생했습니다. 다시 시도해주세요.');
            }
        });
    }

    /* 

    function getCurrentDate() {
        const today = new Date();
        const year = today.getFullYear();
        const month = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
        const day = String(today.getDate()).padStart(2, '0');
        return `${year}-${month}-${day}`;
    }
     */
    
    

    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');

        $.ajax({
            url: "${pageContext.request.contextPath}/calendarData",
            method: "GET",
            dataType: "json"
        }).done(function (data) {
            console.log("Received data:", data);

            calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                locale: 'ko',
                timeZone: 'Asia/Seoul',  // 또는 'UTC', 'Asia/Seoul' 등
                headerToolbar: {
                    left: 'prev next today',
                    center: 'title',
                    right: 'shareGroup'//'dayGridMonth,timeGridWeek,timeGridDay'
                },
                customButtons: {
                	shareGroup: {
                        text: '설정',
                        click: function() {
                            $('#settingsModal').modal('show'); // 모달 창 열기
                            // 사용자 정의 동작을 여기에 정의합니다.
                        }
                    }
                },
                navLinks: false,
                editable: true,
                selectable: true,
                droppable: true,
                dayMaxEvents: true,
                contentHeight: 650,
                events: data.map(event => ({
                    ...event,
                    end: adjustEndDate(event.end), //new Date(event.end + 'T00:00:00'),  // 종료일 다음날로 설정
                    backgroundColor: event.extendedProps.sharecolor, // sharecolor를 backgroundColor로 설정
                    borderColor: event.extendedProps.sharecolor,  // 배경색과 같은 색으로 테두리 설정
                    shareCategory: event.extendedProps.category,  // 수정용 카테고리 추가
                    customname: event.extendedProps.customname,  // customname 가져오기
                    allDay: true  // 모든 이벤트를 종일 이벤트로 처리
                })),
                //events: data,
                eventClick: function(info) {
                	// 이벤트 클릭시 호출되는 함수
                    handleEditModal(info.event);
                },
                eventDrop: function(info) {
                    // 이벤트 드롭(이동) 시 호출되는 함수
                    handleEventDrop(info.event);
                },
                dateClick: function(info) {
                    handleDateClick(info);
                }
            });
            calendar.render();
        }).fail(function(jqXHR, textStatus, errorThrown) {
            console.error("AJAX request failed: " + textStatus, errorThrown);
        });
        
        
        $('#editEventButton').on('click', function() {
            var event = $(this).data('event');
            $('#editEventId').val(event.id);
            $('#editEventTitle').val(event.title);
            $('#editEventStartDate').val(moment(event.start).format('YYYY-MM-DD'));
		    $('#editEventEndDate').val($('#eventEndDate').text());  // 상세 모달에서 표시된 값 사용
            $('#editEventContent').val(event.extendedProps.content);
            $('#editEventShareto').val(event.extendedProps.shareCategory);
            /* $('#customSharetoEdit').val(event.extendedProps.customname); */
            console.log('ShareCategory set:', event.extendedProps.shareCategory);  // 설정된 값 로깅
            console.log('ShareCategory set:', event.extendedProps.customname);  // 설정된 값 로깅2

          	// 사용자 설정 공유 대상 처리
            if (event.extendedProps.shareCategory === '사용자 설정') {
                $('#customSharetoGroupEdit').show();
                console.log('Before setting customname:', $('#customSharetoEdit').val());
            } else {
                $('#customSharetoGroupEdit').hide();
            }
          
            $('#eventDetailModal').modal('hide');
            $('#editEventModal').modal('show');
        });

        $('#addScheduleForm').on('submit', function(e) {
            e.preventDefault();
            saveSchedule();
        });

        $('#editEventForm').on('submit', function(e) {
            e.preventDefault();
            updateSchedule();
        });
        

    });
    
    
</script>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

</body>


</html>
