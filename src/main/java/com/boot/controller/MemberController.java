package com.boot.controller;

import com.boot.dto.MemberDto;
import com.boot.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/signup")
    public String signup() {
        return "signup";
    }

    @PostMapping("/signup")
    public String signup(MemberDto memberDto, RedirectAttributes redirectAttributes) {
        try {
            memberService.save(memberDto);
            redirectAttributes.addFlashAttribute("message", "회원가입이 완료되었습니다. 이메일 인증을 해주세요.");
            return "redirect:/email-sent";
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/signup";
        }
    }

    @GetMapping("/email-sent")
    public String emailSent(@RequestParam(required = false) String message, Model model) {
        if (message != null) {
            model.addAttribute("message", message);
        }
        return "emailSent";
    }

    @GetMapping("/verify-email")
    public String verifyEmail(@RequestParam String token, RedirectAttributes redirectAttributes) {
        if (memberService.verifyEmail(token)) {
            redirectAttributes.addFlashAttribute("message", "이메일 인증이 완료되었습니다. 이제 로그인할 수 있습니다.");
            return "redirect:/login";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "유효하지 않거나 만료된 인증 링크입니다.");
            return "redirect:/login";
        }
    }

    @GetMapping("/find-account")
    public String findAccount() {
        return "findAccount";
    }

    @PostMapping("/find-id")
    public String findId(@RequestParam String email, RedirectAttributes redirectAttributes) {
        String username = memberService.findUsernameByEmail(email);
        if (username != null) {
            redirectAttributes.addFlashAttribute("message", "입력하신 이메일로 아이디 정보를 전송했습니다.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "해당 이메일로 가입된 아이디를 찾을 수 없습니다.");
        }
        return "redirect:/account-result";
    }

    @PostMapping("/reset-password")
    public String requestPasswordReset(@RequestParam String username, @RequestParam String email, RedirectAttributes redirectAttributes) {
        if (memberService.requestPasswordReset(username, email)) {
            redirectAttributes.addFlashAttribute("message", "입력하신 이메일로 비밀번호 재설정 링크를 전송했습니다.");
            return "redirect:/email-sent";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "아이디 또는 이메일 정보가 일치하지 않습니다.");
            return "redirect:/find-account";
        }
    }

    @GetMapping("/reset-password-form")
    public String resetPasswordForm(@RequestParam String token, Model model, RedirectAttributes redirectAttributes) {
        // 토큰 유효성 검사는 MemberService에서 처리
        // 여기서는 단순히 폼을 보여줌
        model.addAttribute("token", token);
        return "resetPasswordForm";
    }

    @PostMapping("/reset-password-confirm")
    public String resetPasswordConfirm(@RequestParam String token, @RequestParam String newPassword, RedirectAttributes redirectAttributes) {
        if (memberService.resetPassword(token, newPassword)) {
            redirectAttributes.addFlashAttribute("message", "비밀번호가 성공적으로 재설정되었습니다. 새 비밀번호로 로그인해주세요.");
            return "redirect:/login";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "유효하지 않거나 만료된 비밀번호 재설정 링크입니다.");
            return "redirect:/login";
        }
    }

    @GetMapping("/account-result")
    public String accountResult(@RequestParam(required = false) String message, Model model) {
        if (message != null) {
            model.addAttribute("message", message);
        }
        return "accountResult";
    }
}