package com.boot.service;

import com.boot.dto.BoardDTO;
import com.boot.dto.Criteria;

import java.util.HashMap;
import java.util.List;

public interface BoardService {
    // 기존 목록 조회 (사용자용)
    List<BoardDTO> list();

    // 페이징 처리된 목록 조회 (관리자용)
    List<BoardDTO> listWithPaging(Criteria cri);
    // 전체 게시글 수 조회 (페이징용)
    int getTotalCount(Criteria cri);

    // 공통 사용 메소드들
    void write(HashMap<String, String> param);
    BoardDTO contentView(int boardNo);
    void modify(HashMap<String, String> param);
    void delete(HashMap<String, String> param);

    // 키워드 검색
    List<BoardDTO> searchByKeyword(String keyword);
}
