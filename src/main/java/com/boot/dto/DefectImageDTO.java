package com.boot.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DefectImageDTO {
    private Long imageId;
    private Long reportId;
    private String fileName;
}
