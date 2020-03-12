package com.servlet;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * �������������������鿴�û��Ƿ��½��δ��¼��ֹ����ҳ��
 *  
 * @author ������ʮ
 *
 */
public class AuthFilter implements Filter {
	
    public void destroy() {}
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)  throws IOException, ServletException {        
          HttpServletRequest httpServletRequest = (HttpServletRequest)request;
          HttpServletResponse httpServletResponse = (HttpServletResponse) response;

          HttpSession session = httpServletRequest.getSession();
          User user = (User)session.getAttribute("user");

          String url = httpServletRequest.getRequestURI();

          //若不进行url.endsWith("login.jsp")判断则会出现无限循环重定向的问题；
          //若登陆成功之后则user不为null，继续执行
          if(url.endsWith("login.jsp") || user!=null){        
                 chain.doFilter(httpServletRequest, httpServletResponse);
                 return;
          }

          //若该if放在上一if语句之前，仍然会出现无限循环重定向的问题
          if(user==null){
                 httpServletResponse.sendRedirect("/packhudson/login.jsp");
                 return;
          }
    }
    public void init(FilterConfig fConfig) throws ServletException {
    }
}

