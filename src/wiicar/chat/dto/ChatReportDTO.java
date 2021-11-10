package wiicar.chat.dto;

import java.sql.Timestamp;

public class ChatReportDTO {
	private int reportnum;
	private String reportid;
	private String id;
	private String content;
	private int result;
	private Timestamp reg;
	public int getReportnum() {
		return reportnum;
	}
	public void setReportnum(int reportnum) {
		this.reportnum = reportnum;
	}
	public String getReportid() {
		return reportid;
	}
	public void setReportid(String reportid) {
		this.reportid = reportid;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getResult() {
		return result;
	}
	public void setResult(int result) {
		this.result = result;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	
}
