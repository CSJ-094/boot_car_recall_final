<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>데이터 로드 결과</title>
    <style>
        body { font-family: sans-serif; text-align: center; margin-top: 50px; }
        .message { font-size: 1.2em; }
        .link { margin-top: 20px; }
    </style>
</head>
<body>
    <h1>데이터 로드 결과</h1>
    <p class="message">${message}</p>
    <div class="link">
        <a href="/recall-status">리콜 현황 보러가기</a>
    </div>
</body>
</html>
