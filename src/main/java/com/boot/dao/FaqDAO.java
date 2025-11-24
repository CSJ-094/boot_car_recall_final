package com.boot.dao;

import com.boot.dto.Criteria;
import com.boot.dto.FaqDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface FaqDAO {
    public ArrayList<FaqDTO> listWithPaging(Criteria cri);
    public int getTotalCount();
    public FaqDTO getFaq(long faq_id);
    public void write(FaqDTO faqDTO);
    public void modify(FaqDTO faqDTO);
    public void delete(long faq_id);
}