package com.boot.dao;

import com.boot.dto.UserVehicleDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserVehicleDao {
    void save(UserVehicleDto userVehicle);
    List<UserVehicleDto> findByUsername(String username);
    List<UserVehicleDto> findAll(); // 모든 등록 차량 조회 (리콜 발생 시 매칭용)
    void delete(Long id);
}