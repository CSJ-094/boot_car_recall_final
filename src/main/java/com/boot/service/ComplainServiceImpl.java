package com.boot.service;

import com.boot.dao.ComplainAttachDAO;
import com.boot.dao.ComplainDAO;
import com.boot.dto.ComplainAttachDTO;
import com.boot.dto.ComplainDTO;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream; // FileInputStream import 추가
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

@Service
@Slf4j
public class ComplainServiceImpl implements ComplainService {

    @Autowired
    private ComplainDAO complainDAO;

    @Autowired
    private ComplainAttachDAO complainAttachDAO;

    @Override
    public ArrayList<ComplainDTO> complain_list() {
        return complainDAO.complain_list();
    }

    @Override
    public ArrayList<ComplainDTO> find_modify_content(HashMap<String, String> param) {
        return complainDAO.find_modify_content(param);
    }

    @Transactional
    @Override
    public void complain_write(ComplainDTO complainDTO) {
        log.info("@# ComplainServiceImpl.complain_write() start");
        log.info("@# complainDTO (before DB insert) => " + complainDTO);

        complainDAO.complain_write(complainDTO);
        log.info("@# complain_write 후 report_id (after DB insert) => " + complainDTO.getReport_id());

        if (complainDTO.getUploadFiles() != null && !complainDTO.getUploadFiles().isEmpty()) {
            String uploadFolder = "C:\\upload\\complain";
            File uploadPath = new File(uploadFolder);

            if (!uploadPath.exists()) {
                uploadPath.mkdirs();
            }

            for (MultipartFile multipartFile : complainDTO.getUploadFiles()) {
                if (multipartFile.getSize() == 0) continue;

                ComplainAttachDTO attachDTO = new ComplainAttachDTO();
                String originalFileName = multipartFile.getOriginalFilename();
                String uuid = UUID.randomUUID().toString();
                String uploadFileName = uuid + "_" + originalFileName;

                File saveFile = new File(uploadPath, uploadFileName);

                try {
                    log.info("@# Saving file: " + saveFile.getAbsolutePath());
                    multipartFile.transferTo(saveFile);
                    log.info("@# File saved successfully: " + saveFile.exists());

                    attachDTO.setUuid(uuid);
                    attachDTO.setUploadPath(uploadFolder);
                    attachDTO.setFileName(originalFileName);
                    attachDTO.setReport_id(complainDTO.getReport_id()); // 여기서 report_id 설정

                    if (multipartFile.getContentType().startsWith("image")) {
                        attachDTO.setImage(true);
                        File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
                        log.info("@# Creating thumbnail: " + thumbnailFile.getAbsolutePath());
                        FileOutputStream thumbnail = new FileOutputStream(thumbnailFile);
                        // multipartFile.getInputStream() 대신 저장된 파일의 FileInputStream 사용
                        Thumbnailator.createThumbnail(new FileInputStream(saveFile), thumbnail, 100, 100);
                        thumbnail.close();
                        log.info("@# Thumbnail created successfully: " + thumbnailFile.exists());
                    }
                    log.info("@# Attaching file to DB: " + attachDTO); // attachDTO 내용 로깅
                    complainAttachDAO.insert(attachDTO);
                    log.info("@# File attachment DB insert successful.");
                } catch (IOException e) {
                    log.error("File upload error", e);
                }
            }
        }
        log.info("@# ComplainServiceImpl.complain_write() end");
    }


    @Override
    public ComplainDTO contentView(HashMap<String, String> param) {
        log.info("@# ComplainServiceImpl.contentView() start");
        ComplainDTO dto = complainDAO.contentView(param);
        if (dto != null) {
            List<ComplainAttachDTO> attachList = complainAttachDAO.findByReportId(dto.getReport_id());
            dto.setAttachList(attachList);
            log.info("@# attachList => " + attachList);
        }
        log.info("@# ComplainServiceImpl.contentView() end");
        return dto;
    }

    @Override
    public void complain_modify(HashMap<String, String> param) {
        complainDAO.complain_modify(param);
    }

    @Override
    public void complain_delete(HashMap<String, String> param) {
        log.info("@# ComplainServiceImpl delete()");
        log.info("@# report_id=>" + param.get("report_id"));
        int report_id = Integer.parseInt(param.get("report_id"));

        complainAttachDAO.deleteAll(report_id);
        complainDAO.complain_delete(param);
    }

    @Override
    public void addAnswer(HashMap<String, String> param) {
        complainDAO.updateAnswer(param);
    }

    @Override
    public ComplainDTO getComplainById(int reportId) {
        ComplainDTO dto = complainDAO.getComplainById(reportId);
        if (dto != null) {
            List<ComplainAttachDTO> attachList = complainAttachDAO.findByReportId(dto.getReport_id());
            dto.setAttachList(attachList);
        }
        return dto;
    }

    @Override
    public List<ComplainDTO> getComplainListByReporterName(String reporterName) {
        return complainDAO.getComplainListByReporterName(reporterName);
    }
}
