package com.boot.config;

import com.boot.handler.ConsultationWebSocketHandler;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import lombok.RequiredArgsConstructor;

/**
 * WebSocket 설정
 */
@Configuration
@EnableWebSocket
@RequiredArgsConstructor
public class WebSocketConfig implements WebSocketConfigurer {
    
    private final ConsultationWebSocketHandler consultationWebSocketHandler;
    
    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        // 고객용 WebSocket 엔드포인트 (인증 불필요)
        registry.addHandler(consultationWebSocketHandler, "/ws/consultation")
                .setAllowedOrigins("*");
    }
}
