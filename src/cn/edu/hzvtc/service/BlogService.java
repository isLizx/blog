package cn.edu.hzvtc.service;

import java.util.List;
import java.util.Map;

import cn.edu.hzvtc.bean.Blog;
import cn.edu.hzvtc.util.PageUtil;

public interface BlogService {
	// 根据id查询博客
	Blog getBlog(Long id);
		
	// 查询Top的推荐博客
	List<Blog> getListRecommendBlogTop(Integer size);
	
	// 保存博客
	Integer saveOrUpdateBlog(Blog blog);
		
	//删除博客
	Integer deleteBlog(Long id);
	
	// 对博客中content的文本进行HTML转换
	Blog getAndConvert(Long id);
	
	// 按type或tag分页查询博客
	PageUtil<Blog> getListPageByTypeOrTag(Integer currentPage,Integer pageSize, Long typeId,Long tagId);
	
	// 归档博客
	Map<String, List<Blog>> getArchiveBlog();
	
	// 查询所有博客总数
	Integer getCountBlog();
	
	
	// 以下为19.11.21后增加的方法
	// 分页查询文章
	PageUtil<Blog> getBlogByPage(Integer pageNo, Integer pageSize, String title, Long typeId, Boolean recommend, Long tagId, String content);
}
