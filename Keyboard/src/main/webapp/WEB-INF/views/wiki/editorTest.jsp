<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메인 페이지</title>
    <!-- Style and Script includes -->
</head>
<body>
    <!-- Body Content -->
    <div id="myEditor"></div>
    <button onclick="saveData()">저장하기</button>
    <button onclick="loadData()">내용 불러오기</button>

    <script>
        var editor;

        document.addEventListener('DOMContentLoaded', function () {
            editor = new EditorJS({
                holder: 'myEditor',
                tools: {
                    // Define tools here
                }
            });
        });

        function saveData() {
            editor.save().then((outputData) => {
                fetch('/saveEditorData', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(outputData)
                }).then(response => {
                    return response.text();
                }).then(data => {
                    alert(data);
                });
            });
        }

        function loadData() {
            fetch('/loadEditorData?id=1')  // Assuming you want to load data for id=1
            .then(response => response.json())
            .then(data => {
                editor.render(data);
            });
        }
    </script>
</body>
</html>
