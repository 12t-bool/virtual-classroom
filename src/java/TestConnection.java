import com.virtualclassroom.util.DBConnection;
import java.sql.Connection;

public class TestConnection {

    public static void main(String[] args) {

        Connection connection = DBConnection.getConnection();

        if (connection != null) {
            System.out.println("SUCCESS! Database connection is working.");
        } else {
            System.out.println("FAILED! Database connection is not working.");
        }
    }
}