package com.boot.service;

import com.boot.dao.RecallDAO;
import com.boot.dto.Criteria;
import com.boot.dto.RecallDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional; // 트랜잭션 관리를 위해 추가

import java.util.List;

@Service
@RequiredArgsConstructor
public class RecallServiceImpl implements RecallService {

    private final RecallDAO recallDAO;

    // -------------------------------------------------------------------
    // 1. 데이터 로드/저장 기능 (MainController에서 JSON 로드 후 호출)
    // -------------------------------------------------------------------
    @Override
    @Transactional // 대량의 데이터를 삽입하므로 트랜잭션을 적용합니다.
    public void saveRecallData(List<RecallDTO> recallList) {
        // 이 메서드는 외부 리스트를 받아 저장하는 역할입니다.
        // 각 리콜 항목을 개별적으로 삽입하도록 변경합니다.
        for (RecallDTO recallDTO : recallList) {
            recallDAO.insertRecall(recallDTO);
        }
    }

    // -------------------------------------------------------------------
    // 2. 리스트 배치 삽입 (Init.java의 컴파일 오류 해결 및 효율적인 삽입)
    // -------------------------------------------------------------------
    @Override
    @Transactional // 트랜잭션을 명확히 적용합니다.
    public void insertRecallList(List<RecallDTO> recallList) {
        // 각 리콜 항목을 개별적으로 삽입하도록 변경합니다.
        for (RecallDTO recallDTO : recallList) {
            recallDAO.insertRecall(recallDTO);
        }
    }

    // -------------------------------------------------------------------
    // 3. 전체 목록 조회 (페이징 및 검색 기준 적용)
    // -------------------------------------------------------------------
    @Override
    public List<RecallDTO> getAllRecalls(Criteria cri) {
        // Criteria 객체를 DAO에 직접 전달
        return recallDAO.selectAll(cri);
    }

    // -------------------------------------------------------------------
    // 4. 전체 데이터 수 조회 (검색 기능 포함)
    // -------------------------------------------------------------------
    @Override
    public int getRecallCount(Criteria cri) {
        // Criteria 객체를 DAO에 직접 전달
        return recallDAO.count(cri);
    }

    // -------------------------------------------------------------------
    // 5. 차량 모델명으로 검색 (메인 페이지 검색 기능)
    // -------------------------------------------------------------------
    @Override
    public List<RecallDTO> searchRecallsByModelName(String modelName) {
        return recallDAO.searchByModelName(modelName);
    }

    // -------------------------------------------------------------------
    // 6. 전체 리콜 데이터 수 조회 (Init 클래스에서 사용)
    // -------------------------------------------------------------------
    @Override
    public int countAllRecalls() {
        // 빈 Criteria 객체를 전달
        return recallDAO.count(new Criteria());
    }
}