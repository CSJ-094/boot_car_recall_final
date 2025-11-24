<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>온라인 상담 신청</title>
    <link rel="stylesheet" href="/css/main.css">
    <link rel="stylesheet" href="/css/header.css">
    <link rel="stylesheet" href="/css/footer.css">
	<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
	<script src="${pageContext.request.contextPath}/js/complain.js"></script>
	
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #fff;
            color: #333;
        }
        .container {
            width: 800px;
            margin: 50px auto;
            border: 1px solid #ddd;
            padding: 30px 40px;
            border-radius: 6px;
        }
        h2 {
            border-bottom: 2px solid #003366;
            padding-bottom: 10px;
            margin-bottom: 30px;
            font-size: 22px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        td {
            padding: 10px;
            vertical-align: middle;
        }
        .label {
            width: 150px;
            font-weight: bold;
            color: #333;
        }
        input[type="text"],
        input[type="password"],
        textarea,
        select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        textarea {
            height: 150px;
        }
        .btn {
            padding: 8px 14px;
            background-color: #003366;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #0055a5;
        }
        .radio-group input {
            margin-right: 5px;
        }
        .submit-box {
            text-align: center;
            margin-top: 30px;
        }
        .required {
            color: red;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/fragment/header.jsp"/>

    <div class="container">
        <h2>온라인 상담 신청</h2>
        <form action="complain_write" method="post" class="cmpl_frm">
            <table class="cmpl_tab">
                <tr>
                    <td class="label">신청인 <span class="required">※</span></td>
                    <td>
                        <input type="text" id="reporter_name" name="reporter_name" placeholder="이름을 입력하세요">
                    </td>
                </tr>
                <tr>
                    <td class="label">비밀번호 <span class="required">※</span></td>
                    <td><input type="password" id="password" name="password" placeholder="4글자 이상의 비밀번호를 입력"></td>
                </tr>
                <tr>
                    <td class="label">휴대폰번호 <span class="required">※</span></td>
                    <td>
						<input type="text" id="phone" name="phone"  placeholder="- 없이 입력하세요">
                    </td>
                </tr>
                <tr>
                    <td class="label">제목 <span class="required">※</span></td>
                    <td><input type="text" id="title" name="title" placeholder="제목을 입력하세요"></td>
                </tr>
                <tr>
                    <td class="label">상담구분</td>
                    <td class="radio-group">
                        <label><input type="radio" name="complain_type" value="제작결함" checked> 제작결함</label>
                        <label><input type="radio" name="complain_type" value="기타"> 기타</label>
                    </td>
                </tr>
                <tr>
                    <td class="label">자동차 등록번호</td>
                    <td><input type="text" name="carNum" placeholder="예: 서울00나0000, 00다0000"></td>
                </tr>
                <tr>
                    <td class="label">공개여부</td>
                    <td class="radio-group">
                        <label><input type="radio" name="is_public" value="Y" checked> 공개</label>
                        <label><input type="radio" name="is_public" value="N"> 비공개</label>
                    </td>
                </tr>
                <tr>
                    <td class="label">내용 <span class="required">※</span></td>
                    <td><textarea id="content" name="content" placeholder="상담 내용을 입력해주세요."></textarea></td>
                </tr>
            </table>

            <div class="submit-box">
                <button type="button" class="btn" onclick="check_ok()">등록</button>
                <button type="button" class="btn" onclick="history.back()">이전</button>
            </div>
        </form>
    </div>

    <jsp:include page="/WEB-INF/views/fragment/footer.jsp"/>
</body>
</html>
