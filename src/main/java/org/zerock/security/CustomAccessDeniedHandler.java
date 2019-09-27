package org.zerock.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import lombok.extern.log4j.Log4j;

// CustomAccessDeniedHandler는 AccessDeniedHandler 인터페이스를 직접구현합니다. 
// 직접적으로 서블릿 API를 이용하는 처리가 가능합니다.
@Log4j
public class CustomAccessDeniedHandler implements AccessDeniedHandler {

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		log.error("Access Denied Handler");

		log.error("Redirect.....");

		response.sendRedirect("/sample/accessError");
	}

}
