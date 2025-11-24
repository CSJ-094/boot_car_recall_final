package com.boot.service;

import com.boot.dto.Criteria;
import com.boot.dto.FaqDTO;

import java.util.ArrayList;

public interface FaqService {
    public ArrayList<FaqDTO> getFaqList(Criteria cri);
    public int getTotal();
    public FaqDTO getFaq(long faq_id);
    public void writeFaq(FaqDTO faqDTO);
    public void modifyFaq(FaqDTO faqDTO);
    public void deleteFaq(long faq_id);
}