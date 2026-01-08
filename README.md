<img width="891" height="1260" alt="리드미 (2)" src="https://github.com/user-attachments/assets/f30796d5-c11c-416c-ae28-bf9bd5f6912a" />

# 🚗 Car Recall Information System
> **공공데이터 API 기반 자동차 리콜 정보 조회 및 커뮤니티 플랫폼**

이 프로젝트는 국토교통부(또는 관련 공공기관)의 리콜 정보를 수집하여 사용자에게 제공하고, 자동차 소유주들이 리콜 관련 정보와 후기를 공유할 수 있는 커뮤니티 기능을 결합한 서비스입니다.

---

## 🎯 프로젝트 선정 배경


### 1. 📢정보의 파편화
* **비효율적 탐색:** 리콜 정보가 여러 기관 및 제조사 웹사이트에 흩어져 있어 일일이 방문해야 하는 번거로움이 있음
* **접근성 저하:** 사용자에게 꼭 필요한 안전 정보가 통합되어 있지 않아 신속한 확인이 어려움
* **정보 격차 발생:** 업데이트되는 최신 리콜 소식을 실시간으로 파악하기 힘든 구조적 한계가 존재함

<br/>

### 2. 🛠️신고 및 소통의 불편함
* **복잡한 절차:** 결함 신고나 문의 과정이 까다로워 사용자가 중도에 포기하게 됨
* **정보 부족:** 신고 시 필요한 정보나 작성 가이드가 부족하여 정확한 사례 접수가 어려움
* **채널 부재:** 제조사나 관련 기관과의 직접적인 소통 창구가 마련되어 있지 않아 사용자 피드백이 단절됨
<br/>

### 3. 📊 관리 및 분석의 비효율성
* **수동적 관리:** 데이터 수집과 관리가 자동화되지 않아 인적/시간적 리소스 낭비가 심함
* **현황 파악의 한계:** 산재된 데이터를 시각화하거나 통계적으로 분석할 수 있는 도구가 부족함
* **대응 속도 저하:** 체계적인 관리 시스템의 부재로 인해 리콜 사후 조치나 모니터링이 지연됨
<br/>


| 분류                | 기술                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| ----------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Frontend**      | ![React](https://img.shields.io/badge/React-61DAFB?logo=react\&logoColor=black) ![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?logo=typescript\&logoColor=white) ![TailwindCSS](https://img.shields.io/badge/Tailwind_CSS-06B6D4?logo=tailwindcss\&logoColor=white) ![SWR](https://img.shields.io/badge/SWR-000000?logo=vercel\&logoColor=white) ![Axios](https://img.shields.io/badge/Axios-5A29E4?logo=axios\&logoColor=white)                                                                                                                                                                                                                              |
| **Backend**       | ![Java17](https://img.shields.io/badge/Java-17-007396?logo=java\&logoColor=white) ![SpringBoot](https://img.shields.io/badge/Spring_Boot-3.x-6DB33F?logo=springboot\&logoColor=white) ![Python](https://img.shields.io/badge/Python-3.x-3776AB?logo=python\&logoColor=white) ![SpringSecurity](https://img.shields.io/badge/Spring_Security-6DB33F?logo=springsecurity\&logoColor=white) ![JPA](https://img.shields.io/badge/JPA_Hibernate-59666C?logo=hibernate\&logoColor=white) ![JWT](https://img.shields.io/badge/JWT-JSON_Web_Token-000000?logo=jsonwebtokens\&logoColor=white) ![Swagger](https://img.shields.io/badge/Swagger-85EA2D?logo=swagger\&logoColor=black) |
| **Data & Search** | ![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?logo=mysql\&logoColor=white) ![Elasticsearch](https://img.shields.io/badge/Elasticsearch-005571?logo=elasticsearch\&logoColor=white) ![Kibana](https://img.shields.io/badge/Kibana-E8478B?logo=kibana\&logoColor=white)                                                                                                                                                                                                                                                                                                                                                                                              |
| **AI & API**      | ![OpenAI](https://img.shields.io/badge/OpenAI-GPT--4o_mini-412991?logo=openai\&logoColor=white) ![GoogleVision](https://img.shields.io/badge/Google_Cloud_Vision-4285F4?logo=googlecloud\&logoColor=white) ![Toss](https://img.shields.io/badge/Toss_Payments-0064FF?logo=toss\&logoColor=white)                                                                                                                                                                                                                                                                                                                                                                            |
| **Infra & Tools** | ![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker\&logoColor=white) ![Git](https://img.shields.io/badge/Git-F05032?logo=git\&logoColor=white) ![GitHub](https://img.shields.io/badge/GitHub-181717?logo=github\&logoColor=white)                                                                                                                                                                                                                                                                                                                                                                                                                             |
| **Collaboration** | ![Jira](https://img.shields.io/badge/Jira-0052CC?logo=jira\&logoColor=white) ![Slack](https://img.shields.io/badge/Slack-4A154B?logo=slack\&logoColor=white) ![Notion](https://img.shields.io/badge/Notion-000000?logo=notion\&logoColor=white)                                                                                                                                                                                                                                                                                                                                                                                                                             |

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

<img width="626" height="623" alt="image" src="https://github.com/user-attachments/assets/76bddd1a-ddc7-4457-803f-a2f816867ea0" />

## UI/UX Screenshot

<details>
  <summary>**메인화면**</summary>

- 구조:

- 핵심 로직:

  
</details>


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
