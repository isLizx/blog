package cn.edu.hzvtc.web;

import java.util.List;

import org.apache.struts2.json.annotations.JSON;

import cn.edu.hzvtc.bean.Blog;
import cn.edu.hzvtc.bean.Comment;
import cn.edu.hzvtc.bean.Tag;
import cn.edu.hzvtc.bean.Type;
import cn.edu.hzvtc.service.BlogService;
import cn.edu.hzvtc.service.CommentService;
import cn.edu.hzvtc.service.TagService;
import cn.edu.hzvtc.service.TypeService;
import cn.edu.hzvtc.util.PageUtil;

import com.opensymphony.xwork2.ActionSupport;

public class IndexController extends ActionSupport{
	private BlogService blogService;
	private TypeService typeService;
	private TagService tagService;
	private CommentService commentService;
	private final Integer pageSize = 5;
	private Blog blog;
	private PageUtil<Blog> pageUtil;
	private List<Comment> comments;
	private List<Blog> blogs;
	private Integer id;
	
	public Blog getBlog(){
		return blog;
	}
	public void setBlog(Blog blog) {
		this.blog = blog;
	}
	@JSON(serialize=false)
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public List<Blog> getBlogs() {
		return blogs;
	}
	@JSON(serialize=false)
	public List<Comment> getComments() {
		return comments;
	}
	@JSON(serialize=false)
	public PageUtil<Blog> getPageUtil() {
		return pageUtil;
	}
	// 搜索框
	private String query;
	
	@JSON(serialize=false)
	public String getQuery() {
		return query;
	}
	public void setQuery(String query) {
		this.query = query;
	}
	public void setTypeService(TypeService typeService) {
		this.typeService = typeService;
	}
	public void setTagService(TagService tagService) {
		this.tagService = tagService;
	}
	public void setCommentService(CommentService commentService) {
		this.commentService = commentService;
	}
	private Integer currentPage = 0;
	@JSON(serialize=false)
	public Integer getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}
	public void setBlogService(BlogService blogService) {
		this.blogService = blogService;
	}
	private List<Type> listTypes = null;
	private List<Tag> listTags;
	private List<Blog> listRecommendBlogs;
	@JSON(serialize=false)
	public List<Type> getListTypes() {
		return listTypes;
	}
	
	@JSON(serialize=false)
	public List<Tag> getListTags() {
		return listTags;
	}
	
	@JSON(serialize=false)
	public List<Blog> getListRecommendBlogs() {
		return listRecommendBlogs;
	}
	public String index(){
		// 分页查询所有博客
		pageUtil = blogService.getBlogByPage(currentPage, pageSize, null, null, null, null, null);
		listTypes = typeService.getListTypeTop(5);
		listTags = tagService.getListTagTop(5);
		listRecommendBlogs = blogService.getListRecommendBlogTop(8);

		
		return "index";
		
	}
	
	// 关键字全局搜索
	public String search(){
		
		pageUtil = blogService.getBlogByPage(currentPage, pageSize, query, null, null, null, query);
		
		return "search";
	}
	
	// 查询单个博客
	@JSON(serialize=false)
	public String getOneBlog(){
		if(id != null || id != 0){
			blog = blogService.getAndConvert(id.longValue());
			commentService.getListCommentByBlogId(blog.getId());
			comments = commentService.getListCommentByBlogId(blog.getId());
		}
		return "getOneBlog";
	}
	
	
	// ajax获取footer底部最新推荐文章
	@JSON(serialize=false)
	public String getAjaxSearchByTop(){
		Integer size = 3;
		blogs = blogService.getListRecommendBlogTop(size);
		
		return "ajax";
	}
	
	// 
	
	
}
