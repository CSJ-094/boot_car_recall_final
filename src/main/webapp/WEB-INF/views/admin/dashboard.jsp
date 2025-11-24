<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>관리자 대시보드</title>
    <link rel="stylesheet" href="/css/main.css" />
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
        .admin-dashboard-container { max-width: 1200px; margin: 20px auto; padding: 20px; background-color: #fff; border-radius: 8px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); }
        h1 { color: #333; text-align: center; margin-bottom: 30px; }
        .dashboard-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; }
        .dashboard-card { background-color: #e9ecef; padding: 20px; border-radius: 8px; text-align: center; box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08); }
        .dashboard-card h2 { color: #0056b3; margin-bottom: 10px; }
        .dashboard-card p { color: #555; font-size: 1.1em; }
        .dashboard-card a { display: inline-block; margin-top: 15px; padding: 10px 15px; background-color: #007bff; color: #fff; text-decoration: none; border-radius: 5px; transition: background-color 0.3s ease; }
        .dashboard-card a:hover { background-color: #0056b3; }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/fragment/header.jsp"/>

    <main class="admin-dashboard-container">
        <h1>관리자 대시보드</h1>
        <p>관리자님, 환영합니다!</p>

        <div class="dashboard-grid">
            <div class="dashboard-card">
                <h2>사용자 관리</h2>
                <p>회원 정보 조회 및 관리</p>
                <a href="#">바로가기</a>
            </div>
            <div class="dashboard-card">
                <h2>리콜 정보 관리</h2>
                <p>리콜 데이터 추가, 수정, 삭제</p>
                <a href="#">바로가기</a>
            </div>
            <div class="dashboard-card">
                <h2>게시판 관리</h2>
                <p>공지사항, FAQ, 게시글 관리</p>
                <a href="#">바로가기</a>
            </div>
            <div class="dashboard-card">
                <h2>결함 신고 관리</h2>
                <p>사용자 결함 신고 검토 및 처리</p>
                <a href="#">바로가기</a>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/fragment/footer.jsp"/>
</body>
</html>
