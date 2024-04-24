<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,online_examination.GetConn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forget Password</title>
<style>
body {
        background: linear-gradient(to right, #2eace1, #79bacf, #64b9dd);
        font-family: 'Poppins', sans-serif;
}
 #form {
        width: 300px;
        margin: 20vh auto 0 auto;
        padding: 20px;
        background-color: rgb(56, 204, 145);
        border-radius: 4px;
        font-size: 15px;
    }
    
    #form h1 {
        color: #0f2027;
        text-align: center;
    }
    
    #form button {
        padding: 10px;
        margin-top: 10px;
        width: 100%;
        color: white;
        background-color: rgb(41, 57, 194);
        border: none;
        border-radius: 4px;
    }
.container{
  width: 50%;  /* Adjust width as needed */
  margin: auto;
  margin-bottom:-200px;
}
</style>
</head>
<body>
<%!
String uname;
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;
%>
<%
uname = request.getParameter("name");
try {
	con = GetConn.giveConn();
	ps = con.prepareStatement("select * from reg where userid=?");
	ps.setString(1, uname);
	rs = ps.executeQuery();
	if (rs.next()) 
	{String sq = rs.getString("sq");%>
	
	<div class="container">
		<form id="form" action="CheckSa.jsp" method="get">
		<label for="SQ">Security Question</label>
		<label for="SQ1">: <%=sq %> ?</label><br>
		<label for='SA'>Security Answer : </label>
		<input id='SA' name='SA' type='text' required>
		<input type='hidden' name='uname' value="<%= uname%>">
            <button type="submit">Submit</button>
            </form>
		</div>
	
	<%
	} else 
	{%>
	<div class="container">
		<form id="form" action="forgetpassword.html">
            <h1>Wrong Username</h1>
            <button type="submit">Back</button>
            </form>
		</div>
		
	<%}
	con.close();
} catch (Exception e) {
	response.sendRedirect("error.html");
}
%>
</body>
</html>