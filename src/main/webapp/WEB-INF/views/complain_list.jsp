<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>신청 내역 게시판</title>

    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">

    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            font-family: "맑은 고딕", sans-serif;
            background-color: #f7f9fb;
        }

        /* 화면 전체 중앙 정렬용 래퍼 */
        .page-wrapper {
            min-height: 100vh; /* 화면 높이 100% 채움 */
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding-top: 80px; /* 위 여백 */
            box-sizing: border-box;
        }

        .board-container {
            width: 80%;
            max-width: 1000px;
            background: #fff;
            border: 1px solid #d9d9d9;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            padding: 30px;
        }

        h2 {
            color: #0066cc;
            font-size: 22px;
            border-left: 5px solid #0066cc;
            padding-left: 10px;
            margin-bottom: 25px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            border-bottom: 1px solid #e5e5e5;
            text-align: center;
            padding: 12px 10px;
            font-size: 14px;
            color: #333;
        }

        th {
            background-color: #f2f5f8;
            font-weight: bold;
        }

        td a {
            text-decoration: none;
            color: #0066cc;
        }

        td a:hover {
            text-decoration: underline;
        }

        .btn-box {
            text-align: right;
            margin-top: 10px;
        }

        .btn {
            display: inline-block;
            background-color: #0066cc;
            color: #fff;
            padding: 8px 20px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
            transition: background 0.2s;
        }

        .btn:hover {
            background-color: #004c99;
        }

        .no-data {
            text-align: center;
            color: #777;
            padding: 40px 0;
        }
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/fragment/header.jsp"/>
    <div class="page-wrapper">
        <div class="board-container">
            <h2>신청 내역</h2>

            <table>
                <thead>
                    <tr>
                        <th>no.</th>
                        <th>제목</th>
                        <th>상담구분</th>
                        <th>신청인</th>
                        <th>문의날짜</th>
                        <th>답변상태</th>
                    </tr>
                </thead>

                <tbody>
                    <c:choose>
                        <c:when test="${not empty list}">
                            <c:forEach var="dto" items="${list}">
                                <tr>
                                    <td>${dto.report_id}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/complain_content_view?report_id=${dto.report_id}">
                                            <c:choose>
                                                <c:when test="${dto.is_public == 'N'}">
                                                    <span class="lock-icon">🔒</span> 비공개 글입니다.
                                                </c:when>
                                                <c:otherwise>
                                                    ${dto.title}
                                                </c:otherwise>
                                            </c:choose>
                                        </a>
                                    </td>
                                    <td>${dto.complain_type}</td>
                                    <td>${dto.reporter_name}</td>
                                    <td>${dto.complainDate}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty dto.answer}">
                                                <span class="badge badge-success">답변 완료</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-warning">답변 대기</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>

                        <c:otherwise>
                            <tr>
                                <td colspan="6" class="no-data">등록된 신청 내역이 없습니다.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

            <div class="btn-box">
                <a href="${pageContext.request.contextPath}/complain_write_view" class="btn">글작성</a>
            </div>
        </div>
    </div>
	<jsp:include page="/WEB-INF/views/fragment/footer.jsp"/>
</body>
</html>
