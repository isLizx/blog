package cn.edu.hzvtc.repository.impl;

import java.util.List;

import cn.edu.hzvtc.bean.Type;
import cn.edu.hzvtc.repository.TypeRepository;

public class TypeRepositoryImpl extends BaseRepositoryImpl<Type> implements
		TypeRepository {


	// 根据类型名查找
	public Type getTypeByName(String name) {
		Type result = null;
		String hql = "from Type where name = ?";
		List list = getSession().createQuery(hql).setString(0, name).list();
		
		if (list != null && list.size() != 0) {
			result = (Type) list.get(0);
		}
		return result;
	}


	// 分页查询操作
	@SuppressWarnings("all")
	public List<Type> getPage(int begin, int pageSize) {
		List<Type> result = null;
		String hql = "FROM Type";
		
		result = getSession().createQuery(hql).setFirstResult((begin-1)*pageSize).setMaxResults(pageSize).list();
		
		return result;
	}


	@SuppressWarnings("all")
	@Override
	public List<Type> getListTypeTop(Integer size) {
		List<Type> result = null;
		String hql = "from Type t order by t.blogs.size desc";
		
		result = getSession().createQuery(hql).setFirstResult(0).setMaxResults(size).list();
		
		return result;
	}
}
