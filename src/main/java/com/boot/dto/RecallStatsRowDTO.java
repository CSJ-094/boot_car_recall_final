package com.boot.dto;

import lombok.Data;

@Data
public class RecallStatsRowDTO {
	private String groupName;	// 제조사명 
	private String periodLabel;	// 기간 레이블
	private long recallCount;	// 리콜 건수
}
