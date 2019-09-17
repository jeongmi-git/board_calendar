package org.zerock.service;

import java.util.List;

import org.zerock.domain.SceduleCartVO;

public interface SceduleService {
	
	// 카트에 추가
	public int addTocart(SceduleCartVO cart);
	
	// 카트에있는 아이템 보기
	public List<SceduleCartVO> showCartList(String member_id);
	
	// 카트 중복체크 
	public String chkItem(String member_id, int content_id);
	}
