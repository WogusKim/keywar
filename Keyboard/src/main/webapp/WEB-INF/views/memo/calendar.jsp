<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캘린더 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<!-- 달력 관련 삽입 -->
<link href='https://fullcalendar.io/releases/fullcalendar/3.9.0/fullcalendar.min.css' rel='stylesheet' />
<script src='https://fullcalendar.io/releases/fullcalendar/3.9.0/lib/jquery.min.js'></script>
<script src='https://fullcalendar.io/releases/fullcalendar/3.9.0/lib/moment.min.js'></script>
<script src='https://fullcalendar.io/releases/fullcalendar/3.9.0/fullcalendar.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/locale/ko.min.js'></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/calendar.css">
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">

<script>
    function handleDateClick(date) {
        $('#addEventModal').modal('show');
        $('#addEventForm #eventStartDate').val(date.format('YYYY-MM-DD'));
    }

    function handleEditModal(event) {
        $('#editEventModal').modal('show');
        $('#editEventForm #editEventTitle').val(event.title);
        $('#editEventForm #editEventStartDate').val(event.StartDate.format('YYYY-MM-DD'));
        $('#editEventForm #editEventEndDate').val(event.endDate ? event.endDate.format('YYYY-MM-DD') : '');
    }

    function saveEvent() {
        const title = $('#addEventForm #eventTitle').val();
        const startDate = $('#addEventForm #eventStartDate').val();
        const endDate = $('#addEventForm #eventEndDate').val();
        const content = $('#addEventForm #eventContent').val();
        const shareto = $('#addEventForm #eventShareto').val();

        // 서버에 이벤트 저장 요청을 보낼 수도 있음
        // $.post('/save-event', { title, startDate, endDate });
        
        const eventData = {
	        title: title,
	        startDate: startDate,
	        endDate: endDate,
	        content: content,
	        shareto: shareto
    	};
        
        

        $('#calendar').fullCalendar('renderEvent', {
            title: title,
            startDate: startDate,
            endDate: endDate
        }, true); // stick? = true

        $('#addEventModal').modal('hide');
    }

    function updateEvent() {
        const id = $('#editEventForm #editEventId').val();
        const title = $('#editEventForm #editEventTitle').val();
        const startDate = $('#editEventForm #editEventStartDate').val();
        const endDate = $('#editEventForm #editEventEndDate').val();

        // 서버에 이벤트 수정 요청을 보낼 수도 있음
        // $.post('/update-event', { id, title, startDate, endDate });

        // FullCalendar에서 이벤트 업데이트
        const event = $('#calendar').fullCalendar('clientEvents', id)[0];
        event.title = title;
        event.startDate = startDate;
        event.endDate = endDate;
        $('#calendar').fullCalendar('updateEvent', event);

        $('#editEventModal').modal('hide');
    }

    $(document).ready(function() {
        $.ajax({
            url: '${pageContext.request.contextPath}/calendar',
            method: 'GET',
            success: function(events) {
                $('#calendar').fullCalendar({
                    locale: 'ko', // 한국어 설정
                    header: {
                        left: 'prev,next today',
                        center: 'title',
                        right: 'month,agendaWeek,agendaDay'
                    },
                    defaultView: 'month', 
                    defaultDate: moment(),
                    navLinks: true,
                    editable: true,
                    eventLimit: true,
                    events: events,
                    contentHeight: 650, // 달력 콘텐츠 높이 설정
                    eventClick: function(clickedEvent) {
                        handleEditModal(clickedEvent.event);
                    },
                    dayClick: function(date) {
                        handleDateClick(date);
                    }
                });
            }
        });
    });
</script>
</head>
<body>

<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="content_outline">
    <%@ include file="/WEB-INF/views/sidebar.jsp" %>
    <div class="content_right">
        <div id='calendar'></div>
    </div> 
</div>

<!-- 일정 추가 모달 -->
<div class="modal fade" id="addEventModal" tabindex="-1" role="dialog" aria-labelledby="addEventModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="addEventModalLabel">일정 추가</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <!-- 일정 추가 폼 -->
        <form id="addEventForm">
          <div class="form-group">
            <label for="eventTitle">제목</label>
            <input type="text" class="form-control" id="eventTitle" name="title">
          </div>
          <div class="form-group">
            <label for="eventStartDate">시작 날짜</label>
            <input type="date" class="form-control" id="eventStartDate" name="startDate">
          </div>
          <div class="form-group">
            <label for="eventEndDate">종료 날짜</label>
            <input type="date" class="form-control" id="eventEndDate" name="endDate">
          </div>
          <div class="form-group">
            <label for="eventContent">내용</label>
            <input type="text" class="form-control" id="eventContent" name="content">
          </div>
          <div class="form-group">
            <label for="eventShareto">공유 대상</label>
            <select class="form-control" id="eventShareto" name="shareto">
              <option value="개인">개인</option>
              <option value="팀">팀</option>
              <option value="부서">부점</option>
            </select>
          </div>
          
          <!-- 추가 필드들 -->
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" onclick="saveEvent()">저장</button>
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
        <!-- 일정 수정 폼 -->
        <form id="editEventForm">
          <div class="form-group">
            <label for="editEventTitle">제목</label>
            <input type="text" class="form-control" id="editEventTitle" name="title">
          </div>
          <div class="form-group">
            <label for="editEventStartDate">시작 날짜</label>
            <input type="date" class="form-control" id="editEventStartDate" name="startDate">
          </div>
          <div class="form-group">
            <label for="editEventEndDate">종료 날짜</label>
            <input type="date" class="form-control" id="editEventEndDate" name="endDate">
          </div>
          <div class="form-group">
            <label for="editEventContent">내용</label>
            <input type="text" class="form-control" id="editEventContent" name="content">
          </div>
          <div class="form-group">
            <label for="editEventShareto">공유 대상</label>
            <select class="form-control" id="editEventShareto" name="shareto">
              <option value="개인">개인</option>
              <option value="팀">팀</option>
              <option value="부서">부점</option>
            </select>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" onclick="updateEvent()">저장</button>
      </div>
    </div>
  </div>
</div>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

</body>
</html>