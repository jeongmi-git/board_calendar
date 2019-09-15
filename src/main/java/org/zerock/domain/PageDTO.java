package org.zerock.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {

	// 페이지 전환을 위한 클래스
	private int startPage;
	private int endPage;
	private boolean prev, next;

	private int total;
	private Criteria cri;

	public PageDTO(Criteria cri, int total) {
		// 생성자를 통해서 페이지 번호와 한페이지당 보여줄 개수를 입력받음
		// 최종 글 개수 또한 입력받음
		// 여기서 클래스에서 페이지를 수행할 기능을 정의함 
		this.cri = cri;
		this.total = total;
		System.out.println("###total :"+total);
		// 끝나는 페이지를 먼저 지정함 이렇게 하면 시작 페이지는 마지막 페이지에서 -9하면됨
		// 끝나는 페이지는 페이지 번호가 10 이상이면 끝나는 페이지는 20임
		// 여기서 ceil 메소드는 반올림을 시켜줘서 1.1 ->2로 만들어줌
		this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;
		System.out.println("endPage :"+this.endPage);
		

		this.startPage = this.endPage - 9;
		System.out.println("startpage :"+this.startPage);

		// 실질 데이터의 개수에 맞게 마지막 페이지를 지정함
		// 그래서 예를 들어 데이터가 80 개면 총 페이지수는 8까지만 보여주게함
		int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));
		System.out.println("realEnd :"+realEnd);

		// 만약 실질 보여줄 마지막 페이지수가 계산되서 나온 페이지 수보다 큰경우에는
		// 여기서 치환해줌
		if (realEnd < this.endPage) {
			this.endPage = realEnd;
		}

		// 이전페이지 보기 : 만약 startpage가 1보다 큰경우 생성됨
		this.prev = this.startPage > 1;

		// 다음페이지 보기 : 만약 실질 마지막 페이지가 endpage보다 큰경우 다음페이지를 보여줌
		this.next = this.endPage < realEnd;
		
		System.out.println("startpage :"+this.startPage);
		System.out.println("endPage :"+this.endPage);
		System.out.println("realEnd :"+realEnd);
		
	}

	// 페이징 하는법 
	// 우선 페이지번호와 한번에 보여줄 페이지 수를 선언한 클래스를 정의하고
	// 그다음으로는 PageDTO를 정의해서 시작페이지와 마지막페이지 그리고 실질적으로 데이터 개수에 맞게 보여줄 
	// 실질 마지막 페이지변수와 리스트 총개수를 담는 변수를 선언해줍니다.
	// 또한 이전과 다음 버튼을 생성해줄 변수 또한 생성합니다.
	// 그리고 jsp페이지에서 전달된 페이지수와 한번에 보여줄 개수를 파라메타로 전달받아서
	// 컨트롤러에서 getList에서 이 두개의파라메타를 전달해주고 SQL문에서는 inline view를 사용하여서
	// Mapper.xml에서는 우선적으로 index를 이용해서 pk를 내림차순으로 전달받은 페이지수에 한페이지에 보여줄 개수를 곱하고
	// 그렇게 select된 데이터에서 2차적으로 Select문에 where 조건문에 페이지번호-1하고 페이지당 보여줄개수를 곱해서
	// 페이지 번호가 2일경우 10개 이상부터20개 이하의 데이터를 출력할수있게 합니다.
	// 그리고 페이지번호를 생성하기위해서
	// 페이지번호와 보여줄개수 와 리스트의 총개수를 입력으로 전달하여서 시작페이지와 마지막 페이지 그리고 이전 이후 버튼을 생성합니다.
	
	
	
}
