<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*"
	import="java.sql.*, java.io.*, java.util.*"
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

String i= String.valueOf(request.getParameter("i"));	//url을 통해 board_idx 넘겨받음
int idx=Integer.parseInt(i);
String title=multi.getParameter("title");
String content=multi.getParameter("contents");
Timestamp date=new Timestamp(System.currentTimeMillis());

//추가 사진 올라온경우
	
	Enumeration en= multi.getFileNames();
	while(en.hasMoreElements()){
		String elemName = (String) en.nextElement();
		String fileName=multi.getFilesystemName(elemName);
		
		sql="INSERT INTO file(board_idx, appendfile) VALUES(?,?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, idx);
		pstmt.setString(2, fileName);
		pstmt.executeQuery();
	}


sql="UPDATE board SET title=?, content=?, update_date=? WHERE board_idx=?";
pstmt=con.prepareStatement(sql);
pstmt.setString(1, title);
pstmt.setString(2, content);
pstmt.setTimestamp(3, date);
pstmt.setInt(4, idx);	

pstmt.executeUpdate();

if(pstmt != null) pstmt.close();
if(rs != null) rs.close();
if(con != null) con.close();

response.sendRedirect("main_after_login.jsp");
%>