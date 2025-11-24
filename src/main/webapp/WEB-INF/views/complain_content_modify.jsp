<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>신청인 정보</title>

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
            display: flex;
            flex-direction: column;
        }

        /* 메인 컨텐츠 래퍼 */
        #content-wrap {
            flex: 1; /* footer 밀어내기 */
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 0;
        }

        .container {
            width: 800px;
            background: #fff;
            border: 1px solid #d9d9d9;
            border-radius: 6px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
            padding: 30px;
        }

        h2 {
            color: #0066cc;
            font-size: 20px;
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
            border: 1px solid #ddd;
            padding: 12px 15px;
            text-align: left;
            font-size: 14px;
        }

        th {
            width: 20%;
            background-color: #f2f5f8;
            font-weight: bold;
            color: #333;
        }

        td {
            background-color: #fff;
            color: #555;
        }

        .question-box {
            background: #f9f9f9;
            border: 1px solid #ddd;
            padding: 20px;
            line-height: 1.6;
            font-size: 14px;
            color: #444;
            border-radius: 5px;
        }

        .btn-box {
            text-align: center;
            margin-top: 25px;
        }

        .btn {
            display: inline-block;
            background-color: #0066cc;
            color: #fff;
            padding: 10px 25px;
            border-radius: 4px;
            text-decoration: none;
            margin: 0 5px;
            transition: 0.2s;
        }

        .btn:hover {
            background-color: #004c99;
        }

        .btn.gray {
            background-color: #666;
        }

        .btn.gray:hover {
            background-color: #444;
        }
    </style>
</head>

<body>
    <jsp:include page="/WEB-INF/views/fragment/header.jsp" />

    <div id="content-wrap">
        <div class="container">
            <h2>신청인 정보</h2>

            <c:forEach var="m" items="${m_param}">
                <form action="complain_modify" method="post">
					<input type="hidden" name="report_id" value="${m.report_id}" />
                    <table>
                        <tr>
                            <th>신청인</th>
                            <td>${m.reporter_name}</td>
                        </tr>
                        <tr>
                            <th>제목</th>
                            <td>
                                <input type="text" name="title" value="${m.title}" />
                            </td>
                        </tr>
                        <tr>
                            <th>상담구분</th>
                            <td>
								<input type="radio" name="complain_type" value="제작결함"
								   <c:if test="${m.complain_type eq '제작결함'}">checked</c:if> /> 제작결함
								<input type="radio" name="complain_type" value="기타"
								   <c:if test="${m.complain_type eq '기타'}">checked</c:if> /> 기타
                            </td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td>
                                <div>
                                    <input type="text" name="content" value="${m.content}" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>문의날짜</th>
                            <td>${m.complainDate}</td>
                        </tr>
                    </table>

                    <div class="btn-box">
                        <input class="btn" type="submit" value="수정하기" />
                        <a href="complain_list" class="btn gray">목록</a>
                    </div>
                </form>
            </c:forEach>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/fragment/footer.jsp" />
</body>
</html>
