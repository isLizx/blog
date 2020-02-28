package cn.edu.hzvtc.repository;

import java.util.List;

import cn.edu.hzvtc.bean.Type;

public interface TypeRepository extends BaseRepository<Type>{
	// 根据name查找Type
	Type getTypeByName(String name);
	
	// 分页查询所有
	List<Type> getPage(int begin,int pageSize);
	
	// 查询前几的type
	List<Type> getListTypeTop(Integer size);
	
}
