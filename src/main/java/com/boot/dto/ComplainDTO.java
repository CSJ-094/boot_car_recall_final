package com.boot.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ComplainDTO {
	private int report_id;
	private String reporter_name;
	private String password;
	private String phone;
	private String title;
	private String complain_type;
	private String carNum ;
	private String is_public;
	private String complainDate;
	private String content;
	private String answer;
}
