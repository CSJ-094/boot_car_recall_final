package com.boot.dao;

import com.boot.dto.Criteria;
import com.boot.dto.DefectReportDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface DefectReportDAO {
    void insertReport(DefectReportDTO report);
    List<DefectReportDTO> selectAll(Criteria cri);
    int count(@Param("keyword") String keyword);
    DefectReportDTO selectById(Long id);
    void updateReport(DefectReportDTO report); // username과 status 필드도 업데이트에 포함
    void deleteReport(Long id);
    String selectPasswordById(Long id);
}
