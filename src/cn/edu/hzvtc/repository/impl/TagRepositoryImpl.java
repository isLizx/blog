package cn.edu.hzvtc.repository.impl;

import java.util.ArrayList;
import java.util.List;

import cn.edu.hzvtc.bean.Tag;
import cn.edu.hzvtc.repository.TagRepository;

public class TagRepositoryImpl extends BaseRepositoryImpl<Tag> implements
		TagRepository {

	// 根据类型名查找
	public Tag getTagByName(String name) {
		Tag result = null;
		String hql = "from Tag where name = ?";
		List list = getSession().createQuery(hql).setString(0, name).list();
		
		if (list != null && list.size() != 0) {
			result = (Tag) list.get(0);
		}
		return result;
	}

	// 分页查询操作
	@SuppressWarnings("all")
	public List<Tag> getPage(int begin, int pageSize) {
		List<Tag> result = null;
		String hql = "FROM Tag";
		
		result = getSession().createQuery(hql).setFirstResult((begin-1)*pageSize).setMaxResults(pageSize).list();
		
		return result;
	}

	@Override
	public List<Tag> getListType(List listTagId) {
		if (listTagId == null || listTagId.size() == 0) {
			return null;
		}
		List<Tag> listTag = new ArrayList<Tag>();
		for (int i = 0; i < listTagId.size(); i++) {
			Long id = (Long) listTagId.get(i);
			listTag.add(this.getTById(id));
		}
		return listTag;
	}

	@SuppressWarnings("all")
	@Override
	public List<Tag> getListTagTop(Integer size) {
		List<Tag> result = null;
		String hql = "from Tag t order by t.blogs.size desc";
		
		result = getSession().createQuery(hql).setFirstResult(0).setMaxResults(size).list();
		
		return result;

	}

}
