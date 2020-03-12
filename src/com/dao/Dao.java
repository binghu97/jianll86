/*    */ package com.dao;
/*    */ 
/*    */ import com.servlet.User;
/*    */ import com.util.GetConnection;
/*    */ import java.sql.Connection;
/*    */ import java.sql.PreparedStatement;
/*    */ import java.sql.ResultSet;
/*    */ import java.sql.SQLException;
/*    */ 
/*    */ public class Dao
/*    */ {
/*    */   private Connection conn;
/*    */   private PreparedStatement pstat;
/* 13 */   String sql = "";
/*    */ 
/*    */   public boolean logoin(User user)
/*    */     throws SQLException
/*    */   {
/* 20 */     this.conn = GetConnection.getConnection();
/* 21 */     boolean i = false;
/* 22 */     this.sql = "select * from user where user=? and pwd=?";
/*    */ 
/* 24 */     this.pstat = this.conn.prepareStatement(this.sql);
/*    */ 
/* 26 */     this.pstat.setString(1, user.getUser());
/* 27 */     this.pstat.setString(2, user.getPwd());
/*    */ 
/* 29 */     ResultSet rs1 = this.pstat.executeQuery();
/* 30 */     if (rs1.next()) {
/* 31 */       i = true;
/* 32 */       rs1.close();
/* 33 */       this.pstat.close();
/*    */     } else {
/* 35 */       i = false;
/* 36 */       rs1.close();
/* 37 */       this.pstat.close();
/*    */     }
/* 39 */     this.conn.close();
/* 40 */     return i;
/*    */   }
/*    */ 
/*    */   public void addUser(User user)
/*    */   {
/* 47 */     this.conn = GetConnection.getConnection();
/* 48 */     this.sql = "insert into user values(?,?,?,?)";
/*    */     try {
/* 50 */       this.pstat = this.conn.prepareStatement(this.sql);
/* 51 */       this.pstat.setString(1, user.getUser());
/* 52 */       this.pstat.setString(2, user.getPwd());
/* 53 */       this.pstat.setString(3, user.getName());
/*    */ 
/* 55 */       this.pstat.setInt(5, user.getAge());
/* 56 */       this.pstat.executeUpdate();
/* 57 */       this.pstat.close();
/* 58 */       this.conn.close();
/*    */     }
/*    */     catch (SQLException e) {
/* 61 */       e.printStackTrace();
/*    */     }
/*    */   }
/*    */ }

/* Location:           D:\
 * Qualified Name:     com.dao.Dao
 * JD-Core Version:    0.6.0
 */