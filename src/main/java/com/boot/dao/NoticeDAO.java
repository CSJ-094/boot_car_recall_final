package com.boot.dao;

import com.boot.dto.Criteria;
import com.boot.dto.NoticeDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface NoticeDAO {
    public ArrayList<NoticeDTO> listWithPaging(Criteria cri);
    public int getTotalCount();
    public void write(NoticeDTO noticeDTO);
    public NoticeDTO getNotice(long notice_id);
    public void incrementViews(long notice_id);
    public void modify(NoticeDTO noticeDTO);
    public void delete(long notice_id);
}