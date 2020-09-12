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

ServletContext context=getServletContext();
String realFolder = context.getRealPath("upload");

int maxsize=1024*1024*5;

MultipartRequest multi=new MultipartRequest(request, realFolder, maxsize, "utf-8", new DefaultFileRenamePolicy());

String i= String.valueOf(session.getAttribute("user_idx"));
int idx=Integer.parseInt(i);
String id=multi.getParameter("id");
String name=multi.getParameter("name");
String pwd=multi.getParameter("pwd");
String fileName=multi.getFilesystemName("fileName");

if(fileName!=null){	//변경할 사진 올라온경우
	sql="SELECT profile FROM user WHERE user_idx=?";
	pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, idx);
	
	rs=pstmt.executeQuery();
	rs.next();
	String oldFileName=rs.getString("profile");
	
	File oldFile = new File(realFolder+"\\"+ oldFileName);
	oldFile.delete();
	
	sql="UPDATE user SET user_id=?, user_name=?, user_password=?, profile=? WHERE user_idx=?";
	pstmt=con.prepareStatement(sql);
	pstmt.setString(1, id);
	pstmt.setString(2, name);
	pstmt.setString(3, pwd);
	pstmt.setString(4, fileName);
	pstmt.setInt(5, idx);	
	session.setAttribute("profile", fileName);
}else{	//변경할 사진 업는 경우
	sql="UPDATE user SET user_id=?, user_name=?, user_password=? WHERE user_idx=?";
	pstmt=con.prepareStatement(sql);
	pstmt.setString(1, id);
	pstmt.setString(2, name);
	pstmt.setString(3, pwd);
	pstmt.setInt(4, idx);
}
pstmt.executeUpdate();
session.setAttribute("name", name);


if(pstmt != null) pstmt.close();
if(rs != null) rs.close();
if(con != null) con.close();

response.sendRedirect("main_after_login.jsp");
%>