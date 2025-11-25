<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>리콜 상세 정보 - 자동차 리콜 통합센터</title>
    <link rel="stylesheet" href="/css/main.css" />
    <style>
        .recall-detail-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 30px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }
        .recall-detail-container h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
            font-size: 2rem;
            border-bottom: 2px solid #007bff;
            padding-bottom: 15px;
        }
        .detail-item {
            display: flex;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px dashed #eee;
        }
        .detail-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }
        .detail-label {
            font-weight: bold;
            color: #555;
            width: 120px;
            flex-shrink: 0;
        }
        .detail-content {
            color: #333;
            flex-grow: 1;
        }
        .detail-content.reason {
            white-space: pre-wrap; /* 줄바꿈 유지 */
        }
        .back-button-container {
            text-align: center;
            margin-top: 40px;
        }
        .back-button {
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 1rem;
            transition: background-color 0.2s;
        }
        .back-button:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/fragment/header.jsp"/>

    <main class="container">
        <div class="recall-detail-container">
            <h1>리콜 상세 정보</h1>

            <c:if test="${empty recall}">
                <p class="no-results" style="text-align: center;">해당 리콜 정보를 찾을 수 없습니다.</p>
            </c:if>
            <c:if test="${not empty recall}">
                <div class="detail-item">
                    <span class="detail-label">리콜 ID:</span>
                    <span class="detail-content">${recall.id}</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">제조사:</span>
                    <span class="detail-content">${recall.maker}</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">모델명:</span>
                    <span class="detail-content">${recall.modelName}</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">생산 기간:</span>
                    <span class="detail-content">${recall.makeStart} ~ ${recall.makeEnd}</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">리콜 날짜:</span>
                    <span class="detail-content">${recall.recallDate}</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">VIN:</span>
                    <span class="detail-content">${recall.vin}</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">등록번호:</span>
                    <span class="detail-content">${recall.registrationNumber}</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">리콜 사유:</span>
                    <span class="detail-content reason">${recall.recallReason}</span>
                </div>
            </c:if>

            <div class="back-button-container">
                <a href="/recall-status" class="back-button">목록으로 돌아가기</a>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/fragment/footer.jsp"/>
</body>
</html>
