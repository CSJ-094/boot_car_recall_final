package com.boot.dao;

import com.boot.dto.BoardAttachDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UploadDAO {
//	파일업로드는 파라미터를 DTO 사용
	public void insertFile(BoardAttachDTO vo);
	public List<BoardAttachDTO> getFileList(int boardNo);
	public void deleteFile(int boardNo);
	public void deleteFileDB(String uuid);
	public BoardAttachDTO findByUuid(String uuid);
}






















