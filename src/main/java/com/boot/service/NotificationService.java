package com.boot.service;

import com.boot.dao.NotificationDao;
import com.boot.dto.NotificationDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class NotificationService {

    private final NotificationDao notificationDao;
    private final EmailService emailService;
    private final MemberService memberService; // 이메일 주소를 가져오기 위해 MemberService 주입

    @Transactional
    public void createAndSendNotification(String username, String type, String title, String message, String link) {
        NotificationDto notification = new NotificationDto();
        notification.setUsername(username);
        notification.setType(type);
        notification.setTitle(title);
        notification.setMessage(message);
        notification.setLink(link);
        notification.setRead(false); // 기본적으로 읽지 않음
        notification.setCreatedAt(LocalDateTime.now());

        notificationDao.save(notification);

        // 사용자에게 이메일 알림 발송
        try {
            memberService.getMemberByUsername(username).ifPresent(memberDto -> {
                String emailContent = "<h3>" + title + "</h3>"
                                    + "<p>" + message + "</p>"
                                    + (link != null ? "<p><a href=\"" + link + "\">자세히 보기</a></p>" : "");
                emailService.sendEmail(memberDto.getEmail(), "[자동차 리콜 통합센터] " + title, emailContent);
            });
        } catch (Exception e) {
            log.error("이메일 발송 중 오류 발생", e);
        }
    }

    public List<NotificationDto> getNotificationsByUsername(String username) {
        return notificationDao.findByUsername(username);
    }

    @Transactional
    public void markNotificationAsRead(Long id) {
        notificationDao.markAsRead(id);
    }

    public int countUnreadNotifications(String username) {
        return notificationDao.countUnreadNotifications(username);
    }
}