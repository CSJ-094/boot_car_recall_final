package com.boot.service;

import com.boot.dao.MemberDao;
import com.boot.dto.MemberDto;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

@Service
@RequiredArgsConstructor
public class MemberService {

    private final MemberDao memberDao;
    private final PasswordEncoder passwordEncoder;
    private final EmailService emailService;

    // In-memory map to store verification tokens. In a real app, use a database with expiry.
    private final ConcurrentHashMap<String, String> emailVerificationTokens = new ConcurrentHashMap<>();
    private final ConcurrentHashMap<String, String> passwordResetTokens = new ConcurrentHashMap<>();


    @Transactional
    public void save(MemberDto memberDto) {
        // Check if username or email already exists
        if (memberDao.findByUsername(memberDto.getUsername()) != null) {
            throw new IllegalArgumentException("Username already exists.");
        }
        if (memberDao.findByEmail(memberDto.getEmail()) != null) {
            throw new IllegalArgumentException("Email already registered.");
        }

        memberDto.setPassword(passwordEncoder.encode(memberDto.getPassword()));
        memberDto.setEmailVerified(false); // Initially not verified
        memberDao.save(memberDto);

        // Generate verification token and send email
        String verificationToken = UUID.randomUUID().toString();
        emailVerificationTokens.put(verificationToken, memberDto.getUsername()); // Store token with username

        String verificationLink = "http://localhost:8484/verify-email?token=" + verificationToken; // Adjust port if needed
        String emailContent = "안녕하세요, " + memberDto.getUsername() + "님!<br>"
                            + "회원가입을 완료하시려면 다음 링크를 클릭하여 이메일 인증을 해주세요:<br>"
                            + "<a href=\"" + verificationLink + "\">이메일 인증하기</a>";
        emailService.sendEmail(memberDto.getEmail(), "자동차 리콜 통합센터 - 이메일 인증", emailContent);
    }

    @Transactional
    public boolean verifyEmail(String token) {
        String username = emailVerificationTokens.get(token);
        if (username != null) {
            memberDao.updateEmailVerified(username, true);
            emailVerificationTokens.remove(token); // Remove token after use
            return true;
        }
        return false;
    }

    public String findUsernameByEmail(String email) {
        MemberDto member = memberDao.findByEmail(email);
        if (member != null) {
            String emailContent = "요청하신 아이디는 <b>" + member.getUsername() + "</b> 입니다.";
            emailService.sendEmail(email, "자동차 리콜 통합센터 - 아이디 찾기", emailContent);
            return member.getUsername(); // Return username for confirmation message
        }
        return null;
    }

    @Transactional
    public boolean requestPasswordReset(String username, String email) {
        MemberDto member = memberDao.findByUsername(username);
        if (member != null && member.getEmail().equals(email)) {
            String resetToken = UUID.randomUUID().toString();
            passwordResetTokens.put(resetToken, username); // Store token with username

            String resetLink = "http://localhost:8484/reset-password-form?token=" + resetToken;
            String emailContent = "안녕하세요, " + username + "님!<br>"
                                + "비밀번호를 재설정하시려면 다음 링크를 클릭해주세요:<br>"
                                + "<a href=\"" + resetLink + "\">비밀번호 재설정하기</a><br>"
                                + "이 링크는 일정 시간 후 만료됩니다.";
            emailService.sendEmail(email, "자동차 리콜 통합센터 - 비밀번호 재설정", emailContent);
            return true;
        }
        return false;
    }

    @Transactional
    public boolean resetPassword(String token, String newPassword) {
        String username = passwordResetTokens.get(token);
        if (username != null) {
            memberDao.updatePassword(username, passwordEncoder.encode(newPassword));
            passwordResetTokens.remove(token); // Remove token after use
            return true;
        }
        return false;
    }

    // Add a method to check if a username already exists (for signup validation)
    public boolean isUsernameTaken(String username) {
        return memberDao.findByUsername(username) != null;
    }

    // Add a method to check if an email already exists (for signup validation)
    public boolean isEmailTaken(String email) {
        return memberDao.findByEmail(email) != null;
    }
}