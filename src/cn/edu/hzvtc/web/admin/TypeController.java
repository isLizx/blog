package cn.edu.hzvtc.web.admin;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import cn.edu.hzvtc.bean.Type;
import cn.edu.hzvtc.service.TypeService;
import cn.edu.hzvtc.util.PageUtil;

import com.opensymphony.xwork2.ActionSupport;

public class TypeController extends ActionSupport implements SessionAware{
	private Type type;
	private Integer pageSize = 5;
	private PageUtil pageUtil;
	private String msg;
	private Long id;
	
	public void setId(Long id) {
		this.id = id;
	}

	public Long getId() {
		return id;
	}
	private Map<String, Object> session;
	public String getMsg() {
		return msg;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public PageUtil getPageUtil() {
		return pageUtil;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	public Type getType() {
		return type;
	}

	public void setType(Type type) {
		this.type = type;
	}
	private TypeService typeService;

	public void setTypeService(TypeService typeService) {
		this.typeService = typeService;
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
		// 调用service的方法实现封装
		if(session.containsKey("currentPage")){
			currentPage = (Integer) session.get("currentPage");
			session.remove("currentPage");
		}
		pageUtil = typeService.getListPage(currentPage, pageSize);
		return "listpage";
	}

	// 1 到添加页面
	public String toAddPage() {
		return "toAddPage";
	}

	

	// 3 删除的方法
	public String delete() {
		if (id == null) {
			msg = "删除失败!";
		}else{
			int code = typeService.deleteType(id);
			if(code == 1){
				msg = "删除成功";
			}else if(code == -1){
				msg = "类型不存在!";
			}else{
				msg = "删除失败!";
			}
		}
		session.put("currentPage", currentPage);
		return SUCCESS;
	}
	
	public String saveOrUpdate(){
		Type typeDB = typeService.getTypeByName(type.getName());
		if (typeDB != null) {
			type = typeDB;
			session.put("msg", "更新失败，不能添加重复的分类!");
			return INPUT;
		}
		Integer result = typeService.saveOrUpdate(type);
		session.put("currentPage", currentPage);
		if (result == 1) {
			session.put("msg", "更新成功");
		} else if(result == -1){
			session.put("msg", "类型不存在!");
		} else {
			session.put("msg", "更新失败!");
		}
		return SUCCESS;
	}
	

	// 5根据id查询
	public String findTypeById() {
		// 根据id查询type对象
		if(id == null || id == 0){
			session.put("msg", "类型不存在!");
			return SUCCESS;
		}
		type = typeService.getType(id);
		return "findTypeById";
	}

	@Override
	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}
	
	public String ajaxDelete(){
		if (id == null) {
			msg = "删除失败!";
		}else{
			int code = typeService.deleteType(id);
			if(code == 1){
				msg = "删除成功";
			}else if(code == -1){
				msg = "类型不存在!";
			}else{
				msg = "删除失败!";
			}
		}
		pageUtil = typeService.getListPage(currentPage, pageSize);
		return "ajax";
	}

}
