package org.zerock.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/uploadFile/*")
public class UploadController {
	// 이미지 게시판 만들때는 항상
	// 이미지의 경로 처리와 중복이름 처리
	
	@GetMapping("/uploadForm")
	public void uploadForm() {
		System.out.println("uploadForm");

	}
	// 스프링에서 제공하는 MultipartFile타입을 사용해서 화면에
	// 여러개의 첨부파일을 선택할수있으므로 배열 타입으로 설정한 후 파일 업로드

	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {

		String uploadFolder = "C:\\upload";

		for (MultipartFile multipartFile : uploadFile) {
			System.out.println("업로드 파일 이름 : " + multipartFile.getOriginalFilename());
			System.out.println("파일 사이즈  : " + multipartFile.getSize());

			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());

			try {
				// transferTo 파일저장
				multipartFile.transferTo(saveFile);
			} catch (IllegalStateException | IOException e) {
				System.out.println("파일 업로드 실패" + e.getMessage());
				e.printStackTrace();
			}

		}
	}

	@GetMapping("/uploadAjax")
	public void uploadAjax() {

	}

	// File.separator 파일을 구분하는 구분자
	// 파일을 경로를 저장할경우 원도우와 리눅스의 경로부분이 다른데
	// 그래서 이러한 번거로움을 없애기 위해서
	// 특정 위치에 파일을 생성하거나 조작하기위해서
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}

	@PostMapping("uploadAjaxAction")
	public void uploadAjaxPost(MultipartFile[] uploadFile) {

		String uploadFolder = "C:\\upload";

		// 폴더 생성(오늘 날짜의 경로로 문자열 생성)
		File uploadPath = new File(uploadFolder, getFolder());
		System.out.println("파일 업로드 위치 : " + uploadPath);
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		for (MultipartFile multipartFile : uploadFile) {
			System.out.println("업로드 파일 이름 : " + multipartFile.getOriginalFilename());
			System.out.println("파일 사이즈  : " + multipartFile.getSize());

			String uploadFileName = multipartFile.getOriginalFilename();

			// IE 는 Path가 다름
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);

			// uuid.randomuuid로 임의값 생성 
			// 원래파일과 구분할수 있도록 중간에 _룰 추가함 
			UUID uuid = UUID.randomUUID();

			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			File saveFile = new File(uploadFolder, uploadFileName);

			try {
				multipartFile.transferTo(saveFile);
			} catch (Exception e) {
				System.out.println(e.getMessage());
				e.printStackTrace();
			}

		}
	}

}
