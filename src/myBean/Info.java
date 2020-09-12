package myBean;

public class Info {
	private String text;
	private String pwd;
	private String textarea;
	private String color;
	private String date;
	private String range;
	private String number;
	private String []checkbox;
	private String radio;
	private String select;
	public void setText(String a) {
		this.text = a;
	}
	public void setPwd(String a) {
		this.pwd = a;
	}
	public void setTextarea(String a) {
		this.textarea = a;
	}
	public void setColor(String a) {
		this.color = a;
	}
	public void setDate(String a) {
		this.date = a;
	}
	public void setRange(String a) {
		this.range = a;
	}
	public void setNumber(String a) {
		this.number = a;
	}
	public void setCheckbox(String[] a) {
		this.checkbox = a;
	}
	public void setRadio(String a) {
		this.radio = a;
	}
	public void setSelect(String a) {
		this.select = a;
	}
	public String getText() {
		return text;
	}
	public String getPwd() {
		return pwd;
	}
	public String getTextarea() {
		return textarea;
	}
	public String getColor() {
		return color;
	}
	public String getDate() {
		return date;
	}
	public String getRange() {
		return range;
	}
	public String getNumber() {
		return number;
	}
	public String[] getCheckbox() {
		return checkbox;
	}
	public String getRadio() {
		return radio;
	}
	public String getSelect() {
		return select;
	}
}
