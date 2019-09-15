package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.Setter;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Setter(onMethod_ = { @Autowired })
	private BoardService service;

	@GetMapping("/list")
	public void list(Criteria cri, Model model) {

		// 검색 처리에서 생기는 3가지 문제점
		// 1. 3페이지에서 보다가 검색을 하면 3페이로 해서 보여줌
		// 2. 검색후 페이지를 이동하면 검색조건이 사라짐
		// 3. 검색후 화면에서는 어떤 검색 조건과 키워를 이용했는지 알수없음
		// 그래서 검색할때 form태그에 페이지 번호 cri 포함하기 또하너 검색어 검색 타입도 모두 같이 전송함
		System.out.println("##타입 출력 : " + cri.getType());
		System.out.println("##키워드 출력 : " + cri.getKeyword());
		System.out.println("@@@타입어레이 출력" + cri.getTypeArr());
		// 페이지 번호와 각페이지 마다 보여줄 개수를 입력으로 넣어서
		// 게시판 리스트를 반환받음
		model.addAttribute("list", service.getList(cri));

		int total = service.getTotal(cri);
		System.out.println("총 게시글 개수 : " + total);
		// 페이지번호와 amount를 전달하여서 리스트 하단에 페이지버튼 생성
		model.addAttribute("pageMaker", new PageDTO(cri, total));

	}

	@GetMapping("/register")
	public void resiger() {

	}

	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
//		log.info(board);
		service.register(board);

		System.out.println("register확인 " + board);
		System.out.println("result값 출력 : " + board.getBno());
		rttr.addFlashAttribute("result", board.getBno());

		return "redirect:/board/list";
	}

	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		// @ModelAttribute는 파라메타로 넘겨준 타입의 오브젝틑 자동으로 생성해서 Model 객체에 추가하여서
		// jsp로 전달되고 괄호 안에 입력한 이름으로 jsp에서는 사용가능함
		// @ModelAttribute로 지정된 객체는 빈클래스여야하고 getter 와 setter 로 지정되어있어야함
		model.addAttribute("board", service.get(bno));
	}

	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}

		// 업데이트와 삭제후 리스트로 이동시 다시 그 페이지 번호로 이동하기 위해서
		// 여기서 cri 값 전달
		// 또한 검색 조건이 붙을 경우 검색하여 수정 삭제시 다시 그페이지로 이동하기위해서
		// redirect에 타입과 키워드또한 전달함
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("keyword", cri.getKeyword());
//		rttr.addAttribute("type", cri.getType());
		return "redirect:/board/list"+cri.getListLink();
	}

	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		if (service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
		}
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("keyword", cri.getKeyword());
//		rttr.addAttribute("type", cri.getType());
		return "redirect:/board/list"+cri.getListLink(); // 자동으로 URI 생성해서 전달 
	}

}
