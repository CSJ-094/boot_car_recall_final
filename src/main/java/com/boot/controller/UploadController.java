package com.boot.controller;

import com.boot.dto.BoardAttachDTO;
import com.boot.service.UploadService;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@Slf4j
public class UploadController {

	@Autowired
	private UploadService service;

//	이미지 여부 체크
	public boolean checkImageType(File file) {
		try {
//			이미지파일인지 체크하기 위한 타입(probeContentType)
			String contentType = Files.probeContentType(file.toPath());
			log.info("@# contentType=>"+contentType);

//			probeContentType 메소드 버그로 로직 추가
			if (contentType == null) {
				return false;
			}

//			startsWith : 파일종류 판단
			return contentType.startsWith("image");//참이면 이미지파일
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;//거짓이면 이미지파일이 아님
	}

	@PostMapping("/uploadAjaxAction")
	public ResponseEntity<List<BoardAttachDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		log.info("@# uploadAjaxPost()");

		List<BoardAttachDTO> list = new ArrayList<BoardAttachDTO>();

		for (MultipartFile multipartFile : uploadFile) {
			log.info("==============================)");
			log.info("@# 업로드 되는 파일 이름=>"+multipartFile.getOriginalFilename());
			log.info("@# 업로드 되는 파일 크기=>"+multipartFile.getSize());

			String uploadFileName = multipartFile.getOriginalFilename();

			UUID uuid = UUID.randomUUID();
			log.info("@# uuid=>"+uuid);

			BoardAttachDTO boardAttachDTO = new BoardAttachDTO();
			boardAttachDTO.setFileName(uploadFileName);
			boardAttachDTO.setUuid(uuid.toString());
			log.info("@# boardAttachDTO=>"+boardAttachDTO);

			File saveFile = new File(uploadFileName);

//			참이면 이미지 파일
			if (checkImageType(saveFile)) {
				boardAttachDTO.setImage(true);
			}
			list.add(boardAttachDTO);
		}

		return new ResponseEntity<List<BoardAttachDTO>>(list, HttpStatus.OK);
	}

//	날짜별 폴더 생성
	public String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date=new Date();
		String str = sdf.format(date);
		log.info("@# str=>"+str);

		return str;
	}

//	ajax 콜백으로 2개 탈때 ResponseEntity 같이 안쓰면 오류 발생
	@PostMapping("/uploadFolder")
//	public String uploadFolder(MultipartFile[] uploadFile) {
	public ResponseEntity<String> uploadFolder(MultipartFile[] uploadFile) {
		log.info("@# uploadFolder()");
		log.info("@# uploadFile=>"+uploadFile);

		List<BoardAttachDTO> list = new ArrayList<BoardAttachDTO>();
		String uploadFolder = "C:\\temp3\\upload";
		//	날짜별 폴더 생성
		String uploadFolderPath = getFolder();
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		log.info("@# uploadPath=>"+uploadPath);

		if (uploadPath.exists() == false) {
			// make yyyy/MM/dd folder
			uploadPath.mkdirs();
		}

		for (MultipartFile multipartFile : uploadFile) {
			log.info("==============================)");
			log.info("@# 업로드 되는 파일 이름=>"+multipartFile.getOriginalFilename());
			log.info("@# 업로드 되는 파일 크기=>"+multipartFile.getSize());

			String uploadFileName = multipartFile.getOriginalFilename();

			UUID uuid = UUID.randomUUID();
			log.info("@# uuid 02=>"+uuid);

			BoardAttachDTO boardAttachDTO = new BoardAttachDTO();
			boardAttachDTO.setFileName(uploadFileName);
			boardAttachDTO.setUuid(uuid.toString());
			boardAttachDTO.setUploadPath(uploadFolderPath);
			log.info("@# boardAttachDTO 02=>"+boardAttachDTO);

			uploadFileName = uuid.toString() + "_" + uploadFileName;
			log.info("@# uploadFileName=>"+uploadFileName);

//			saveFile : 경로하고 파일이름
			File saveFile = new File(uploadPath, uploadFileName);
			FileInputStream fis=null;

			try {
//				transferTo : saveFile 내용을 저장
				multipartFile.transferTo(saveFile);

//				참이면 이미지 파일
				if (checkImageType(saveFile)) {
					boardAttachDTO.setImage(true);
					log.info("@# boardAttachDTO 03=>"+boardAttachDTO);

					fis = new FileInputStream(saveFile);

//					썸네일 파일은 s_ 를 앞에 추가
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_"+uploadFileName));
//					썸네일 파일 형식을 100/100 크기로 생성
					Thumbnailator.createThumbnail(fis, thumbnail, 100, 100);
					thumbnail.close();
				}

				service.insertFile(boardAttachDTO);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				try {
					if (fis != null) fis.close();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
		} // end of for

//		return "File Uploaded!";
		return new ResponseEntity<String>("File Uploaded!", HttpStatus.OK);
	}

	@GetMapping("/getFileList")
	public ResponseEntity<List<BoardAttachDTO>> getFileList(@RequestParam HashMap<String, String> param) {
		log.info("@# getFileList()");
		log.info("@# boardNo=>"+param.get("boardNo"));

		List<BoardAttachDTO> list = service.getFileList(Integer.parseInt(param.get("boardNo")));
		log.info("@# list=>"+list);

		return new ResponseEntity<>(list, HttpStatus.OK);
	}

//	이미지파일을 받아서 화면에 출력(byte 배열타입)
	@GetMapping("/display")
	public ResponseEntity<byte[]> getImage(String fileName) {
		log.info("@# getImage()");
		log.info("@# fileName=>"+fileName);

		File file = new File("C:\\temp3\\upload\\"+fileName);
		log.info("@# file=>"+file);

		ResponseEntity<byte[]> result=null;
		HttpHeaders headers = new HttpHeaders();

		try {
//			파일타입을 헤더에 추가
			headers.add("Content-Type", Files.probeContentType(file.toPath()));
//			파일정보를 byte 배열로 복사+헤더정보+http상태 정상을 결과에 저장
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
	@GetMapping("/download")
	public ResponseEntity<Resource> download(String fileName) {
		log.info("@# download()");
		log.info("@# fileName=>"+fileName);

//		파일을 리소스(자원)로 변경. 파일을 비트값으로 전환
		Resource resource = new FileSystemResource("C:\\temp3\\upload\\"+fileName);
		log.info("@# resource=>"+resource);

//		리소스에서 파일명을 찾아서 변수에 저장
		String resourceName = resource.getFilename();

//		uuid 를 제외한 파일명
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_")+1);
		HttpHeaders headers = new HttpHeaders();

		try {
//			헤더에 파일다운로드 정보 추가
			headers.add("Content-Disposition", "attachment; filename="
					+ new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1"));
		} catch (Exception e) {
			e.printStackTrace();
		}

//		윈도우 다운로드시 필요한 정보(리소스, 헤더, 상태OK)
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String uuid) {
		log.info("@# deleteFile() uuid => " + uuid);


		BoardAttachDTO attach = service.findByUuid(uuid);
		List<BoardAttachDTO> list = new ArrayList<>();
		list.add(attach);


		service.deleteFile(list);
		service.deleteFileDB(uuid);

		return new ResponseEntity<>("success", HttpStatus.OK);
	}
}
















