package org.zerock.controller;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.zerock.domain.SceduleCartVO;
import org.zerock.domain.ScheduleVO;
import org.zerock.service.SceduleService;

import lombok.Setter;

@Controller
@RequestMapping("/calendar/*")
public class MySceduleController {

	@Setter(onMethod_ = { @Autowired })
	private SceduleService service;

	@Setter(onMethod_ = { @Autowired })
	private SceduleCartVO cart;

	@Setter(onMethod_ = { @Autowired })
	private ScheduleVO sch;

	@RequestMapping("addItems")
	public void MoveTocart() {

	}

	@PostMapping("addTocart")
	public String addTocart(HttpServletRequest request, Model model) {
//		SceduleCartVO cart = new SceduleCartVO();
		int content_id = Integer.parseInt(request.getParameter("content_id"));
		String member_id = "USER00";
		cart.setContent_id(content_id);
		cart.setContentname(request.getParameter("contentname"));
		cart.setContenttypeid((Integer.parseInt(request.getParameter("contenttypeid"))));
		cart.setMember_id(member_id);

		// 동일한 아이템 중복add 방지 처리
		String result = service.chkItem(member_id, content_id);
		System.out.println("result :" + result);
		if (result != null) {
			model.addAttribute("result", result);
			return "/calendar/addItems";
		} else {
			int num = service.addTocart(cart);
			System.out.println("cart 내용" + cart);
			System.out.println("@@추가결과 : " + num);
			if (num == 1) {
				model.addAttribute("member_id", cart.getMember_id());
				return "redirect:/calendar/showCart";
			}
		}
		return null;
	}

	@GetMapping("showCart")
	public ModelAndView showCartList(HttpServletRequest request, Model model) {
		ModelAndView mv = new ModelAndView();

		String member_id = request.getParameter("member_id");
		// 아직 로그인 미구현으로 임시로 처리
		if (member_id == null) {
			member_id = "USER00";
		}
		List cartList = service.showCartList(member_id);
		System.out.println("@@@@카트 내용" + cartList);
		mv.addObject("userName", member_id);
		mv.addObject("cartList", cartList);

		mv.setViewName("/calendar/secart");
		return mv;
	}

	@GetMapping("cal")
	public ModelAndView showCal(Model model) {
		ModelAndView mv = new ModelAndView();
		// 달력생성
		final char[] calDays = { '일', '월', '화', '수', '목', '금', '토' };

		// 오늘
		LocalDate today = LocalDate.now();
		// 이달의 1일 셋팅
		LocalDate fristday = LocalDate.of(today.getYear(), today.getMonthValue(), 1);

		int frist = fristday.getDayOfWeek().getValue(); // 이달의 1일

		System.out.println("##오늘 : " + today);
		System.out.println("##fristDay : " + fristday);
		System.out.println("first : " + frist);

		sch.setSch_year(today.getYear());
		sch.setSch_month(today.getMonthValue());
		sch.setSch_day(frist);
		
		mv.setViewName("/calendar/cal");
		mv.addObject("year", today.getYear());
		mv.addObject("month", today.getMonthValue());
		mv.addObject("frist", frist);
		mv.addObject("lastday", today.lengthOfMonth());
		return mv;
	}

}
