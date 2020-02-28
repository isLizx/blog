package cn.edu.hzvtc.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

import cn.edu.hzvtc.bean.Comment;
import cn.edu.hzvtc.bean.User;
import cn.edu.hzvtc.service.BlogService;
import cn.edu.hzvtc.service.CommentService;
import cn.edu.hzvtc.util.CreateNamePicture;

import com.opensymphony.xwork2.ActionSupport;

public class CommentController extends ActionSupport implements SessionAware {
	private CommentService commentService;
	private BlogService blogService;

	private Map<String, Object> session;
	private String msg;

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public void setCommentService(CommentService commentService) {
		this.commentService = commentService;
	}

	public void setBlogService(BlogService blogService) {
		this.blogService = blogService;
	}

	private Comment comment = new Comment();

	public Comment getComment() {
		return comment;
	}

	public void setComment(Comment comment) {
		this.comment = comment;
	}

	// 博客id
	private Long blogId;
	private Long parentCommentId;

	public Long getParentCommentId() {
		return parentCommentId;
	}

	public void setParentCommentId(Long parentCommentId) {
		this.parentCommentId = parentCommentId;
	}

	public Long getBlogId() {
		return blogId;
	}

	public void setBlogId(Long blogId) {
		this.blogId = blogId;
	}

	public String comments() {
		HttpServletRequest request = ServletActionContext.getRequest();

		List<Comment> comments = commentService.getListCommentByBlogId(blogId);

		request.setAttribute("comments", comments);
		return "comments";
	}

	public String save() {
		blogId = comment.getBlog().getId();
		comment.setBlog(blogService.getBlog(blogId));
		User user = (User) session.get("user");
		if (user != null) {
			comment.setAvatar(user.getAvatar());
			comment.setAdminComment(true);
		} else {
//			comment.setAvatar("https://picsum.photos/110/110");
			// 获取要保存
			String realPath = ServletActionContext.getServletContext().getRealPath("upload");
			
			CreateNamePicture cnp = new CreateNamePicture();
			String filename = cnp.createHead(comment.getNickname(),realPath);
			System.out.println(filename + "==========================================");
			comment.setAvatar(filename);
			
		}
		commentService.saveComment(comment);
		return "save";
	}

	@Override
	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}

}
