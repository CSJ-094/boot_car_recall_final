package com.boot.service;

import com.boot.dao.RecallDAO;
import com.boot.dto.Criteria;
import com.boot.dto.RecallDTO;
import com.boot.dto.UserVehicleDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class RecallServiceImpl implements RecallService {

    private final RecallDAO recallDAO;
    private final UserVehicleService userVehicleService; // UserVehicleService 주입
    private final NotificationService notificationService; // NotificationService 주입

    // -------------------------------------------------------------------
    // 1. 데이터 로드/저장 기능 (MainController에서 JSON 로드 후 호출)
    // -------------------------------------------------------------------
    @Override
    @Transactional
    public void saveRecallData(List<RecallDTO> recallList) {
        for (RecallDTO recallDTO : recallList) {
            recallDAO.insertRecall(recallDTO);
            // 새로운 리콜 데이터 저장 후 알림 로직 추가
            checkAndSendRecallNotification(recallDTO);
        }
    }

    // -------------------------------------------------------------------
    // 2. 리스트 배치 삽입 (Init.java의 컴파일 오류 해결 및 효율적인 삽입)
    // -------------------------------------------------------------------
    @Override
    @Transactional
    public void insertRecallList(List<RecallDTO> recallList) {
        for (RecallDTO recallDTO : recallList) {
            recallDAO.insertRecall(recallDTO);
            // 새로운 리콜 데이터 저장 후 알림 로직 추가
            checkAndSendRecallNotification(recallDTO);
        }
    }

    // -------------------------------------------------------------------
    // 3. 전체 목록 조회 (페이징 및 검색 기준 적용)
    // -------------------------------------------------------------------
    @Override
    public List<RecallDTO> getAllRecalls(Criteria cri) {
        return recallDAO.selectAll(cri);
    }

    // -------------------------------------------------------------------
    // 4. 전체 데이터 수 조회 (검색 기능 포함)
    // -------------------------------------------------------------------
    @Override
    public int getRecallCount(Criteria cri) {
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
        return recallDAO.count(new Criteria());
    }

    // 리콜 알림을 확인하고 발송하는 내부 메서드
    private void checkAndSendRecallNotification(RecallDTO newRecall) {
        List<UserVehicleDto> userVehicles = userVehicleService.getAllUserVehicles();
        for (UserVehicleDto userVehicle : userVehicles) {
            // 제조사와 모델명이 일치하는지 확인
            if (userVehicle.getMaker().equalsIgnoreCase(newRecall.getMaker()) &&
                userVehicle.getModelName().equalsIgnoreCase(newRecall.getModelName())) {

                String title = "새로운 리콜 정보 알림: " + newRecall.getMaker() + " " + newRecall.getModelName();
                String message = String.format(
                    "등록하신 차량 '%s %s'에 대한 새로운 리콜 정보가 발표되었습니다.<br>" +
                    "리콜 사유: %s<br>" +
                    "리콜 날짜: %s",
                    newRecall.getMaker(), newRecall.getModelName(),
                    newRecall.getRecallReason(), newRecall.getRecallDate()
                );
                String link = "/recall-status"; // 리콜 현황 페이지 링크

                notificationService.createAndSendNotification(
                    userVehicle.getUsername(),
                    "RECALL",
                    title,
                    message,
                    link
                );
            }
        }
    }
}