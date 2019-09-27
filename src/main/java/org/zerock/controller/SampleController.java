package org.zerock.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@RequestMapping("/sample/*")
@Controller
@Log4j
public class SampleController {

	@GetMapping("/all")
	public void doAll() {
		System.out.println("for all users");
	}

	@GetMapping("/member")
	public void doMember() {
		System.out.println("for memebers");
	}

	@GetMapping("/admin")
	public void doAdmin() {
		System.out.println("for admin");
	}

	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		log.info("access Denied : " + auth);
		model.addAttribute("msg", "Access Denied");
	}

	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		log.info("error :" + error);
		log.info("logout :" + logout);

		if (error != null) {
			model.addAttribute("error", "Login Error check your account");
		}
		if (logout != null) {
			model.addAttribute("logout", "Logout!!");
		}
	}

	@GetMapping("/customLogout")
	public void logoutGET() {
		log.info("custom logout");
	}

	@PostMapping("/customLogout")
	public void logoutPOST() {
		log.info("post custom Logout");
	}
}
