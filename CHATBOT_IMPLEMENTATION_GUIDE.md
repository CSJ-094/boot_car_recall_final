# 웹사이트 통합 챗봇 구현 가이드

## 📋 개요

고객이 로그인 없이 웹사이트에서 직접 사용할 수 있는 AI 챗봇 시스템을 구현했습니다. 초기에는 GPT와 자동 응답을 제공하고, 상담사 연결 버튼으로 실시간 상담 모드로 전환됩니다.

---

## 🏗️ 시스템 아키텍처

### 고객 측 (로그인 불필요)
1. **고객 세션**: UUID 자동 생성으로 각 고객 식별
2. **WebSocket 연결**: `/ws/consultation` 엔드포인트로 실시간 연결
3. **이중 모드**:
   - **GPT 모드**: REST API (`/api/chat`)로 자동 응답
   - **상담사 모드**: WebSocket으로 실시간 메시지 교환

### 상담사 측 (관리자 계정, 8484 포트)
1. **대시보드**: `/admin/consultation` 페이지에서 고객 리스트 확인
2. **실시간 채팅**: 선택한 고객과 1:N 메시지 송수신
3. **권한 관리**: ADMIN 역할만 접근 가능

### 데이터 저장
- **MongoDB**: 모든 상담 메시지와 세션 정보 저장
- **컬렉션**:
  - `consultation_messages`: 고객-상담사 메시지
  - `consultation_sessions`: 고객 세션 정보

---

## 📁 생성된 파일 구조

### 백엔드 Java 클래스

#### DTO (Data Transfer Object)
- `ConsultationMessageDTO`: 상담 메시지 (MongoDB 저장)
- `ConsultationSessionDTO`: 고객 세션 정보 (MongoDB 저장)
- `WebSocketMessageDTO`: WebSocket 메시지 형식
- `MessageNotificationDTO`: 메시지 알림 DTO
- `ConsultationSessionResponseDTO`: API 응답 DTO

#### 도메인 및 저장소
- `ConsultationMessageRepository`: MongoDB 메시지 저장소
- `ConsultationSessionRepository`: MongoDB 세션 저장소

#### 핸들러
- `ConsultationWebSocketHandler`: WebSocket 핸들러
  - 고객 연결 관리
  - 메시지 라우팅
  - 상담사 연결 조정

#### 유틸리티
- `CustomerSession`: 고객 세션 정보 (UUID + WebSocket)
- `SessionManager`: 모든 세션 관리 및 메시지 라우팅
- `AppConfig`: Gson 빈 설정

#### 컨트롤러
- `ConsultationController`: 고객용 API
  - 세션 조회
  - 메시지 목록 조회
  - 상담 요청/종료
  
- `AdminConsultationController`: 관리자용 API (ADMIN 권한 필수)
  - 대기 고객 리스트
  - 고객 수락
  - 메시지 송수신
  - 상담 종료

#### 설정
- `WebSocketConfig`: WebSocket 엔드포인트 등록 (`/ws/consultation`)
- `SecurityConfig`: 보안 설정 업데이트
  - WebSocket 및 상담 API는 인증 불필요
  - 관리자 API는 ADMIN 권한 필수

### 프론트엔드 JavaScript

#### 고객용
- `chat.js` (위치: `/src/main/resources/static/js/chat.js`)
  - 💬 아이콘 형태의 채팅 버튼
  - 고정 위치에 표시 (우측 하단)
  - WebSocket 자동 연결
  - UUID 자동 할당 및 저장
  - GPT 모드: REST API 호출
  - 상담사 연결 버튼: WebSocket으로 요청 전송
  - 메시지 저장 (MongoDB)

#### 관리자용
- `admin-consultation-dashboard.js` (위치: `/src/main/resources/static/js/admin-consultation-dashboard.js`)
  - 관리자 대시보드 UI (HTML 동적 생성)
  - 대기 고객 리스트 (좌측 패널)
  - 실시간 채팅 영역 (우측 패널)
  - 고객 선택 시 자동 수락
  - 메시지 송수신
  - 상담 종료 기능

---

## 🔄 메시지 흐름

### 초기 연결 (고객)
```
1. 고객이 💬 버튼 클릭
   ↓
2. WebSocket 연결 시작 (`/ws/consultation`)
   ↓
3. 서버: UUID 생성 → 고객에게 SESSION_ID 전송
   ↓
4. 고객: sessionId 저장, 채팅 준비 완료
```

