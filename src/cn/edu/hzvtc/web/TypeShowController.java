package cn.edu.hzvtc.web;

import java.util.List;

import cn.edu.hzvtc.bean.Blog;
import cn.edu.hzvtc.bean.Type;
import cn.edu.hzvtc.service.BlogService;
import cn.edu.hzvtc.service.TypeService;
import cn.edu.hzvtc.util.PageUtil;

import com.opensymphony.xwork2.ActionSupport;

public class TypeShowController extends ActionSupport{
	private TypeService typeService;
	private BlogService blogService;
	private Integer currentPage = 0;
	private Long typeId;
	private Integer pageSize = 5;

	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	public Long getTypeId() {
		return typeId;
	}
	public void setTypeId(Long typeId) {
		this.typeId = typeId;
	}
	public Integer getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}
	public void setBlogService(BlogService blogService) {
		this.blogService = blogService;
	}
	public void setTypeService(TypeService typeService) {
		this.typeService = typeService;
	}
	
	private List<Type> types;
	private PageUtil<Blog> pageUtil;
	private Long activeTypeId;
	public List<Type> getTypes() {
		return types;
	}
	public PageUtil<Blog> getPageUtil() {
		return pageUtil;
	}
	public Long getActiveTypeId() {
		return activeTypeId;
	}
	public String types(){
		types = typeService.getListTypeTop(10000);
		if(typeId == null || typeId <= 0){
			typeId = types.get(0).getId();
		}
		pageUtil = blogService.getListPageByTypeOrTag(currentPage, pageSize, typeId, null);
		activeTypeId = typeId;
		
		return "types";
	}

}
