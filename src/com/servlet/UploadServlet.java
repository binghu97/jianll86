package com.servlet;





import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.IOUtils;


public class UploadServlet extends HttpServlet {
	


	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//1、创建磁盘文件项工厂
			//获取web根目录下放置缓存文件的文件夹“temp”的物理路径
			String path_temp = this.getServletContext().getRealPath("/opt/tomcat");
			File file = new File(path_temp) ;
			DiskFileItemFactory factory = new DiskFileItemFactory(1024*1024, file);//1024*1024为设置文件缓存大小
			//也可以new一个空参的factory，随后再设置缓存大小，和缓存位置
			//DiskFileItemFactory factory = new DiskFileItemFactory();
			//factory.setSizeThreshold(1024*1024);
			//factory.setRepository(file);
				
			//2、创建文件上传的核心类
			ServletFileUpload upload = new ServletFileUpload(factory);
			//设置上传文件名称的编码为UTF-8，不设置有可能会出现中文乱码，编码规范要进行设置。
			upload.setHeaderEncoding("UTF-8");
			//判断表单是否是文件上传表单，只是为了演示需要，实际开发中开发人员肯定知道这是不是文件上传表单
			boolean multipartContent = upload.isMultipartContent(request);
			if(multipartContent) {
				//是文件上传的表单，解析request获得文件项集合
				List<FileItem> parseRequest = upload.parseRequest(request);
				if(parseRequest!=null) {
					for(FileItem item :parseRequest) {
						//判断是不是普通表单项
						boolean formField = item.isFormField();
						if(formField) {
							//如果是普通表单项
							String fieldName = item.getFieldName();
							String fieldValue = item.getString("UTF-8");//对普通表单项的内容进行编码
							//当表单是enctype="multipart/form-data"时，request.getParameter相关的方法都失效，所以要用上面的方法获得值
							//String parameter = request.getParameter("username");//获取不到，失效！
							System.out.println("表单值为："+fieldName+"="+fieldValue);
						}else {
							//如果是文件上传项							
							String name = item.getName();
							System.out.println("文件名为:"+name);
							System.out.println(item);
							//加入判断文件是否上传，如果不加判断，前台没有选择文件，提交后会报IO空指针异常
							if(item.getSize()==0L) {
								response.setContentType("text/html;charset=UTF-8");
								response.getWriter().write("请上传文件");
								return;
							}
							if(name=="") {
								response.setContentType("text/html;charset=UTF-8");
								response.getWriter().write("文件名不能为空");
								return;
							}
							InputStream in = item.getInputStream();
							String path_store = this.getServletContext().getRealPath("upload");
							OutputStream out = new FileOutputStream(path_store+"/"+name);
							IOUtils.copy(in, out);
							in.close();
							out.close();
							//删除临时文件
							item.delete();
						}
						
					}					
				}
				response.setContentType("text/html;charset=UTF-8");
				response.getWriter().write("文件上传成功");
				
			}else {
				//不是文件上传表单，可以使用原始的获取表单数据方式request.getParameter();
				//只是为了演示需要，实际开发中开发人员肯定知道这是不是文件上传表单
				Map<String, String[]> parameterMap = request.getParameterMap();
				response.setContentType("text/html;charset=UTF-8");
				response.getWriter().write("不是文件上传表单");
			}
		} catch (FileUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}