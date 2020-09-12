<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*"
    import="java.sql.*, java.io.*"%>
<%
request.setCharacterEncoding("utf-8");

Class.forName("org.mariadb.jdbc.Driver");
String DB_URL = "jdbc:mariadb://localhost:3306/snsboard?useSSL=false";
String DB_USER = "admin";
String DB_PASSWORD= "1234";

ServletContext context = getServletContext();
String realFolder = context.getRealPath("upload");	

int maxsize = 1024*1024*5;

try {
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxsize, "utf-8", new DefaultFileRenamePolicy());

	String id = multi.getParameter("id");
	String name = multi.getParameter("name");
	String pwd = multi.getParameter("pwd");
	String fileName=null;
	Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);	
	PreparedStatement pstmt=null;
	//아이디 중복 검사
	String sql2="SELECT * FROM user";
	PreparedStatement pstmt2=con.prepareStatement(sql2);
	ResultSet rs=pstmt2.executeQuery();
	boolean aaa=true;
	while(rs.next()){
		String dbId=rs.getString("user_id");
		if(dbId.equals(id)){
			aaa=false;
			out.println("<script>alert('이미 존재하는 아이디 입니다!'); location.href='user_add.jsp';</script>");
		}
	}
	if(aaa){
		if(multi.getParameter("fileName")==null){	//프로필사진 따로 업로드 안하면
			fileName="face1.png";	//기본 사진으로
		}else{
			fileName = multi.getFilesystemName("fileName");
		}

		String sql = "INSERT INTO user(user_id, user_name, user_password, profile) VALUES(?,?,?,?)";
		
		pstmt = con.prepareStatement(sql);

		pstmt.setString(1, id);
		pstmt.setString(2, name);
		pstmt.setString(3, pwd);
		pstmt.setString(4, fileName);

		pstmt.executeQuery();
		pstmt.close();
		con.close();
		response.sendRedirect("main.jsp");
	}
		
	rs.close();
	pstmt2.close();
	con.close();

} catch(IOException e) { 
	out.println(e);
	return;
} catch(SQLException e) {
	out.println(e);
	return;
}
%>