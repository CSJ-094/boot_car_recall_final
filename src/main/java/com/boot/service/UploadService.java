package com.boot.service;

import com.boot.dto.BoardAttachDTO;

import java.util.List;

public interface UploadService {
	public void insertFile(BoardAttachDTO vo);
	public List<BoardAttachDTO> getFileList(int boardNo);
	public void deleteFile(List<BoardAttachDTO> fileList);
	public void deleteFileDB(String uuid);
	public BoardAttachDTO findByUuid(String uuid);
}
