package cn.edu.hzvtc.repository;

import java.util.List;

import cn.edu.hzvtc.bean.Blog;

public interface BlogRepository extends BaseRepository<Blog> {
	// 分页查询所有
	List<Blog> getPageBlogs(Integer pageNo, Integer pageSize, String title,
			Long typeId, Boolean recommend, Long tagId, String content);
	
	// 分页查询所有
	List<Blog> getPageBlogs(Integer pageNo, Integer pageSize,List<Long> Ids);

	// 按某个字段来查询前几的Blog
	List<Blog> getTopBlog(Integer size);

	// 条件查询总数
	//Integer getCount(List<Integer> Ids);
	
	// 根据条件查询到符合条件的文章id
	List<Long> getIdsBySerach(String title, Long typeId, Boolean recommend, Long tagId, String content);
	

	// 查询每个博客所属的年份
	List<String> getGroupYear();

	// 查询每个年份对应的博客
	List<Blog> getByYear(String year);

}
