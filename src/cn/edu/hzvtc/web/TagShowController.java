package cn.edu.hzvtc.web;

import java.util.List;

import cn.edu.hzvtc.bean.Blog;
import cn.edu.hzvtc.bean.Tag;
import cn.edu.hzvtc.service.BlogService;
import cn.edu.hzvtc.service.TagService;
import cn.edu.hzvtc.util.PageUtil;

import com.opensymphony.xwork2.ActionSupport;

public class TagShowController extends ActionSupport{
	private TagService tagService;
	private BlogService blogService;
	private Long tagId;
	private Integer currentPage = 0;
	private Integer pageSize = 5;
	
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	public Integer getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}
	public Long getTagId() {
		return tagId;
	}
	public void setTagId(Long tagId) {
		this.tagId = tagId;
	}
	public void setTagService(TagService tagService) {
		this.tagService = tagService;
	}
	public void setBlogService(BlogService blogService) {
		this.blogService = blogService;
	}
	private List<Tag> tags;
	private PageUtil<Blog> pageUtil;
	private Long activeTagId;	
	public Long getActiveTagId() {
		return activeTagId;
	}
	public void setActiveTagId(Long activeTagId) {
		this.activeTagId = activeTagId;
	}
	public List<Tag> getTags() {
		return tags;
	}
	public PageUtil<Blog> getPageUtil() {
		return pageUtil;
	}
	@SuppressWarnings("all")
	public String tags(){
		tags = tagService.getListTagTop(10000);
        if (tagId == null || tagId <= 0) {
        	tagId = tags.get(0).getId();
        }
        
		pageUtil = blogService.getListPageByTypeOrTag(currentPage, pageSize, null, tagId);
		activeTagId = tagId;
		return "tags";
	}

}
