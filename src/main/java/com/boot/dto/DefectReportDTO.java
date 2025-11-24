package com.boot.dto;

import lombok.Data;
import java.util.Date;
import java.util.List; // List 임포트

@Data
public class DefectReportDTO {
    private Long id;
    private String username; // 결함 신고를 한 사용자 ID 추가
    private String reporterName;
    private String contact;
    private String carModel;
    private String vin;
    private String defectDetails;
    private Date reportDate;
    private String password;
    private String status; // 결함 신고 처리 상태 추가 (예: 접수, 처리중, 완료)
    private List<DefectImageDTO> images; // 이미지 리스트 필드 추가
}