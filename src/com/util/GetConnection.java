package com.util;
 
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
 
public class GetConnection {
    //閫氳繃闈欐�鏂规硶娉ㄥ唽椹卞姩锛岃幏寰楄繛鎺�
 
    public static Connection getConnection(){
       String driver = "com.mysql.jdbc.Driver";
       String url = "jdbc:mysql://ip:端口/库名";
       Connection con = null;
       try {
        Class.forName(driver);
        try {
         con = DriverManager.getConnection(url,"user","password");
        } catch (SQLException e) {
         e.printStackTrace();
        }
       } catch (ClassNotFoundException e) {
        e.printStackTrace();
       }
       System.out.println("宸茶幏寰楁暟鎹簱鐨勮繛鎺�");
       return con;
    }
    /*public static void main(String args[]){
       getConnection();
    }*/
    }