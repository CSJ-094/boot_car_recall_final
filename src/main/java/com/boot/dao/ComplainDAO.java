package com.boot.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.boot.dto.ComplainDTO;



public interface ComplainDAO {
	public ArrayList<ComplainDTO> complain_list();
	public ArrayList<ComplainDTO> find_modify_content(HashMap<String, String> param);
	public void complain_write(HashMap<String, String> param);
	public ComplainDTO contentView(HashMap<String, String> param);
	public void complain_modify(HashMap<String, String> param);
	public void complain_delete(HashMap<String, String> param);
	public void updateAnswer(HashMap<String, String> param);
}
