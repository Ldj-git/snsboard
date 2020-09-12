<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%
request.setCharacterEncoding("utf-8");
if(session.getAttribute("user_idx")==null){	//로그아웃된 상태로 접근하면 원래 메인으로
	response.sendRedirect("main.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sns 게시판 홈</title>
<link rel="stylesheet" type="text/css" href="default.css">

</head>

<body>

<header>
	<img src="images/home.png" width=80px; usemap="#homemap">
	<map name="homemap">
		<area shape="rect" coords="0,0,682,682" href="main.jsp">
	</map>
</header>

<nav>
	<div class="idpw">
	<img src="./upload/<%=session.getAttribute("profile")%>" width="50" height="50">
	<%=session.getAttribute("name") %>님<br>&nbsp;&nbsp;&nbsp;&nbsp; 환영합니다.
	<input type="button" value="로그아웃" onclick="location.href='logout.jsp'">
	</div>
	
	<ul class="menu" >
		<li><a href="search.jsp">검색</a></li>
		<li><a href="popular.jsp">인기글 모음</a></li>
		<li><a href="input.jsp">글 작성</a></li>
		<li><a href="myboard.jsp">내가 쓴 글</a></li>
		<li><a href="user_modify.jsp">회원 정보 수정</a></li>
	</ul>
</nav>
<%
String i= String.valueOf(request.getParameter("i"));	//url을 통해 board_idx 넘겨받음
int idx=Integer.parseInt(i);

try{
Class.forName("org.mariadb.jdbc.Driver");
String DB_URL="jdbc:mariadb://localhost:3306/snsboard?useSSL=false";

Connection con=null;
PreparedStatement pstmt=null;
ResultSet rs=null;

con=DriverManager.getConnection(DB_URL,"admin","1234");

String sql="SELECT * FROM board WHERE board_idx=?";
pstmt=con.prepareStatement(sql);
pstmt.setInt(1, idx);

rs= pstmt.executeQuery();
rs.next();

String u1=rs.getString("user_idx");
String u2=String.valueOf(session.getAttribute("user_idx"));
if(!u1.equals(u2)){	//만약 현재 로그인한 계정의 글이 아닌데 주소창에 값 바꿔서 들어온 경우 다시 메인화면으로 리다이렉트
	response.sendRedirect("main_after_login.jsp");
}
%>
<article>
	<form action="modify_do.jsp?i=<%=idx%>" method ="post" enctype="multipart/form-data">
<fieldset style="margin:5%;">
	<legend>게시글 수정</legend>
	제목 : <br><input type="text" name="title" size="100" maxlength="70" value="<%=rs.getString("title")%>"><br><br>
	내용 : <br><textarea cols="100" rows="10" name="contents"><%=rs.getString("content") %></textarea><br><br>
<%
PreparedStatement pstmt2 = null;
ResultSet rs2=null;
int b=rs.getInt("board_idx");
String sql2 = "SELECT * FROM file WHERE board_idx='"+idx+"';";
pstmt2 = con.prepareStatement(sql2);
rs2 = pstmt2.executeQuery();
while(rs2.next()){
	if(rs2.getString("appendfile")!=null){
%>
<img id="수정사진" src="./upload/<%=rs2.getString("appendfile") %>" > 
<span id="삭제버튼" onclick="if(confirm('정말로 삭제하겠습니까?')){location.href='delete_file_do.jsp?i=<%=rs2.getInt("file_idx") %>'}" ">삭제</span>
&nbsp;&nbsp;&nbsp;
<%
	}
}
%>

<script>
i=0;
function inputAdder(){
	var obj=document.getElementById("append");
	var brObj=document.createElement("br");
	brObj.setAttribute("id", "br"+i);
	var inputObj = document.createElement("input");
	inputObj.setAttribute("type","file");
	inputObj.setAttribute("name","picture"+i);
	inputObj.setAttribute("id","picture"+i);
	var deleteObj = document.createElement("input");
	deleteObj.setAttribute("type", "button");
	deleteObj.setAttribute("onclick","inputRemover("+i+")");
	deleteObj.setAttribute("id","d"+i);
	deleteObj.setAttribute("value", "삭제");
	obj.appendChild(inputObj);
	obj.appendChild(deleteObj);
	obj.appendChild(brObj);
	i++;
}
function inputRemover(k){
	var obj=document.getElementById("append");
	var d=document.getElementById("picture"+k);
	var c=document.getElementById("d"+k);
	var br=document.getElementById("br"+k);
	//obj.removeChild(obj.childNodes[k+6]);
	obj.removeChild(d);
	obj.removeChild(br);
	obj.removeChild(c);
}
function elemChecker(k){
	var cnt = k.elements.length;
	var filecnt=1;
	for(i=0;i<cnt;i++){
		if(k.elements[i].type=="file"){
			if(k.elements[i].value==""){
				var msg = filecnt + "번째 파일 첨부칸에 아무것도 없습니다.\n추가로 첨부할 사진이 없다면 삭제버튼을 눌러주세요.";
				alert(msg);
				return;
			}
			filecnt++;
		}
	}
	k.submit();
}
</script>
	<div id="append">
	<input type="button" onclick="inputAdder()" value="추가 사진 첨부 버튼 늘리기"><br>
	</div>
</fieldset>
<p style="float:right; margin:0px;"><input type="button" value="저 장 " onclick="elemChecker(this.form)"></p>
</form>
</article>
<%
rs2.close();
pstmt2.close();
rs.close();
pstmt.close();
con.close();

}catch(Exception e){	//만약 주소뒤에 인덱스바꿔서 존재하지 않는 글을 변경하려고 접근할 시 출력되는 메시지
%>
<article>
<div>접근할 수 없는 주소 입니다!!<br> <% out.println(e.toString());%></div></article>
<%
}
%>
</body>
</html>