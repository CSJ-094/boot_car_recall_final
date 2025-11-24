package com.boot.dto;

import lombok.Data;
import java.util.Date;
import java.util.List; // List 임포트

@Data
public class DefectReportDTO {
    private Long id;
    private String reporterName;
    private String contact;
    private String carModel;
    private String vin;
    private String defectDetails;
    private Date reportDate;
    private String password;
    private List<DefectImageDTO> images; // 이미지 리스트 필드 추가
}
