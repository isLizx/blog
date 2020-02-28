package cn.edu.hzvtc.repository;

import java.util.List;

import cn.edu.hzvtc.bean.Comment;

public interface CommentRepository extends BaseRepository<Comment>{
	
	// 查找一条博客下面所有的顶级评论
	List<Comment> findByBlogIdAndParentCommentNull(Long blogId);
	
	// 查找一条博客下面所有的评论
	List<Comment> findByBlogId(Long blogId);
}
