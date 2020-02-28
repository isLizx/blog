package cn.edu.hzvtc.web.admin;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

import cn.edu.hzvtc.bean.Tag;
import cn.edu.hzvtc.service.TagService;
import cn.edu.hzvtc.util.PageUtil;

import com.opensymphony.xwork2.ActionSupport;

public class TagController extends ActionSupport implements SessionAware{
	private Tag tag;
	private Integer pageSize = 5;
	private Map<String, Object> session;
	private PageUtil pageUtil;
	private Long id;
	private String msg;
	
	
	
	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public PageUtil getPageUtil() {
		return pageUtil;
	}

	public void setPageUtil(PageUtil pageUtil) {
		this.pageUtil = pageUtil;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Tag getTag() {
		return tag;
	}

	public void setTag(Tag tag) {
		this.tag = tag;
	}

	private TagService tagService;

	public void setTagService(TagService tagService) {
		this.tagService = tagService;
	}

	// 使用属性封装获取
	private Integer currentPage;

	public Integer getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}

	// 分页的方法
	public String listpage() {
		if(session.containsKey("currentPage")){
			currentPage = (Integer) session.get("currentPage");
			session.remove("currentPage");
		}
		// 调用service的方法实现封装
		pageUtil = tagService.getListPage(currentPage, pageSize);
		return "listpage";
	}

	// 1 到添加页面
	public String toAddPage() {
		return "toAddPage";
	}

	// 2 添加的方法
	public String add() {
		Tag tagDB = tagService.getTagByName(tag.getName());
		if (tagDB != null) {
			session.put("msg", "新增失败，不能添加重复的标签!");
			return INPUT;
		}
		// 添加逻辑
		Integer t = tagService.saveOrUpdate(tag);
		if (t == 1) {
			session.put("msg", "新增成功");
		} else if(t == -1){
			session.put("msg", "标签不存在!");
		} else {
			session.put("msg", "新增失败!");
		}
		session.put("currentPage", currentPage);
		return SUCCESS;
	}

	// 3 删除的方法
	public String delete() {
		if (id == null) {
			session.put("msg", "删除失败!");
		} else {
			int code = tagService.deleteTag(id);
			if (code == 1) {
				session.put("msg", "删除成功");
			} else if(code == -1){
				session.put("msg", "标签不存在!");
			} else {
				session.put("msg", "删除失败!");
			}
		}
		session.put("currentPage", currentPage);
		return SUCCESS;
	}

	// 4 修改的方法
	public String update() {
		Tag tagDB = tagService.getTagByName(tag.getName());
		if (tagDB != null) {
			tag = tagDB;
			session.put("msg", "更新失败，不能添加重复的标签!");
			return INPUT;
		}
		Integer result = tagService.saveOrUpdate(tag);
		if (result == 1) {
			session.put("msg", "更新成功");
		}else if(result == -1){
			session.put("msg", "标签不存在!");
		}else {
			session.put("msg", "更新失败!");
		}
		session.put("currentPage", currentPage);
		return SUCCESS;
	}

	// 5根据id查询
	public String findTypeById() {
		// 根据id查询type对象
		if(id == null || id == 0){
			session.put("msg", "标签不存在!");
			return SUCCESS;
		}
		tag = tagService.getTag(id);

		return "findTypeById";
	}

	@Override
	public void setSession(Map<String, Object> arg0) {
		session = arg0;
	}
	
	public String ajaxDelete(){
		if (id == null) {
			msg = "删除失败!";
		} else {
			int code = tagService.deleteTag(id);
			if (code == 1) {
				msg = "删除成功";
			} else if(code == -1){
				msg = "标签不存在!";
			} else {
				msg = "删除失败!";
			}
		}
		pageUtil = tagService.getListPage(currentPage, pageSize);
		return "ajax";
	}

}
