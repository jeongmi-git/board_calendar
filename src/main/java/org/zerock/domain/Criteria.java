package org.zerock.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {

	// 페이징 처리 하기 위한 객체
	private int pageNum; // 페이지 번호
	private int amount; // 한페이당 보여줄 개수

	// 검색을 위한 타입과 키워드 지정
	private String type;
	private String keyword;

	// 얘가 없으면 에러남 (이유? 처음에 리스트로 이동시 디폴트로 보여줄게 필요함 이거 없으면 List부르는 부분 Controller cri값을
	// 전달받지 못해서 바로 400 error)
	public Criteria() {
		this(1, 10);
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}

	// myBatis 동적 태그 활용하기 위해서 배열로 처리
	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}

	// uri 를 생성해서 리턴해줌
	// URI를 동적으로 생성해주는 클래스다. 파라미터가 조합된 URI를 손쉽게 만들어 주어서 코드상에서 직접 문자열을 조합할 때 생기는 실수를
	// 방지할 수 있다.
	// UriComponents를 사용하면 파라미터 값을 지정하거나 변경하는 일이 쉬워진다.
	// 내가 원하는 URI로 각각의 링크를 생성할 수 있어서 Rest 스타일로 개발하는데 편리하다. 
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("").queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount()).queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());

		return builder.toUriString();
	}
}
