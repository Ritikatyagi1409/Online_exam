<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,online_examination.GetConn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Change Password</title>
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
        font-size: 12px;
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
  margin-top:30px;
}
</style>
</head>
<body>
<%!
String uname, pass, new_pass, confirm_pass;
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;
%>
<%
try 
{
	uname = request.getParameter("name");
	pass = request.getParameter("password");
	new_pass = request.getParameter("new_password");
	confirm_pass = request.getParameter("confirm_password");
	con = GetConn.giveConn();
	if (new_pass.equals(confirm_pass)) 
	{
		ps = con.prepareStatement("update reg set password=? where userid=? and password=?",ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		ps.setString(1, new_pass);
		ps.setString(2, uname);
		ps.setString(3, pass);
		int check = ps.executeUpdate();
		con.close();
		if (check == 1) 
		{%>
		<div class="container">
		<form id="form" action="login.html">
            <h1>Password Successfully Changed</h1>
            <button type="submit">Login</button>
            </form>
		</div>
		<%
		}
		else 
		{%>
		<div class="container">
		<form id="form" action="changepassword.html">
            <h1>User Not Found With These Creds</h1>
            <button type="submit">Back</button>
            </form>
		</div>
		<%
		}
	} 
	else 
	{%>
	<div class="container">
		<form id="form" action="changepassword.html">
            <h1>Confirm Password and New Password is not same</h1>
            <button type="submit">Back</button>
            </form>
		</div>
	<%
	}
	con.close();
} 
catch (Exception e) 
{
	response.sendRedirect("error.html");
}
%>
</body>
</html>