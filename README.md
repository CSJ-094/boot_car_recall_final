# 🚗 Car Recall Information System
> **공공데이터 API 기반 자동차 리콜 정보 조회 및 커뮤니티 플랫폼**

이 프로젝트는 국토교통부(또는 관련 공공기관)의 리콜 정보를 수집하여 사용자에게 제공하고, 자동차 소유주들이 리콜 관련 정보와 후기를 공유할 수 있는 커뮤니티 기능을 결합한 서비스입니다.

---

## 🛠 Tech Stack

### Backend
![Java](https://img.shields.io/badge/Java-17-007396?style=flat&logo=java&logoColor=white)
![SpringBoot](https://img.shields.io/badge/SpringBoot-3.2.x-6DB33F?style=flat&logo=springboot&logoColor=white)
![SpringSecurity](https://img.shields.io/badge/SpringSecurity-6.x-6DB33F?style=flat&logo=springsecurity&logoColor=white)
![JPA](https://img.shields.io/badge/JPA-Hibernate-59666C?style=flat)

### Database & External API
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=flat&logo=mysql&logoColor=white)
![PublicAPI](https://img.shields.io/badge/Public_Data-API-blue?style=flat)

### Frontend
![Thymeleaf](https://img.shields.io/badge/Thymeleaf-005F0F?style=flat&logo=thymeleaf&logoColor=white)
![Bootstrap](https://img.shields.io/badge/Bootstrap-5.x-7952B3?style=flat&logo=bootstrap&logoColor=white)

---

## ✨ Key Features

**🔍 리콜 정보 조회 (Recall Info)**

공공 API 연동: 실시간으로 최신 자동차 리콜 데이터를 호출하여 사용자에게 제공합니다.

검색 및 필터링: 제조사, 모델명, 생산 기간별로 세분화된 리콜 정보 검색 기능을 지원합니다.

데이터 캐싱: 빈번한 API 호출을 방지하기 위해 조회된 데이터를 로컬 DB에 캐싱하여 성능을 최적화했습니다.

**💬 차량 결함 등록**

차량 결함 사례 등록:  실제 차량 결함을 등록하는 기능을 제공합니다.

이미지 업로드: 차량 결함을 확인할 수 있는 사진 등을 업로드 할 수 있는 기능입니다.

**👑 관리자 기능 (Admin Back-office)**

리콜 데이터 수동 업데이트: API 장애 시를 대비한 수동 데이터 등록 및 관리 기능.

대시보드: 리콜 통계 및 사용자 활동 지표 모니터링.

## ERD



## 🏗 System Architecture

```mermaid
graph TD
    User((사용자)) --> Security[Spring Security]
    Security --> Controller[Controller Layer]
    
    subgraph App_Server [Spring Boot Application]
        Controller --> RecallService[Recall Info Service]
        Controller --> CommunityService[Community Service]
        RecallService <--> API_Client[Public Data API Client]
    end
    
    RecallService --> MySQL[(MySQL: Recall Cache)]
    CommunityService --> MySQL[(MySQL: Posts/Comments)]
    API_Client <--> Gov_API[[Public Data API]]
