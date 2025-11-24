package com.boot.dao;

import com.boot.dto.Criteria;
import com.boot.dto.RecallDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface RecallDAO {

    // 1. 단일 리콜 정보 삽입
    void insertRecall(RecallDTO recallDTO);

    // 2. 전체 목록 조회 (페이징 및 검색 기능 포함)
    List<RecallDTO> selectAll(Criteria cri);

    // 3. 전체 데이터 수 조회 (검색 기능 포함)
    int count(Criteria cri);

    // 4. 모델명으로 검색
    List<RecallDTO> searchByModelName(@Param("modelName") String modelName);
}