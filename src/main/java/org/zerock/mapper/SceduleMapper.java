package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.SceduleCartVO;

public interface SceduleMapper {

	public int addCart(SceduleCartVO cart);
	
	public List<SceduleCartVO> showCart(String member_id);
	
	public String chkItem(@Param("member_id") String member_id, @Param("content_id") int content_id);
}
