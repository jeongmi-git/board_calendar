package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.SceduleCartVO;
import org.zerock.mapper.SceduleMapper;

import lombok.Setter;
@Service
public class SceduleServiceImpl implements SceduleService{

	@Setter(onMethod_= {@Autowired})
	private SceduleMapper mapper;
	
	
	@Override
	public int addTocart(SceduleCartVO cart) {
		return mapper.addCart(cart);
	}


	@Override
	public List<SceduleCartVO> showCartList(String member_id) {
		return mapper.showCart(member_id);
	}


	@Override
	public String chkItem(String member_id, int content_id) {
		
		return mapper.chkItem(member_id,content_id);
	}

}