### GPT 모드 (자동 응답)
```
1. 고객: 메시지 입력 및 전송
   ↓
2. 프론트엔드: REST API 호출 (`POST /api/chat`)
   ↓
3. 백엔드: ChatService → OpenAI GPT 호출
   ↓
4. 응답 전송 및 화면 표시
```

### 상담사 연결 요청
```
1. 고객: "상담사 연결" 버튼 클릭
   ↓
2. WebSocket 메시지: { type: "REQUEST_AGENT", sessionId, ... }
   ↓
3. 서버: 세션 상태 → "WAITING"
   ↓
4. 관리자 대시보드: 대기 고객 리스트 업데이트 (3초마다)
```

### 상담사 고객 수락
```
1. 관리자: 대기 고객 선택
   ↓
2. API 호출: `POST /api/admin/consultation/accept-customer/{sessionId}`
   ↓
3. 서버:
   - 세션 상태 → "CONNECTED"
   - sessionManager에 매핑 등록
   - 고객에게 알림 전송
   ↓
4. 고객 화면:
   - 제목: "Eric AI Assistant" → "상담사 채팅"
   - "상담사 연결" 버튼 비활성화
   - 이후 메시지는 WebSocket으로 직접 전송
```

### 상담사-고객 메시지 교환 (실시간)
```
고객 메시지 송신:
  WebSocket → ConsultationWebSocketHandler 
  → ConsultationMessageRepository 저장 (MongoDB)
  → SessionManager.sendMessageToAgent()
  → 상담사 WebSocket으로 전송

상담사 메시지 송신:
  API 호출 → ConsultationMessageRepository 저장 (MongoDB)
  → SessionManager.sendMessageToCustomer()
  → 고객 WebSocket으로 전송
```

---

## 🔐 보안 설정

### Security Configuration
```java
// 고객용 WebSocket - 인증 불필요
/ws/consultation       - permitAll()
/api/consultation/**   - permitAll()

// 관리자 페이지 - ADMIN 권한 필수
/admin/**              - hasRole('ADMIN')
/api/admin/**          - hasRole('ADMIN')
```

---

## 🚀 사용 방법

### 1. 고객용 채팅 (웹사이트 방문자)

#### 고객 페이지에 포함
```html
<script src="/static/js/chat.js"></script>
```

#### 사용 방법
1. 웹사이트 우측 하단 💬 버튼 클릭
2. 채팅창 열림 (로그인 불필요)
3. 자동으로 UUID 할당 및 연결
4. GPT와 대화 시작
5. "상담사 연결" 버튼으로 실시간 상담 요청 가능

### 2. 관리자 대시보드 (8484 포트)

#### 관리자 페이지에 포함
```jsp
<!-- 관리자 JSP 또는 HTML -->
<div data-agent-id="admin-id" data-agent-name="홍길동"></div>
<script src="/static/js/admin-consultation-dashboard.js"></script>
```

#### 관리자 기능
1. `/admin/consultation` 페이지 방문 (ADMIN 로그인 필수)
2. 좌측: 대기 고객 리스트 자동 새로고침
3. 고객 선택 → 자동 수락 및 채팅 시작
4. 메시지 송수신 (실시간)
5. "상담 종료" 버튼으로 고객과 연결 종료

---

## 📡 API 엔드포인트

### 고객용 API
```
GET  /api/consultation/session/{sessionId}          - 세션 정보 조회
GET  /api/consultation/messages/{sessionId}         - 메시지 목록
POST /api/consultation/request-agent/{sessionId}    - 상담사 연결 요청
POST /api/consultation/end/{sessionId}              - 상담 종료
```

### 관리자용 API (ADMIN 권한 필수)
```
GET  /api/admin/consultation/waiting-customers      - 대기 고객 리스트
POST /api/admin/consultation/accept-customer/{sessionId}  - 고객 수락
GET  /api/admin/consultation/messages/{sessionId}   - 메시지 조회
POST /api/admin/consultation/send-message           - 메시지 송신
POST /api/admin/consultation/end-consultation/{sessionId} - 상담 종료
GET  /api/admin/consultation/all-sessions           - 모든 세션 조회
```

### WebSocket 엔드포인트
```
WS   /ws/consultation   - 고객-상담사 실시간 채팅
```

---

## 💾 MongoDB 데이터 모델

### consultation_messages 컬렉션
```json
{
  "_id": "ObjectId",
  "sessionId": "uuid-string",
  "messageType": "CUSTOMER|AGENT",
  "message": "메시지 내용",
  "timestamp": "2025-11-25T10:30:00",
  "agentId": "admin-id"
}
```

