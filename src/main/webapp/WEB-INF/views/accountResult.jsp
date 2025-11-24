<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>요청 처리 결과 - 자동차 리콜 통합센터</title>
    <link rel="stylesheet" href="/css/main.css" />
    <link rel="stylesheet" href="/css/login.css" />
</head>
<body>
    <jsp:include page="/WEB-INF/views/fragment/header.jsp"/>

    <main class="login-container">
        <div class="login-card">
            <h1 class="login-title">요청 처리 완료</h1>
            <p class="result-message">${message}</p>
            <a href="/login" class="login-btn" style="text-decoration: none; display: block; margin-top: 1.5rem;">로그인으로 돌아가기</a>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/fragment/footer.jsp"/>
    <style>
        .result-message {
            font-size: 1.1rem;
            color: #333;
            line-height: 1.6;
            margin-bottom: 2rem;
        }
    </style>
</body>
</html>