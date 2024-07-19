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
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">저장</button>
                    <!-- <button type="button" class="btn btn-primary" onclick="updateSchedule()">저장</button> -->
                    
                </form>
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

    function getCurrentDate() {
        const today = new Date();
        const year = today.getFullYear();
        const month = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
        const day = String(today.getDate()).padStart(2, '0');
        return `${year}-${month}-${day}`;
    }

    function handleDateClick(info) {
        $('#addScheduleModal').modal('show');
        $('#addScheduleForm #scheduleStartDate').val(info.dateStr);
        $('#addScheduleForm #scheduleEndDate').val(getCurrentDate()); // 종료 날짜 자동 설정
    }

    function handleEditModal(event) {
//    	$('#eventTitle').text(event.scheduleid);
    	$('#eventTitle').text(event.title);
        $('#eventStartDate').text(moment(event.start).format('YYYY-MM-DD'));
        $('#eventEndDate').text(event.extendedProps.realEndDate || moment(event.end).subtract(1, 'days').format('YYYY-MM-DD'));
//        $('#eventEndDate').text(event.end ? moment(event.end).format('YYYY-MM-DD') : '미설정');
        $('#eventContent').text(event.extendedProps.content);
        $('#eventShareto').text(event.extendedProps.shareto);
        $('#editEventButton').data('event', event);
        $('#eventDetailModal').modal('show');
    }

    function saveSchedule() {
        const title = $('#addScheduleForm #scheduleTitle').val();
        const startDate = $('#addScheduleForm #scheduleStartDate').val();
        let endDate = $('#addScheduleForm #scheduleEndDate').val();
        const content = $('#addScheduleForm #scheduleContent').val();
        const shareto = $('#addScheduleForm #scheduleShareto').val();

        if (!title) {
            alert("제목을 입력해주세요.");
            return;
        }
        
        // 날짜 문자열을 Date 객체로 변환
        const startDateObj = new Date(startDate);
        const endDateObj = new Date(endDate);
        
        if (!endDate) {
            endDate = startDate; // 종료 날짜가 비어있다면 시작 날짜로 설정
            endDateObj = new Date(startDate);
        }
        
        if (startDateObj > endDateObj) {
            alert("종료일자는 시작일자보다 이전 일자로 등록할 수 없습니다.");
            return;
        }
        
        // FullCalendar 표시용 종료일 (다음날)
        const displayEndDate = new Date(endDateObj);
        displayEndDate.setDate(displayEndDate.getDate() + 1);
        
        $.ajax({
            url: '${pageContext.request.contextPath}/calendarsave',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({ title, startDate, endDate, content, shareto }),
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
                        realEndDate: endDate  // 실제 종료일 저장
                    }
                });
                calendar.refetchEvents();
                $('#addScheduleModal').modal('hide');
                location.reload(); // 페이지 새로고침
            },
            error: function(xhr, status, error) {
                console.error('일정 저장 중 오류가 발생했습니다:', error);
                alert('일정 저장 중 오류가 발생했습니다. 다시 시도해주세요.');
            }
        });
    }

    function updateSchedule() {
        const title = $('#editEventForm #editEventTitle').val();
        const startDate = $('#editEventForm #editEventStartDate').val();
        const endDate = $('#editEventForm #editEventEndDate').val();
        const content = $('#editEventForm #editEventContent').val();
        const shareto = $('#editEventForm #editEventShareto').val();
        const scheduleid = $('#editEventId').val();

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

        const eventData = { scheduleid: scheduleid, title, startDate, endDate, content, shareto };

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
    }

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
                timeZone: 'local',  // 또는 'UTC', 'Asia/Seoul' 등
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay'
                },
                navLinks: true,
                editable: true,
                selectable: true,
                droppable: true,
                dayMaxEvents: true,
                contentHeight: 650,
                events: data.map(event => ({
                    ...event,
                    end: new Date(event.end + 'T00:00:00'),  // 종료일 다음날로 설정
                    allDay: true  // 모든 이벤트를 종일 이벤트로 처리
                })),
                //events: data,
                eventClick: function(info) {
                    handleEditModal(info.event);
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
            $('#editEventEndDate').val(event.end ? moment(event.end).format('YYYY-MM-DD') : getCurrentDate());
            $('#editEventContent').val(event.extendedProps.content);
            $('#editEventShareto').val(event.extendedProps.shareto);
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
