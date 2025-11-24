package com.boot.service;

import com.boot.dto.Criteria;
import com.boot.dto.DefectReportDTO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface DefectReportService {
    void saveReport(DefectReportDTO report, List<MultipartFile> files);
    List<DefectReportDTO> getAllReports(Criteria cri);
    int getTotalCount(Criteria cri); // 검색 조건에 따른 전체 개수
    DefectReportDTO getReportById(Long id);
    void updateReport(DefectReportDTO report, List<MultipartFile> newFiles, List<String> existingFileNames);
    void deleteReport(Long id);
    boolean checkPassword(Long id, String password);
}
