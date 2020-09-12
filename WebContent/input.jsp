<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
if(session.getAttribute("user_idx")==null){	//로그아웃되면 원래 메인으로
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
	<%=session.getAttribute("name") %>님<br> &nbsp;&nbsp;&nbsp;&nbsp; 환영합니다.
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
				var msg = filecnt + "번째 파일 첨부칸에 아무것도 없습니다.\n첨부할 사진이 없다면 삭제버튼을 눌러주세요.";
				alert(msg);
				return;
			}
			filecnt++;
		}
	}
	k.submit();
} 


</script>

<article>
	<form action="input_do.jsp" method ="post" enctype="multipart/form-data">
<fieldset style="margin:5%;">
	<legend>게시글 작성</legend>
	제목 : <br><input type="text" name="title" size="100" maxlength="70"><br><br>
	내용 : <br><textarea cols="100" rows="10" name="contents"></textarea><br><br>
	<div id="append">
	<input type="button" onclick="inputAdder()" value="사진 첨부 버튼 늘리기"><br>
	</div>
	
</fieldset>
<p style="float:right; margin:0px;"><input type="button" value="저 장 " onclick="elemChecker(this.form)"></p>
</form>
</article>

</body>
</html>