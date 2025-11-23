package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class VanialaConnection {
    private static final String URL = "jdbc:oracle:thin:@localhost:1521:EE";
    private static final String USER = "vaniala";
    private static final String PASSWORD = "vaniala";

    static {
        try {
            Class.forName("oracle.jdbc.OracleDriver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Driver Oracle non trouvé dans le classpath", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}