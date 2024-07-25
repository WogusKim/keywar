<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/main.css">
<style>
	#editorjs {
		border: 1px solid #ccc;
		padding: 10px;
		min-height: 200px; /* 기본적인 높이 설정 */
	}
</style>
<!-- Editor.js 및 플러그인 CDN 포함 -->
<script src="https://cdn.jsdelivr.net/npm/@editorjs/editorjs@latest"></script>
<script src="https://cdn.jsdelivr.net/npm/@editorjs/header@latest"></script>
<script src="https://cdn.jsdelivr.net/npm/@editorjs/list@latest"></script>
<script src="https://cdn.jsdelivr.net/npm/@editorjs/marker@latest"></script>
<script src="https://cdn.jsdelivr.net/npm/@editorjs/embed@latest"></script>
<script src="https://cdn.jsdelivr.net/npm/@editorjs/table@latest"></script>
<script src="https://cdn.jsdelivr.net/npm/@editorjs/image@latest"></script>
<script src="https://cdn.jsdelivr.net/npm/@editorjs/quote@latest"></script>
<script src="https://cdn.jsdelivr.net/npm/@editorjs/code@latest"></script>
<script src="https://cdn.jsdelivr.net/npm/@editorjs/checklist@latest"></script>
<script src="https://cdn.jsdelivr.net/npm/@editorjs/inline-code@latest"></script>
<script src="https://cdn.jsdelivr.net/npm/@editorjs/underline@latest"></script>
<script src="https://cdn.jsdelivr.net/npm/@editorjs/link@latest"></script>
<script src="https://cdn.jsdelivr.net/npm/@editorjs/delimiter@latest"></script>
<script src="https://cdn.jsdelivr.net/npm/@editorjs/warning@latest"></script>
<script src="https://cdn.jsdelivr.net/npm/@editorjs/attaches@latest"></script>
<script src="https://cdn.jsdelivr.net/npm/editorjs-alert@latest"></script>
<script src="https://cdn.jsdelivr.net/npm/@calumk/editorjs-codeflask@latest"></script>
</head>
<body>

	<%@ include file="/WEB-INF/views/header.jsp"%>

	<div class="content_outline">
		<%@ include file="/WEB-INF/views/sidebar.jsp"%>
		<div class="content_right">
			<!-- 여기까지 기본세팅(흰 배경) -->

			<div id="editorjs"></div>
			<button id="saveButton">Save</button>

		</div>
	</div>

	<script>
		document.addEventListener('DOMContentLoaded', function() {
			const editor = new EditorJS({
				holder: 'editorjs',
				tools: {
					header: {
						class: Header,
						inlineToolbar: ['link']
					},
					linkTool: LinkTool,
					raw: RawTool,
					simpleImage: SimpleImage,
					image: ImageTool,
					checklist: {
						class: Checklist,
						inlineToolbar: true
					},
					list: {
						class: List,
						inlineToolbar: true
					},
					embed: Embed,
					quote: Quote,
					table: Table,
					delimiter: Delimiter,
					warning: Warning,
					code: CodeTool,
					attaches: AttachesTool,
					marker: Marker,
					inlineCode: InlineCode,
					underline: Underline,
					alert: Alert,
					codeflask: CodeFlask
				},
				autofocus: true // 자동으로 커서를 에디터에 위치시킵니다.
			});

			document.getElementById('saveButton').addEventListener('click', () => {
				editor.save().then((outputData) => {
					console.log('Article data: ', outputData);

					fetch('${pageContext.request.contextPath}/saveEditorData', {
						method: 'POST',
						headers: {
							'Content-Type': 'application/json',
						},
						body: JSON.stringify(outputData),
					})
					.then(response => response.json())
					.then(data => {
						console.log('Success:', data);
					})
					.catch((error) => {
						console.error('Error:', error);
					});
				}).catch((error) => {
					console.log('Saving failed: ', error);
				});
			});
		});
	</script>
</body>
</html>
