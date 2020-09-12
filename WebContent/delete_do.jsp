<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*"
	import="java.sql.*, java.io.*"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8");

Class.forName("org.mariadb.jdbc.Driver");
String DB_URL="jdbc:mariadb://localhost:3306/snsboard?useSSL=false";

Connection con = DriverManager.getConnection(DB_URL,"admin", "1234");
PreparedStatement pstmt=null;
ResultSet rs=null;
String sql=null;

String i= String.valueOf(request.getParameter("i"));	//url을 통해 board_idx 넘겨받음
int idx=Integer.parseInt(i);

try {
	sql = "SELECT * FROM file WHERE board_idx=?";
	pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, idx);
	rs = pstmt.executeQuery();
	while(rs.next()){
		String filename = rs.getString("appendfile"); 
		ServletContext context = getServletContext();
		String realFolder = context.getRealPath("upload");
		int file_idx=rs.getInt("file_idx");
		File file = new File(realFolder +"\\"+filename);
		file.delete();
		
		/* //column 값 on delete cascade 여서 필요 없어짐
		sql="DELETE FROM file WHERE file_idx=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, file_idx);
		pstmt.executeUpdate();*/
	}
	
	sql = "DELETE FROM board WHERE board_idx=?";
	pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, idx);
	pstmt.executeQuery();
	
	rs.close();
	pstmt.close();
	con.close();
} catch (SQLException e) {
	//SQL에 대한 오류나, DB 연결 오류 등이 발생하면, 그 대처 방안을 코딩해 준다.
	out.println(e.toString());
	return;
} catch (Exception e) { 
	//SQLException 이외의 오류에 대한 대처 방안을 코딩해 준다.
	out.println(e.toString());
	return;
}

response.sendRedirect("main_after_login.jsp");
%>