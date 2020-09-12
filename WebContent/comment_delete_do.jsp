<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, java.io.*"
    %>
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

String i= String.valueOf(request.getParameter("i"));	//url로 부터 삭제할 comment_idx 받아옴
int idx=Integer.parseInt(i);

String b= String.valueOf(request.getParameter("b"));	//url로 부터 board_idx 받아옴
int board_idx=Integer.parseInt(b);

//try{
	sql="DELETE FROM comment WHERE comment_idx=?";
	pstmt=con.prepareStatement(sql);
	pstmt.setInt(1, idx);
	pstmt.executeUpdate();
	
	//댓글 카운터 가져오기
	sql="SELECT comment_num FROM board WHERE board_idx="+b+";";
	rs=pstmt.executeQuery(sql);
	rs.next();
	int counter = rs.getInt("comment_num");
	counter--;

	//댓글 카운터 감소시킨거 적용
	sql="UPDATE board SET comment_num=? WHERE board_idx=?;";
	pstmt=con.prepareStatement(sql);
	pstmt.setInt(1, counter);
	pstmt.setInt(2, board_idx);
	pstmt.executeQuery();
	

	if(pstmt != null) pstmt.close();
	if(rs != null) rs.close();
	if(con != null) con.close();
	
	//삭제 끝나면 이전 패이지로
	response.sendRedirect(request.getHeader("Referer"));

//}catch(Exception e){
	//out.println(e.toString());
	//return;
//}


%>