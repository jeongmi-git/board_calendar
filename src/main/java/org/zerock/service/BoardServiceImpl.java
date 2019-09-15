package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.Setter;

@Service // 비즈니스 영역을 담당하는 객체임을 표시하기 위해서 서비스 어노테이션 선언
public class BoardServiceImpl implements BoardService {

	// 오토와이어 또는 셋터 어노테이션으로 주입시킬수있음
	@Setter(onMethod_ = { @Autowired })
	private BoardMapper mapper;

	@Override
	public void register(BoardVO board) {

		mapper.insertSelectKey(board);
	}

	@Override
	public BoardVO get(Long bno) {
		// TODO Auto-generated method stub
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		// TODO Auto-generated method stub
		return mapper.update(board) == 1;
	}

	@Override
	public boolean remove(Long bno) {
		// TODO Auto-generated method stub
		return mapper.delete(bno) == 1;
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		
		return mapper.getTotalCount(cri);
	}

}
