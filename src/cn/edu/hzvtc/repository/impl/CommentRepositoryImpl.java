package cn.edu.hzvtc.repository.impl;

import java.util.List;


import cn.edu.hzvtc.bean.Comment;
import cn.edu.hzvtc.repository.CommentRepository;

public class CommentRepositoryImpl extends BaseRepositoryImpl<Comment> implements
		CommentRepository {

	@SuppressWarnings("all")
	@Override
	public List<Comment> findByBlogIdAndParentCommentNull(Long blogId) {
		List<Comment> result = null;
		String hql = "from Comment c where c.parentComment = null and c.blog.id = ? order by c.createTime";
		
		result = getSession().createQuery(hql).setLong(0, blogId).list();
		
		return result;
	}

	@SuppressWarnings("all")
	@Override
	public List<Comment> findByBlogId(Long blogId) {
		List<Comment> result = null;
		String hql = "from Comment c where c.blog.id = ?";
		
		result = getSession().createQuery(hql).setLong(0, blogId).list();
		
		return result;
	}

	

}