### consultation_sessions 컬렉션
```json
{
  "_id": "ObjectId",
  "sessionId": "uuid-string",
  "status": "WAITING|CONNECTED|CLOSED",
  "startTime": "2025-11-25T10:25:00",
  "endTime": "2025-11-25T10:35:00",
  "agentId": "admin-id",
  "agentName": "홍길동",
  "messageIds": ["msg-id-1", "msg-id-2"]
}
```

---

## 🔧 기존 시스템과의 호환성

### 유지된 기능
- ✅ 기존 GPT 관련 DTO/로직 유지
- ✅ `/api/chat` REST API 계속 사용
- ✅ 기존 Security 설정 유지
- ✅ 기존 관리자 페이지 정상 작동

### 신규 추가
- ✅ WebSocket 기반 실시간 상담
- ✅ MongoDB 저장소 추가
- ✅ 상담사 관리 페이지
- ✅ 아이콘 형태의 채팅 버튼

---

## ⚙️ 환경 설정

### application.properties 예시
```properties
# 기존 설정 유지
spring.application.name=boot_car_recall
server.port=8484

# MongoDB (기존)
# spring.data.mongodb.uri=mongodb://localhost:27017/your-db

# WebSocket은 별도 포트 설정 불필요
# (기본 8484 포트 사용)
```

### build.gradle 수정 사항
```gradle
dependencies {
    // 기존 의존성 유지
    ...
    // 신규 추가
    implementation 'org.springframework.boot:spring-boot-starter-websocket'
    implementation 'com.google.code.gson:gson:2.10.1'
}
```

---

## 🧪 테스트 시나리오

### 1. 고객 자동 응답 테스트
1. 웹사이트 방문 → 💬 버튼 클릭
2. "자동차 결함 정보를 알려주세요" 입력
3. GPT 응답 확인 (자동)

### 2. 상담사 연결 테스트
1. 고객: 채팅창에서 "상담사 연결" 버튼 클릭
2. 관리자: 대시보드 새로고침 → 대기 고객 확인
3. 관리자: 고객 선택 → 자동 수락
4. 양방향 메시지 전송 테스트
5. 상담 종료 확인

### 3. MongoDB 저장 테스트
1. 메시지 송수신 후
2. MongoDB에서 `consultation_messages` 확인
3. 타임스탐프, sessionId, 메시지 타입 검증

---

## 📝 주요 기능 요약

| 기능 | 고객 | 상담사 | 저장 |
|------|------|--------|------|
| 자동 응답 (GPT) | ✅ | - | Redis |
| 실시간 채팅 | ✅ | ✅ | MongoDB |
| 세션 관리 | UUID 자동 | - | MongoDB |
| 메시지 송수신 | ✅ | ✅ | MongoDB |
| 1:N 상담 | - | ✅ | - |
| 권한 관리 | 불필요 | ADMIN | - |

---

## 🛠️ 트러블슈팅

### WebSocket 연결 실패
- 프로토콜 확인: `ws://` (HTTP) 또는 `wss://` (HTTPS)
- 방화벽 설정 확인
- 브라우저 개발자 도구에서 Network 탭 확인

### 메시지가 MongoDB에 저장되지 않음
- MongoDB 연결 설정 확인
- `spring.data.mongodb.uri` 설정 확인
- MongoDB 권한 설정 확인

### 상담사가 고객 메시지를 받지 못함
- SessionManager에 매핑 확인
- WebSocket 연결 상태 확인
- 서버 로그에서 라우팅 오류 확인

---

## 📚 참고 자료

- Spring WebSocket: https://spring.io/guides/gs/messaging-stomp-websocket/
- MongoDB Reactive: https://spring.io/projects/spring-data-mongodb
- Gson: https://github.com/google/gson

---

## ✅ 구현 완료 사항

- [x] WebSocket 기반 실시간 채팅
- [x] 고객 UUID 자동 생성
- [x] GPT 자동 응답 유지
- [x] 상담사 연결 기능
- [x] 1:N 상담 지원
- [x] MongoDB 메시지 저장
- [x] 관리자 대시보드
- [x] 보안 설정 (ADMIN 권한)
- [x] 아이콘 형태 채팅 버튼
- [x] 기존 시스템 호환성 유지

---

**구현 완료**: 2025년 11월 25일
**버전**: 1.0
