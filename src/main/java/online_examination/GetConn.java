package online_examination;
import java.sql.*;
public class GetConn 
{
	public static Connection giveConn()
	{
		Connection con=null;
		try
		{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","systemroot");
		}
		catch(Exception e)
		{
			
		}
		return con;
	}
}
