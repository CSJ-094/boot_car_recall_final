package com.boot.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.boot.dto.ComplainDTO;

public interface ComplainService {
	public ArrayList<ComplainDTO> complain_list();
	public ArrayList<ComplainDTO> find_modify_content(HashMap<String, String> param);
	public void complain_write(ComplainDTO complainDTO);
	public ComplainDTO contentView(HashMap<String, String> param);
	public void complain_modify(HashMap<String, String> param);
	public void complain_delete(HashMap<String, String> param);
	public void addAnswer(HashMap<String, String> param);
	public ComplainDTO getComplainById(int reportId);
	public List<ComplainDTO> getComplainListByReporterName(String reporterName);
}
