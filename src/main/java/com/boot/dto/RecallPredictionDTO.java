package com.boot.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class RecallPredictionDTO {

    // Python이 보내주는 JSON 키값("recall_probability")을 자바 변수명과 매핑
    @JsonProperty("recall_probability")
    private Double recallProbability;

    @JsonProperty("predicted_part")
    private String predictedPart;

    @JsonProperty("similar_case")
    private SimilarCaseDetailDTO similarCase;

    // Python의 "similar_case" 안에 들어있는 데이터를 받을 내부 클래스
    @Data
    @NoArgsConstructor
    public static class SimilarCaseDetailDTO {
        private String reason;      // 리콜 사유
        private String category;    // 부품 카테고리
        private Double similarity;  // 유사도 점수
    }

}