package com.boot.service;

import com.boot.dao.BoardDAO;
import com.boot.dto.BoardDTO;
import com.boot.dto.Criteria;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {

    private final BoardDAO boardDAO;
    private final UploadService uploadService; // UploadService는 파일 처리를 위해 필요할 수 있음

    @Override
    public List<BoardDTO> list() {
        return boardDAO.list();
    }

    @Override
    public List<BoardDTO> listWithPaging(Criteria cri) {
        return boardDAO.listWithPaging(cri);
    }

    @Override
    public int getTotalCount(Criteria cri) {
        return boardDAO.getTotalCount(cri);
    }

    @Override
    @Transactional
    public void write(HashMap<String, String> param) {
        boardDAO.write(param);
    }

    @Override
    @Transactional
    public BoardDTO contentView(int boardNo) {
        boardDAO.hitUp(boardNo);
        return boardDAO.contentView(boardNo);
    }

    @Override
    @Transactional
    public void modify(HashMap<String, String> param) {
        boardDAO.modify(param);
    }

    @Override
    @Transactional
    public void delete(HashMap<String, String> param) {
        // 파일 삭제 로직은 UploadService 등으로 위임하는 것이 좋으나, 일단 유지
        // int boardNo = Integer.parseInt(param.get("boardNo"));
        // List<BoardAttachDTO> filePath = uploadDao.getFileList(boardNo);
        // uploadService.deleteFile(filePath);
        // uploadDao.deleteFile(boardNo);
        boardDAO.delete(param);
    }

    @Override
    public List<BoardDTO> searchByKeyword(String keyword) {
        return boardDAO.searchByKeyword(keyword);
    }
}
