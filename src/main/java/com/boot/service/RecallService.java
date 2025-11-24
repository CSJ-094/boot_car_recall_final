package com.boot.service;

import com.boot.dto.Criteria;
import com.boot.dto.RecallDTO;

import java.util.List;

public interface RecallService {

    // 1. 데이터 로드/저장 기능 (첫 번째 코드)
    void saveRecallData(List<RecallDTO> recallList);

    // 2. 리스트 배치 삽입 (두 번째 코드의 insertRecallList를 유지)
    void insertRecallList(List<RecallDTO> recallList);

    // 3. 전체 목록 조회 (페이징 및 검색 기준 적용, 첫 번째 코드)
    List<RecallDTO> getAllRecalls(Criteria cri);

    // 4. 전체 데이터 수 조회 (두 버전의 getRecallCount/getRecallCount(Criteria) 통합)
    // Criteria를 받지 않는 오버로딩 버전은 필요하지 않으므로, Criteria를 받는 버전만 유지합니다.
    int getRecallCount(Criteria cri);

    // 5. 차량 모델명으로 검색 (첫 번째 코드)
    List<RecallDTO> searchRecallsByModelName(String modelName);

    // 6. 전체 리콜 데이터 수 조회 (Init 클래스에서 사용)
    int countAllRecalls();
}