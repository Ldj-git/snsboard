<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, java.io.*, java.util.*"
    import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*"%>
<!DOCTYPE html>
<%
request.setCharacterEncoding("utf-8");

Class.forName("org.mariadb.jdbc.Driver");
String DB_URL="jdbc:mariadb://localhost:3306/snsboard?useSSL=false";
String DB_USER = "admin";
String DB_PASSWORD= "1234";

Connection con=null;
PreparedStatement pstmt=null;
ResultSet rs=null;

ServletContext context = getServletContext();
String realFolder = context.getRealPath("upload");

int maxsize = 1024*1024*5;

try{
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxsize, "utf-8", new DefaultFileRenamePolicy());
	String title = multi.getParameter("title");
	String content = multi.getParameter("contents");
	//String fileName=multi.getFilesystemName("picture");
	String user_idx= String.valueOf(session.getAttribute("user_idx"));
	
	Timestamp date= new Timestamp(System.currentTimeMillis());
	
	con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
	
	String sql= "INSERT INTO board(user_idx,title,content,add_date) VALUES(?,?,?,?)";
	pstmt = con.prepareStatement(sql);

	//8. pstmt의 SQL 쿼리 구성
	pstmt.setString(1, user_idx);
	pstmt.setString(2, title);
	pstmt.setString(3, content);
	pstmt.setTimestamp(4, date);

	//9. 쿼리 실행
	pstmt.executeQuery();
	
	//다중파일 이름 file 에 저장
	sql="SELECT board_idx FROM board ORDER BY board_idx DESC"; //방금 올라간 글의 board_idx 받기 내림차순으로 해서 최근에 한게 가장 위에 있음
	pstmt = con.prepareStatement(sql);
	rs=pstmt.executeQuery();
	rs.next();
	int board_idx = rs.getInt("board_idx");
	
	Enumeration en= multi.getFileNames();
	while(en.hasMoreElements()){
		String elemName = (String) en.nextElement();
		String fileName=multi.getFilesystemName(elemName);
		
		sql="INSERT INTO file(board_idx, appendfile) VALUES(?,?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, board_idx);
		pstmt.setString(2, fileName);
		pstmt.executeQuery();
	}
	
	rs.close();
	pstmt.close();
	con.close();

}catch(IOException e) { 
	out.println(e);
	return;
} catch(SQLException e) {
	out.println(e);
	return;
}
catch(Exception e){
	out.println(e);
	return;
}
response.sendRedirect("main_after_login.jsp");
%>