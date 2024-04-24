package online_examination;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
public class CheckAdmin extends HttpServlet
{
	public void doGet(HttpServletRequest req,HttpServletResponse res) throws IOException,ServletException
	{
		res.setContentType("text/html");
		PrintWriter out=res.getWriter();
		String uid=req.getParameter("adminid");
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		if(uid!=null)
		{
			try
			{
				con=GetConn.giveConn();
				ps=con.prepareStatement("select * from admin where id=?");
				ps.setString(1,uid);
				rs=ps.executeQuery();
				if(rs.next())
				{
					res.sendRedirect("addingques.html");
				}
				else
				{
					res.sendRedirect("error.html");
				}
				con.close();
			}
			catch(Exception e)
			{
				res.sendRedirect("error.html");
			}
		}
		else
		{
			res.sendRedirect("error.html");
		}
		out.close();
	}
}