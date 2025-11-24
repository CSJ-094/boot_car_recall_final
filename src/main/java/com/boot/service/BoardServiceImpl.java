package com.boot.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.boot.dao.UploadDAO;
import com.boot.dto.BoardAttachDTO;
import com.boot.dao.BoardDAO;
import com.boot.dto.BoardDTO;
import com.boot.dto.Criteria;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardServiceImpl implements BoardService {

    @Autowired
    private SqlSession sqlSession;
    @Autowired
    private UploadService uploadService;

    @Override
    public ArrayList<BoardDTO> list() {
        BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
        ArrayList<BoardDTO> list = dao.list();
        return list;
    }

    @Override
    public ArrayList<BoardDTO> listWithPaging(Criteria cri) {
        BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
        return dao.listWithPaging(cri);
    }

    @Override
    public int getTotalCount(Criteria cri) {
        BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
        return dao.getTotalCount(cri);
    }

    @Override
    public void write(HashMap<String, String> param) {
        BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
        dao.write(param);
    }

    @Override
    public BoardDTO contentView(HashMap<String, String> param) {
        BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
        // HashMap에서 "boardNo" 키의 값을 int로 변환하여 전달
        int boardNo = Integer.parseInt(param.get("boardNo"));
        BoardDTO dto = dao.contentView(boardNo);

        return dto;
    }

    @Override
    public BoardDTO contentView(int boardNo) {
        BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
        BoardDTO dto = dao.contentView(boardNo);

        return dto;
    }

    @Override
    public void modify(HashMap<String, String> param) {
        BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
        dao.modify(param);
    }

    @Override
    public void delete(HashMap<String, String> param) {


        BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
        UploadDAO uploadDao = sqlSession.getMapper(UploadDAO.class);
        int boardNo = Integer.parseInt(param.get("boardNo"));
        List<BoardAttachDTO> filePath = uploadDao.getFileList(boardNo);
        uploadService.deleteFile(filePath);

        uploadDao.deleteFile(boardNo);
        dao.delete(param);
    }

    @Override
    public void hitUp(int boardNo) {
        BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
        dao.hitUp(boardNo);
    }
}
