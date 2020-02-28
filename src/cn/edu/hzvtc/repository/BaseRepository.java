package cn.edu.hzvtc.repository;

import java.util.List;

public interface BaseRepository<T> {
	
	// 查询所有的持久化对象
	List<T> getAll();
	
	// 查询持久化对象对数量
	Integer getCount();
	
	// 按id查询持久化对象
	T getTById(Long id);
	
	// 删除持久化对象
	void delete(T t);
	
	// 更新持久化对象
	void saveOrUpdate(T t);
	
}
