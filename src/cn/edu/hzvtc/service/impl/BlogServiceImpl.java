package cn.edu.hzvtc.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.transaction.annotation.Transactional;

import cn.edu.hzvtc.bean.Blog;
import cn.edu.hzvtc.bean.Comment;
import cn.edu.hzvtc.repository.BlogRepository;
import cn.edu.hzvtc.repository.CommentRepository;
import cn.edu.hzvtc.service.BlogService;
import cn.edu.hzvtc.util.MarkdownUtils;
import cn.edu.hzvtc.util.PageUtil;

import com.sun.jersey.api.NotFoundException;

@Transactional
public class BlogServiceImpl implements BlogService {
	private BlogRepository blogRepository;
	private CommentRepository commentRepository;

	public void setCommentRepository(CommentRepository commentRepository) {
		this.commentRepository = commentRepository;
	}

	public void setBlogRepository(BlogRepository blogRepository) {
		this.blogRepository = blogRepository;
	}

	// 按id查找博客
	@Transactional
	public Blog getBlog(Long id) {
		return blogRepository.getTById(id);
	}

	@Transactional
	public Integer saveOrUpdateBlog(Blog blog) {
		Integer result = 0;
		if (blog.getId() == null || blog.getId() == 0) {
			blog.setCreateTime(new Date());
			blog.setUpdateTime(new Date());
			blog.setViews(0);
			
			blogRepository.saveOrUpdate(blog);
			result = 1;
		} else {
			Blog blogDB = blogRepository.getTById(blog.getId());
			if(blogDB != null){
				blogDB.setAppreciation(blog.isAppreciation());
				blogDB.setTitle(blog.getTitle());
				blogDB.setContent(blog.getContent());
				blogDB.setFirstPicture(blog.getFirstPicture());
				blogDB.setFlag(blog.getFlag());
				blogDB.setShareStatement(blog.isShareStatement());
				blogDB.setCommentabled(blog.isCommentabled());
				blogDB.setPublished(blog.isPublished());
				blogDB.setRecommend(blog.isRecommend());
				blogDB.setUpdateTime(new Date());
				blogDB.setType(blog.getType());
				blogDB.setTags(blog.getTags());
				blogDB.setTagIds(blog.getTagIds());
				blogDB.setDescription(blog.getDescription());
				
				blogRepository.saveOrUpdate(blogDB);
				result = 1;
			}else{
				result = -1;
			}
		}

		return result;
	}

	@Transactional
	public Integer deleteBlog(Long id) {
		Integer result = 0;

		// 判断博客是否存在
		Blog b = blogRepository.getTById(id);
		if (b == null) {
			result = -1;
			return result;
		}
		List<Comment> comments = commentRepository.findByBlogId(id);
		for(Comment c : comments){
			commentRepository.delete(c);
		}
		blogRepository.delete(b);
		result = 1;
		return result;
	}

	@Transactional
	public List<Blog> getListRecommendBlogTop(Integer size) {
		return blogRepository.getTopBlog(size);
	}

	@Transactional
	public Blog getAndConvert(Long id) {
		Blog blog = blogRepository.getTById(id);
		if (blog == null) {
			throw new NotFoundException("该博客不存在");
		}
		Blog b = new Blog();
		BeanUtils.copyProperties(blog, b);
		String content = b.getContent();
		b.setContent(MarkdownUtils.markdownToHtmlExtensions(content));
		blog.setViews(blog.getViews() + 1);
		return b;
	}

	public Integer getCountBlog() {
		return blogRepository.getCount();
	}

	@Override
	public PageUtil<Blog> getBlogByPage(Integer pageNo, Integer pageSize,
			String title, Long typeId, Boolean recommend, Long tagId,
			String content) {
		PageUtil<Blog> result = null;

		result = new PageUtil<Blog>();
		result.setPageNo(pageNo);
		result.setPageSize(pageSize);
		List<Long> Ids = blogRepository.getIdsBySerach(title, typeId, recommend, tagId, content);
		result.setRecordCount(Ids.size());
		if(Ids != null && Ids.size() > 0){
			result.setDataList(blogRepository.getPageBlogs(result.getPageNo(),
					result.getPageSize(), Ids));
		}else{
			result.setDataList(null);
		}
		

		return result;
	}

	@Override
	public PageUtil<Blog> getListPageByTypeOrTag(Integer currentPage,Integer pageSize, Long typeId,
			Long tagId) {
		PageUtil<Blog> result = null;
		
		if(typeId != null && typeId > 0){
			result = new PageUtil<Blog>();
			result.setPageNo(currentPage);
			result.setPageSize(pageSize);
//			result.setRecordCount(blogRepository.getCount(null, typeId, null, null, null));
			List<Long> Ids = blogRepository.getIdsBySerach(null, typeId, null, tagId, null);
			result.setRecordCount(Ids.size());
			
			if(Ids != null && Ids.size() > 0){
				result.setDataList(blogRepository.getPageBlogs(result.getPageNo(),
						result.getPageSize(), Ids));
			}else{
				result.setDataList(null);
			}
		}
		if(tagId != null && tagId > 0){
			result = new PageUtil<Blog>();
			result.setPageNo(currentPage);
			result.setPageSize(pageSize);
//			result.setRecordCount(blogRepository.getCount(null, null, null, tagId, null));
			List<Long> Ids = blogRepository.getIdsBySerach(null, null, null, tagId, null);
			result.setRecordCount(Ids.size());
			if(Ids != null && Ids.size() > 0){
				result.setDataList(blogRepository.getPageBlogs(result.getPageNo(),
						result.getPageSize(), Ids));
			}else{
				result.setDataList(null);
			}
		}
		
		return result;
	}

	@Override
	public Map<String, List<Blog>> getArchiveBlog() {
		List<String> years = blogRepository.getGroupYear();
		Map<String, List<Blog>> map = new HashMap<>();
		for (String year : years) {
			map.put(year, blogRepository.getByYear(year));
		}
		return map;
	}

	// @Override
	// public PageUtil<Blog> getBlogByPage(Integer pageNo, Integer pageSize) {
	// PageUtil<Blog> result = null;
	//
	// result = new PageUtil<Blog>();
	// result.setPageNo(pageNo);
	// result.setPageSize(pageSize);
	// result.setRecordCount();
	// }

}
