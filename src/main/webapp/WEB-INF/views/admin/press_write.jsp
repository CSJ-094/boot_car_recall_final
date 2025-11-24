<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <head>
        <meta charset="UTF-8">
        <title>리콜 보도자료 작성</title>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" />
        <script src="${pageContext.request.contextPath}/js/jquery.js"></script>

        <style>
            body {
                font-family: "Noto Sans KR", sans-serif;
                margin: 0;
                background-color: #f8f9fa;
            }

            .container {
                width: 80%;
                margin: 40px auto;
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                padding: 40px 50px;
            }

            h2 {
                text-align: center;
                font-size: 26px;
                margin-bottom: 30px;
                color: #333;
            }

            form {
                display: flex;
                flex-direction: column;
                gap: 20px;
            }

            label {
                font-weight: 600;
                color: #444;
                margin-bottom: 5px;
            }

            input[type="text"], textarea {
                width: 100%;
                padding: 10px 12px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 15px;
                resize: none;
                box-sizing: border-box;
            }

            textarea {
                min-height: 300px;
            }

            input[type="file"] {
                margin-top: 5px;
            }

            .uploadResult {
                margin-top: 10px;
            }

            .uploadResult ul {
                list-style: none;
                padding: 0;
            }

            .uploadResult li {
                margin: 6px 0;
                font-size: 14px;
                color: #007bff;
            }

            .btn-area {
                display: flex;
                justify-content: center;
                gap: 15px;
                margin-top: 30px;
            }

            .btn-area button, .btn-area a {
                background-color: #007bff;
                color: white;
                padding: 10px 25px;
                border: none;
                border-radius: 6px;
                font-size: 15px;
                text-decoration: none;
                cursor: pointer;
                transition: background-color 0.2s ease;
            }

            .btn-area button:hover, .btn-area a:hover {
                background-color: #0056b3;
            }

            hr {
                border: none;
                border-top: 1px solid #ddd;
                margin: 20px 0;
            }
        </style>
    </head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/fragment/adminheader.jsp"/>

<div class="container">
    <h2>리콜 보도자료 작성</h2>
    <hr>

    <form id="frm">
        <div>
            <label for="boardTitle">제목</label>
            <input type="text" id="boardTitle" name="boardTitle" placeholder="제목을 입력하세요" required>
        </div>

        <div>
            <label for="boardName">작성자</label>
            <input type="text" id="boardName" name="boardName" placeholder="작성자명을 입력하세요" required>
        </div>

        <div>
            <label for="boardContent">내용</label>
            <textarea id="boardContent" name="boardContent" placeholder="내용을 입력하세요" required></textarea>
        </div>

        <div>
            <label for="uploadFile">첨부 파일</label>
            <input type="file" name="uploadFile" id="uploadFile" multiple>
        </div>

        <div class="uploadResult">
            <ul></ul>
        </div>

        <div class="btn-area">
            <button type="submit">등록</button>
            <button type="button" onclick="location.href='/admin/press/list'">목록으로</button>
        </div>
    </form>
</div>


<script>
    $(document).ready(function() {

        const regex = new RegExp("(.*?)\.(exe|sh|js|alz)$");
        const maxSize = 5242880; // 5MB

        function checkExtension(fileName, fileSize) {
            if (fileSize > maxSize) {
                alert("파일 사이즈 초과 (5MB 이하만 가능)");
                return false;
            }
            if (regex.test(fileName)) {
                alert("해당 종류의 파일은 업로드할 수 없습니다.");
                return false;
            }
            return true;
        }

        $("input[type='file']").change(function(e) {
            const uploadUL = $(".uploadResult ul");
            uploadUL.empty();

            const formData = new FormData();
            const files = this.files;

            for (let i = 0; i < files.length; i++) {
                if (!checkExtension(files[i].name, files[i].size)) return false;
                formData.append("uploadFile", files[i]);
            }

            $.ajax({
                type: "post",
                url: "/uploadAjaxAction",
                data: formData,
                processData: false,
                contentType: false,
                success: function(result) {
                    showUploadResult(result);
                }
            });
        });

        function showUploadResult(uploadResultArr) {
            if (!uploadResultArr || uploadResultArr.length === 0) return;
            const uploadUL = $(".uploadResult ul");
            let str = "";

            $(uploadResultArr).each(function(i, obj) {
                const fileName = obj.fileName;
                if (obj.image) {
                    str += "<li>" +
                        "<img src='/display?fileName=" + obj.uuid + "_" + fileName + "' width='80'>" +
                        "<span>" + fileName + "</span></li>";
                } else {
                    str += "<li>" +
                        "<img src='${pageContext.request.contextPath}/img/attach.png' width='20'>" +
                        "<span>" + fileName + "</span></li>";
                }
            });
            uploadUL.append(str);
        }

        $("button[type='submit']").on("click", function(e) {
            e.preventDefault();

            const formData = $("#frm").serialize();

            $.ajax({
                type: "post",
                url: "/admin/press/write",
                data: formData,
                success: function(result) {
                    // ✅ 서버로부터 새로 생성된 게시글의 boardNo를 받아옴 (서버 응답이 boardNo라고 가정)
                    const boardNo = result; 
                    const files = $("input[name='uploadFile']")[0].files;
                    if (files.length > 0) { // 파일이 있을 때만 업로드 함수 호출
                        uploadFolder(boardNo);
                    } else {
                        alert("게시글이 성공적으로 등록되었습니다.");
                        location.href = "/admin/press/list";
                    }
                },
                error: function() {
                    alert("게시글 저장 실패");
                }
            });
        });

        function uploadFolder(boardNo) {
            const formData = new FormData();
            const inputFile = $("input[name='uploadFile']");
            const files = inputFile[0].files;

            // FormData에 파일과 boardNo를 함께 추가
            formData.append("boardNo", boardNo);
            for (let i = 0; i < files.length; i++) { 
                formData.append("uploadFile", files[i]);
            }

            $.ajax({
                type: "post",
                url: "/uploadFolder",
                data: formData,
                processData: false,
                contentType: false,
                success: function(result) {
                    alert("게시글과 파일이 성공적으로 등록되었습니다.");
                    location.href = "/admin/press/list";
                },
                error: function() {
                    alert("파일 업로드 실패");
                }
            });
        }
    });
</script>
</body>
</html>