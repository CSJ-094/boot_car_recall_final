package com.boot.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class NotificationDto {
    private Long id;
    private String username;
    private String type; // RECALL, DEFECT_REPORT
    private String title;
    private String message;
    private String link;
    private boolean isRead;
    private LocalDateTime createdAt;
}