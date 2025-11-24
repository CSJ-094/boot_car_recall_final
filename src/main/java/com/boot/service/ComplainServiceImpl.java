package com.boot.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.dao.ComplainDAO;
import com.boot.dto.ComplainDTO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ComplainServiceImpl implements ComplainService{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ArrayList<ComplainDTO> complain_list() {
		ComplainDAO dao = sqlSession.getMapper(ComplainDAO.class);
		ArrayList<ComplainDTO> complain_list = dao.complain_list();
		return complain_list;
	}
	
	@Override
	public ArrayList<ComplainDTO> find_modify_content(HashMap<String, String> param) {
		ComplainDAO dao = sqlSession.getMapper(ComplainDAO.class);
		ArrayList<ComplainDTO> find_modify_content = dao.find_modify_content(param);
		return find_modify_content;
	}

	@Override
	public void complain_write(HashMap<String, String> param) {
		log.info("@# service param =>"+param);
		ComplainDAO dao = sqlSession.getMapper(ComplainDAO.class);
		dao.complain_write(param);
	}
	

	@Override
	public ComplainDTO contentView(HashMap<String, String> param) {
		ComplainDAO dao = sqlSession.getMapper(ComplainDAO.class);
		ComplainDTO dto = dao.contentView(param);
		
		return dto;
	}

	@Override
	public void complain_modify(HashMap<String, String> param) {
		ComplainDAO dao = sqlSession.getMapper(ComplainDAO.class);
		dao.complain_modify(param);
	}

	@Override
	public void complain_delete(HashMap<String, String> param) {
		log.info("@# BoardServiceImpl delete()");
		log.info("@# report_id=>"+param.get("report_id"));
		
		ComplainDAO dao = sqlSession.getMapper(ComplainDAO.class);
		
//		게시글 삭제
		dao.complain_delete(param);
		
	}

	@Override
	public void addAnswer(HashMap<String, String> param) {
		ComplainDAO dao = sqlSession.getMapper(ComplainDAO.class);
		dao.updateAnswer(param);
	}

	

}
