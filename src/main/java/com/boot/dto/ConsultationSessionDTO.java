package com.boot.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * 고객 상담 세션 정보
 * MongoDB에 저장됨
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "consultation_sessions")
public class ConsultationSessionDTO {
    @Id
    private String id;
    
    private String sessionId;           // 고객 UUID
    private String status;              // "WAITING", "CONNECTED", "CLOSED"
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private String agentId;             // 담당 상담사 ID
    private String agentName;           // 담당 상담사 이름
    private List<String> messageIds;    // 메시지 ID 목록
    
    public ConsultationSessionDTO(String sessionId) {
        this.sessionId = sessionId;
        this.status = "WAITING";
        this.startTime = LocalDateTime.now();
        this.messageIds = new ArrayList<>();
    }
    
    public void connectAgent(String agentId, String agentName) {
        this.agentId = agentId;
        this.agentName = agentName;
        this.status = "CONNECTED";
    }
    
    public void close() {
        this.status = "CLOSED";
        this.endTime = LocalDateTime.now();
    }
}
