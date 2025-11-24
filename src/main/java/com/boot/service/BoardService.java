package com.boot.service;

import com.boot.dto.BoardDTO;
import com.boot.dto.Criteria;

import java.util.ArrayList;
import java.util.HashMap;
import org.apache.ibatis.annotations.Param;

public interface BoardService {
    // 기존 목록 조회 (사용자용)
    public ArrayList<BoardDTO> list();

    // 페이징 처리된 목록 조회 (관리자용)
    public ArrayList<BoardDTO> listWithPaging(Criteria cri);
    // 전체 게시글 수 조회 (페이징용)
    public int getTotalCount(Criteria cri);

    // 공통 사용 메소드들
    public void write(HashMap<String, String> param);
    public BoardDTO contentView(HashMap<String, String> param);
    public BoardDTO contentView(int boardNo);
    public void modify(HashMap<String, String> param);
    public void delete(HashMap<String, String> param);

    public void hitUp(@Param("boardNo") int boardNo);
}