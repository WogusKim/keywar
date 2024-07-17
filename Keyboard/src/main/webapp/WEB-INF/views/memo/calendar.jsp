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
        $('#addScheduleModal').modal('show');
        $('#addScheduleForm #scheduleStartDate').val(date.format('YYYY-MM-DD'));
    }

    function handleEditModal(schedule) {
        $('#editScheduleModal').modal('show');
        $('#editScheduleForm #editScheduleTitle').val(schedule.title);
        $('#editScheduleForm #editScheduleStartDate').val(schedule.StartDate.format('YYYY-MM-DD'));
        $('#editScheduleForm #editScheduleEndDate').val(schedule.endDate ? schedule.endDate.format('YYYY-MM-DD') : '');
    }

    function saveSchedule() {
        const title = $('#addScheduleForm #scheduleTitle').val();
        const startDate = $('#addScheduleForm #scheduleStartDate').val();
        const endDate = $('#addScheduleForm #scheduleEndDate').val();
        const content = $('#addScheduleForm #scheduleContent').val();
        const shareto = $('#addScheduleForm #scheduleShareto').val();

        // 서버에 일정 저장 요청을 보낼 수도 있음
        // $.post('/save-schedule', { title, startDate, endDate });
        // Ajax 요청
        $.ajax({
            url: '${pageContext.request.contextPath}/calendarsave', // 서버에 저장할 API 엔드포인트
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({ title, startDate, endDate, content, shareto }),
            success: function(response) {
                // 성공적으로 저장되었을 때의 처리
                console.log('일정이 성공적으로 저장되었습니다.');
                $('#calendar').fullCalendar('renderSchedule', {
                    title: title,
                    startDate: startDate,
                    endDate: endDate,
                    content: content,
                    shareto: shareto
                }, true); // stick? = true
                $('#addScheduleModal').modal('hide');
            },
            error: function(xhr, status, error) {
                // 에러 발생 시 처리
                console.error('일정 저장 중 오류가 발생했습니다:', error);
                alert('일정 저장 중 오류가 발생했습니다. 다시 시도해주세요.');
            }
        });
    }
    
    

    function updateSchedule() {
        const title = $('#editScheduleForm #editScheduleTitle').val();
        const startDate = $('#editScheduleForm #editScheduleStartDate').val();
        const endDate = $('#editScheduleForm #editScheduleEndDate').val();
        const content = $('#editScheduleForm #editScheduleContent').val();
        const shareto = $('#editScheduleForm #editScheduleShareto').val();

        // Ajax 요청
        $.ajax({
            url: '${pageContext.request.contextPath}/calendaredit', // 수정할 일정의 ID를 포함한 API 엔드포인트
            method: 'POST', // PUT 또는 POST 요청 사용
            contentType: 'application/json',
            data: JSON.stringify({ title, startDate, endDate, content, shareto }),
            success: function(response) {
                // 성공적으로 업데이트되었을 때의 처리
                console.log('일정이 성공적으로 업데이트되었습니다.');
                const schedule = $('#calendar').fullCalendar('clientSchedules', id)[0];
                schedule.title = title;
                schedule.startDate = startDate;
                schedule.endDate = endDate;
                schedule.content = content;
                schedule.shareto = shareto;
                $('#calendar').fullCalendar('updateSchedule', schedule);
                $('#editScheduleModal').modal('hide');
            },
            error: function(xhr, status, error) {
                // 에러 발생 시 처리
                console.error('일정 업데이트 중 오류가 발생했습니다:', error);
                alert('일정 업데이트 중 오류가 발생했습니다. 다시 시도해주세요.');
            }
        });
    }

    $(document).ready(function() {
        $.ajax({
            url: '${pageContext.request.contextPath}/calendar',
            method: 'GET',
            success: function(schedules) {
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
                    scheduleLimit: true,
                    schedules: schedules,
                    contentHeight: 650, // 달력 콘텐츠 높이 설정
                    scheduleClick: function(clickedSchedule) {
                        handleEditModal(clickedSchedule.schedule);
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
              <option value="부서">부점</option>
            </select>
          </div>
          
          <!-- 추가 필드들 -->
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" onclick="saveSchedule()">저장</button>
      </div>
    </div>
  </div>
</div>

<!-- 일정 수정 모달 -->
<div class="modal fade" id="editScheduleModal" tabindex="-1" role="dialog" aria-labelledby="editScheduleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="editScheduleModalLabel">일정 수정</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <!-- 일정 수정 폼 -->
        <form id="editScheduleForm">
          <div class="form-group">
            <label for="editScheduleTitle">제목</label>
            <input type="text" class="form-control" id="editScheduleTitle" name="title">
          </div>
          <div class="form-group">
            <label for="editScheduleStartDate">시작 날짜</label>
            <input type="date" class="form-control" id="editScheduleStartDate" name="startDate">
          </div>
          <div class="form-group">
            <label for="editScheduleEndDate">종료 날짜</label>
            <input type="date" class="form-control" id="editScheduleEndDate" name="endDate">
          </div>
          <div class="form-group">
            <label for="editScheduleContent">내용</label>
            <input type="text" class="form-control" id="editScheduleContent" name="content">
          </div>
          <div class="form-group">
            <label for="editScheduleShareto">공유 대상</label>
            <select class="form-control" id="editScheduleShareto" name="shareto">
              <option value="개인">개인</option>
              <option value="팀">팀</option>
              <option value="부서">부점</option>
            </select>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" onclick="updateSchedule()">저장</button>
      </div>
    </div>
  </div>
</div>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

</body>
</html>