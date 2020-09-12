<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*"
	import="java.sql.*, java.io.*"%>
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

String i= String.valueOf(request.getParameter("i"));	//url로 부터 삭제할 file_idx 받아옴
int idx=Integer.parseInt(i);
try{
	sql="SELECT * FROM file WHERE file_idx=?";
	pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, idx);

	rs=pstmt.executeQuery();
	rs.next();
	String oldFileName=rs.getString("appendfile");
	int bidx=rs.getInt("board_idx");	//리다이렉트 할 보드 인덱스 받아옴

	File oldFile = new File(realFolder+"\\"+ oldFileName);
	oldFile.delete();

	sql="DELETE FROM file WHERE file_idx=?";
	pstmt=con.prepareStatement(sql);
	pstmt.setInt(1, idx);
	pstmt.executeUpdate();

	if(pstmt != null) pstmt.close();
	if(rs != null) rs.close();
	if(con != null) con.close();
	
	//삭제 끝나면 다시 원래 modify?i=.jsp로 넘김
	response.sendRedirect("modify.jsp?i="+bidx);

}catch(Exception e){
	out.println(e.toString());
	return;
}


%>