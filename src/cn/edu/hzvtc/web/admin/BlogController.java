package cn.edu.hzvtc.web.admin;

import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import cn.edu.hzvtc.bean.Blog;
import cn.edu.hzvtc.bean.Tag;
import cn.edu.hzvtc.bean.Type;
import cn.edu.hzvtc.bean.User;
import cn.edu.hzvtc.service.BlogService;
import cn.edu.hzvtc.service.TagService;
import cn.edu.hzvtc.service.TypeService;
import cn.edu.hzvtc.util.PageUtil;

import com.opensymphony.xwork2.ActionSupport;

public class BlogController extends ActionSupport implements SessionAware{
	private BlogService blogService;
	private TypeService typeService;
	private TagService tagService;
	private PageUtil pageUtil;
	private String msg;
	private Map<String, Object> session;
	
	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	private Integer pageSize = 5;
	// 文章id
	private Long id;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	// 条件
	private String title;
	private Long typeId;
	private Boolean recommend;
	private Long tagId;
	
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Long getTypeId() {
		return typeId;
	}

	public void setTypeId(Long typeId) {
		this.typeId = typeId;
	}

	public Boolean getRecommend() {
		return recommend;
	}

	public void setRecommend(Boolean recommend) {
		this.recommend = recommend;
	}

	public Long getTagId() {
		return tagId;
	}

	public void setTagId(Long tagId) {
		this.tagId = tagId;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public PageUtil getPageUtil() {
		return pageUtil;
	}

	public void setPageUtil(PageUtil pageUtil) {
		this.pageUtil = pageUtil;
	}

	public void setTagService(TagService tagService) {
		this.tagService = tagService;
	}

	public void setTypeService(TypeService typeService) {
		this.typeService = typeService;
	}

	public void setBlogService(BlogService blogService) {
		this.blogService = blogService;
	}

	private Blog blog = new Blog();
	public Blog getBlog() {
		return blog;
	}

	public void setBlog(Blog blog) {
		this.blog = blog;
	}

	private Integer currentPage = 0;

	public Integer getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}
	
	// 分类列表
	private List<Type> listType;
	// 标签列表
	private List<Tag> listTag;
	public List<Tag> getListTag() {
		return listTag;
	}

	public List<Type> getListType() {
		return listType;
	}
	// 到博客列表页面
	public String listpage() {
		setTypeAndTag();
		if(session.containsKey("currentPage")){
			currentPage = (Integer) session.get("currentPage");
			session.remove("currentPage");
		}
		pageUtil = blogService.getBlogByPage(currentPage, pageSize, "", null, null, null, "");
		
		return "listpage";
	}

	// 到添加页面
	public String toAddPage() {
		this.setTypeAndTag();
		return INPUT;
	}
	
	// 查询type和tag，方面修改和添加调用
	private void setTypeAndTag(){
		listType = typeService.getListType();
		listTag = tagService.getListTag();
	}
	
	// 到修改页面
	public String toUpdatePage(){
		this.setTypeAndTag();
		blog = blogService.getBlog(id);
		blog.init();
		return INPUT;
	}

	// 添加或者修改
	public String saveOrUpdate() {
		if(blog.getId() == null || blog.getId() == 0){
			User user = (User) session.get("user");
			blog.setUser(user);
		}
		blog.setType(typeService.getType(blog.getType().getId()));
		blog.setTags(tagService.getListTag(blog.getTagIds()));
		Integer result;
		result = blogService.saveOrUpdateBlog(blog);
		if (result == 1) {
			msg = "文章更新成功";
		} else if(result == -1){
			msg = "文章不存在!";
		} else {
			msg = "文章更新失败!";
		}
		session.put("msg", msg);
		session.put("currentPage", currentPage);
		return SUCCESS;

	}

	public String delete() {
		if (id == null) {
			session.put("msg", "删除失败!");
		} else {
			int code = blogService.deleteBlog(id);
			if (code == 0) {
				session.put("msg", "博客不存在!");
			} else {
				session.put("msg", "删除成功");
			}
		}
		session.put("currentPage", currentPage);
		return SUCCESS;
	}
	
	public String ajaxSearch(){
		if(typeId != null){
			Type selectedType = typeService.getType(typeId);
			blog.setType(selectedType);
		}
		pageUtil = blogService.getBlogByPage(0, pageSize, title, typeId, recommend, tagId, "");

		return "ajax";
	}
		
	public String ajaxSearchByPage(){
		pageUtil = blogService.getBlogByPage(currentPage, pageSize, "", null, null, null, "");

		return "ajax";
	}
	
	public String ajaxDelete() {
		if (id == null) {
			msg = "删除失败!";
		} else {
			int code = blogService.deleteBlog(id);
			if (code == 0) {
				msg = "文章不存在，删除失败!";
			} else {
				msg = "删除成功";
				if(title == null || title.equals("")) title = "";
				pageUtil = blogService.getBlogByPage(currentPage, pageSize, title, typeId, recommend, tagId, "");
			}
		}
		return "ajax";
	}

	@Override
	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}

}
