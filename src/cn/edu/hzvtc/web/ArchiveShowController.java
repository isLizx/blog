package cn.edu.hzvtc.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import cn.edu.hzvtc.bean.Blog;
import cn.edu.hzvtc.service.BlogService;

import com.opensymphony.xwork2.ActionSupport;

public class ArchiveShowController extends ActionSupport {
	private BlogService blogService;
	public void setBlogService(BlogService blogService) {
		this.blogService = blogService;
	}
	
	public String archives(){
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("archiveMap", blogService.getArchiveBlog());
		request.setAttribute("blogCount", blogService.getCountBlog());
		return "archives";
	}
	
}
