package cn.edu.hzvtc.service;

import java.util.List;

import cn.edu.hzvtc.bean.Comment;

public interface CommentService {
	// 查找当前博客下的所有评论
	List<Comment> getListCommentByBlogId(Long blogId);

	// 保存一条评论
	Integer saveComment(Comment comment);
}
