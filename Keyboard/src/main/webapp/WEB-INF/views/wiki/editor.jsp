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
    <link href="https://cdn.jsdelivr.net/npm/@editorjs/editorjs@latest/dist/editorjs.min.css" rel="stylesheet">
</head>
<body>

    <%@ include file="/WEB-INF/views/header.jsp"%>

    <div class="content_outline">
        <%@ include file="/WEB-INF/views/sidebar.jsp"%>
        <div class="content_right">
            <!-- 여기까지 기본세팅(흰 배경) -->

            <div id="editorjs" style="border: 1px solid #ccc; padding: 10px;"></div>
            <button id="saveButton">Save</button>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@editorjs/editorjs@latest"></script>
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/header@latest"></script>
    <script src="https://cdn.jsdelivr.net/npm/@editorjs/list@latest"></script>

    <script>
        const editor = new EditorJS({
            holder: 'editorjs',
            tools: {
                header: Header,
                list: List
            }
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
    </script>
</body>
</html>