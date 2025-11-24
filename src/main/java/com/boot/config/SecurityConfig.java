package com.boot.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.annotation.Order;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationProvider adminAuthenticationProvider(
            @Qualifier("adminDetailsService") UserDetailsService adminDetailsService,
            PasswordEncoder passwordEncoder) {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setUserDetailsService(adminDetailsService);
        provider.setPasswordEncoder(passwordEncoder);
        return provider;
    }

    @Bean
    @Order(1)
    public SecurityFilterChain adminFilterChain(HttpSecurity http, AuthenticationProvider adminAuthenticationProvider) throws Exception {
        http
            .antMatcher("/admin/**")
            .authorizeHttpRequests(authorize -> authorize
                .antMatchers("/admin/login").permitAll()
                .anyRequest().hasRole("ADMIN")
            )
            .formLogin(form -> form
                .loginPage("/admin/login") // 관리자 전용 로그인 페이지
                .loginProcessingUrl("/admin/login")
                .usernameParameter("admin_id") // 아이디 파라미터 이름 설정
                .passwordParameter("admin_pw") // 비밀번호 파라미터 이름 설정
                .defaultSuccessUrl("/admin/main", true)
                .failureUrl("/admin/login?error=true")
                .permitAll()
            )
            .authenticationProvider(adminAuthenticationProvider) // 관리자용 인증 공급자 설정
            .logout(logout -> logout
                .logoutUrl("/admin/logout")
                .logoutSuccessUrl("/admin/login?logout")
                .invalidateHttpSession(true));
        return http.build();
    }

    @Bean
    @Order(2)
    public SecurityFilterChain userFilterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(authorize -> authorize
                .antMatchers(
                    "/", "/home", "/signup", "/login", "/css/**", "/js/**", "/img/**", "/video/**",
                    "/notice/**", "/faq/**", "/recall-status", "/report/**", "/complain/**",
                    "/verify-email", "/reset-password-form", "/reset-password-confirm",
                    "/email-sent", "/account-result", "/find-account", "/find-id",
                    "/report/write", // 기존 신고 접수 페이지 접근 허용
                    "/defect-report/**" // /defect-report로 시작하는 모든 경로 접근 허용
                ).permitAll()
                .anyRequest().authenticated()
            )
            .formLogin(form -> form
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .defaultSuccessUrl("/", true)
                .failureUrl("/login?error=true")
                .permitAll()
            )
            .logout(logout -> logout
                .logoutUrl("/logout")
                .logoutSuccessUrl("/")
            );
        return http.build();
    }

    @Bean
    public WebSecurityCustomizer webSecurityCustomizer() {
        // 정적 리소스는 authorizeHttpRequests에서 permitAll로 처리하는 것이 더 권장됩니다.
        return (web) -> web.ignoring().antMatchers("/resources/**");
    }
}