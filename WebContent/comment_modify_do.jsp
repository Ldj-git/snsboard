<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, java.io.*"%>
<!DOCTYPE html>
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

String c= String.valueOf(request.getParameter("c"));	//url로 부터 comment_idx 받아옴
int comment_idx=Integer.parseInt(c);

String i=String.valueOf(request.getParameter("i"));
int board_idx=Integer.parseInt(i);

Timestamp date=new Timestamp(System.currentTimeMillis());
//try{	
	sql="UPDATE comment SET content=?, update_date=? WHERE comment_idx=?";
	pstmt=con.prepareStatement(sql);
	pstmt.setString(1, request.getParameter("comment"));
	pstmt.setTimestamp(2, date);
	pstmt.setInt(3, comment_idx);
	pstmt.executeQuery();
	

	if(pstmt != null) pstmt.close();
	if(rs != null) rs.close();
	if(con != null) con.close();
	
	//삭제 끝나면 이전 패이지로
	response.sendRedirect("detailed_article.jsp?i="+board_idx);

//}catch(Exception e){
	//out.println(e.toString());
	//return;
//}


%>