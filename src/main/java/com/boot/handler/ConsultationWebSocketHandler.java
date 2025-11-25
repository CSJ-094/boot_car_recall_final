package com.boot.handler;

import com.boot.domain.ConsultationMessageRepository;
import com.boot.domain.ConsultationSessionRepository;
import com.boot.dto.ConsultationMessageDTO;
import com.boot.dto.ConsultationSessionDTO;
import com.boot.dto.WebSocketMessageDTO;
import com.boot.util.CustomerSession;
import com.boot.util.SessionManager;
import com.google.gson.Gson;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.UUID;

/**
 * 고객-상담사 실시간 채팅 WebSocket 핸들러
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class ConsultationWebSocketHandler extends TextWebSocketHandler {
    
    private final SessionManager sessionManager;
    private final ConsultationMessageRepository consultationMessageRepository;
    private final ConsultationSessionRepository consultationSessionRepository;
    private final Gson gson;
    
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        // 새로운 고객 세션 생성 (UUID)
        String sessionId = UUID.randomUUID().toString();
        log.info("새로운 고객 연결: sessionId={}, wsSessionId={}", sessionId, session.getId());
        
        // 고객 세션 저장
        CustomerSession customerSession = new CustomerSession(sessionId, session);
        sessionManager.addCustomerSession(sessionId, customerSession);
        
        // 상담 세션 MongoDB에 저장
        ConsultationSessionDTO sessionDTO = new ConsultationSessionDTO(sessionId);
        consultationSessionRepository.save(sessionDTO).subscribe();
        
        // 클라이언트에 UUID 전송
        WebSocketMessageDTO response = new WebSocketMessageDTO();
        response.setType("SESSION_ID");
        response.setSessionId(sessionId);
        session.sendMessage(new TextMessage(gson.toJson(response)));
    }
    
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();
        log.debug("메시지 수신: {}", payload);
        
        try {
            WebSocketMessageDTO messageDto = gson.fromJson(payload, WebSocketMessageDTO.class);
            String sessionId = messageDto.getSessionId();
            
            if ("REQUEST_AGENT".equals(messageDto.getType())) {
                // 상담사 연결 요청
                handleRequestAgent(sessionId, session);
            } else if ("MESSAGE".equals(messageDto.getType())) {
                // 메시지 전송
                handleCustomerMessage(sessionId, messageDto.getMessage(), session);
            } else if ("END_CONSULTATION".equals(messageDto.getType())) {
                // 상담 종료
                handleEndConsultation(sessionId, session);
            } else if ("DISCONNECT".equals(messageDto.getType())) {
                // 연결 종료
                handleDisconnect(sessionId, session);
            }
        } catch (Exception e) {
            log.error("메시지 처리 오류", e);
        }
    }
    
    private void handleRequestAgent(String sessionId, WebSocketSession session) throws Exception {
        log.info("상담사 연결 요청: sessionId={}", sessionId);
        
        // 상담 세션 상태 업데이트
        ConsultationSessionDTO sessionDTO = consultationSessionRepository.findBySessionId(sessionId).block();
        if (sessionDTO != null) {
            sessionDTO.setStatus("WAITING");
            consultationSessionRepository.save(sessionDTO).subscribe();
        }
        
        // 고객 세션 상태 변경
        CustomerSession customerSession = sessionManager.getCustomerSession(sessionId);
        if (customerSession != null) {
            customerSession.setStatus("WAITING");
            
            // 클라이언트에 상담사 대기 중 알림
            WebSocketMessageDTO response = new WebSocketMessageDTO();
            response.setType("AGENT_WAITING");
            response.setSessionId(sessionId);
            session.sendMessage(new TextMessage(gson.toJson(response)));
        }
    }
    
    private void handleCustomerMessage(String sessionId, String messageText, WebSocketSession session) throws Exception {
        log.info("고객 메시지: sessionId={}, message={}", sessionId, messageText);
        
        // 메시지 저장
        ConsultationMessageDTO messageDTO = new ConsultationMessageDTO(
                sessionId, "CUSTOMER", messageText
        );
        consultationMessageRepository.save(messageDTO).subscribe();
        
        // 담당 상담사에게 메시지 전송
        CustomerSession customerSession = sessionManager.getCustomerSession(sessionId);
        if (customerSession != null && "AGENT_CHAT".equals(customerSession.getStatus())) {
            String agentId = customerSession.getAgentId();
            sessionManager.sendMessageToAgent(agentId, sessionId, "CUSTOMER", messageText);
        }
    }
    
    private void handleDisconnect(String sessionId, WebSocketSession session) {
        log.info("고객 연결 종료: sessionId={}", sessionId);
        
        ConsultationSessionDTO sessionDTO = consultationSessionRepository.findBySessionId(sessionId).block();
        if (sessionDTO != null) {
            sessionDTO.close();
            consultationSessionRepository.save(sessionDTO).subscribe();
        }
    }
    
    private void handleEndConsultation(String sessionId, WebSocketSession session) throws Exception {
        log.info("고객이 상담 종료 요청: sessionId={}", sessionId);
        
        // 고객 세션에서 상담사 연결 정보 가져오기
        CustomerSession customerSession = sessionManager.getCustomerSession(sessionId);
        String agentId = null;
        if (customerSession != null) {
            agentId = customerSession.getAgentId();
        }
        
        // 상담 세션 상태 업데이트
        ConsultationSessionDTO sessionDTO = consultationSessionRepository.findBySessionId(sessionId).block();
        if (sessionDTO != null) {
            sessionDTO.close();
            consultationSessionRepository.save(sessionDTO).subscribe();
        }
        
        // 고객 세션에서 상담사 연결 해제
        if (customerSession != null) {
            if (agentId != null) {
                sessionManager.disconnectCustomerFromAgent(sessionId);
                // 상담사에게 상담 종료 알림 전송
                sessionManager.sendMessageToAgent(agentId, sessionId, "SYSTEM", "고객이 상담을 종료했습니다.");
            }
            customerSession.setStatus("ACTIVE");
            
            // 고객에게 상담 종료 알림 전송
            WebSocketMessageDTO response = new WebSocketMessageDTO();
            response.setType("CONSULTATION_ENDED");
            response.setSessionId(sessionId);
            session.sendMessage(new TextMessage(gson.toJson(response)));
        }
    }
    
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        // 고객 세션 찾기 및 제거
        String sessionId = sessionManager.findSessionIdByWebSocketSession(session);
        if (sessionId != null) {
            sessionManager.removeCustomerSession(sessionId);
            log.info("고객 연결 해제됨: sessionId={}", sessionId);
            
            // 상담 세션 상태 업데이트
            ConsultationSessionDTO sessionDTO = consultationSessionRepository.findBySessionId(sessionId).block();
            if (sessionDTO != null && !"CLOSED".equals(sessionDTO.getStatus())) {
                sessionDTO.close();
                consultationSessionRepository.save(sessionDTO).subscribe();
            }
        }
    }
    
    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        log.error("WebSocket 전송 오류", exception);
    }
}
