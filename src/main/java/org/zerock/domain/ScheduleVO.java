package org.zerock.domain;

import lombok.Data;

@Data
public class ScheduleVO {
	private int sch_num;
	private int scecart_num;
	private String member_id;
	private int sch_year;
	private int sch_month;
	private int sch_day;
}
