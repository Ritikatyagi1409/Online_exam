package online_examination;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
public class Login extends HttpServlet 
{
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException 
	{
		res.setContentType("text/html");
		PrintWriter pw = res.getWriter();
		String Uname = req.getParameter("name");
		String pass = req.getParameter("password");
		Connection cc = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try 
		{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			cc = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "systemroot");
			ps = cc.prepareStatement("select * from reg where userid=? and password=?");
			ps.setString(1, Uname);
			ps.setString(2, pass);
			rs = ps.executeQuery();
			if (rs.next()) 
			{
				res.sendRedirect("http://localhost:8080/Online_Examination/StartExam.jsp");
			} 
			else 
			{
				res.sendRedirect("error.html");
			}
			cc.close();
		} 
		catch (Exception e) 
		{
              pw.print(e);  
 
		}
		pw.close();
	}
}
