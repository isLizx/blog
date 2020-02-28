package cn.edu.hzvtc.repository;

import java.util.List;

import cn.edu.hzvtc.bean.Tag;

public interface TagRepository extends BaseRepository<Tag>{
	// 根据name查找Type
	Tag getTagByName(String name);
	 
	// 分页查询所有
	List<Tag> getPage(int begin,int pageSize);
	
	// 查找给定id的标签
	List<Tag> getListType(List listTagId);

	List<Tag> getListTagTop(Integer size);
}
