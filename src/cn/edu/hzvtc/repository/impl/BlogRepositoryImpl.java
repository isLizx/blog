package cn.edu.hzvtc.repository.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;

import cn.edu.hzvtc.bean.Blog;
import cn.edu.hzvtc.repository.BlogRepository;

public class BlogRepositoryImpl extends BaseRepositoryImpl<Blog> implements
		BlogRepository {

	@SuppressWarnings("all")
	public List<Blog> getPageBlogs(Integer pageNo, Integer pageSize,
			String title, Long typeId, Boolean recommend, Long tagId,
			String content) {
		List<Blog> result = null;
		List<Object> p = new ArrayList<Object>();
		// String hql =
		// "From Blog b left outer join fetch b.type left outer join fetch b.tags t where 1 = 1 ";
		String hql = "SELECT b FROM Blog b where b.id in (SELECT b.id FROM Blog b where 1 = 1 ";
		if (title != null && !title.equals("")) {
			hql += "AND b.title like ? ";
			p.add("%" + title + "%");
		}
		if (typeId != null) {
			hql += "AND b.type.id = ? ";
			p.add(typeId);
		}
		if (recommend != null) {
			hql += "AND b.recommend = ? ";
			p.add(recommend);
		}
		if (tagId != null) {
			hql += "AND b.tags.id = ? ";
			p.add(tagId);
		}
		if (content != null && !content.equals("")) {
			hql += "OR b.content like ? ";
			p.add("%" + content + "%");
		}
		hql += "GROUP BY b.id) ORDER BY b.updateTime DESC";

		Query query = getSession().createQuery(hql);
		for (int i = 0; i < p.size(); i++) {
			query.setParameter(i, p.get(i));
		}
		if(pageNo ==0 && pageSize == 0){
			result = query.list();
		}else{
			result = query.setFirstResult((pageNo - 1) * pageSize)
					.setMaxResults(pageSize).list();
		}

		return result;
	}

	@SuppressWarnings("all")
	public List<Blog> getTopBlog(Integer size) {

		String hql = "FROM Blog b left outer join fetch b.type WHERE b.recommend = true ORDER BY b.updateTime desc";
		List<Blog> result = getSession().createQuery(hql).setFirstResult(0).setMaxResults(size).list();

		return result;
	}

	// @Override
	// public Integer getCount(String title, Long typeId, Boolean recommend,
	// Long tagId, String content) {
	// Integer result = 0;
	// List<Object> p = new ArrayList<Object>();
	//
	// String hql =
	// "SELECT COUNT(id) FROM Blog b where b.id in (SELECT b.id FROM Blog b left outer join b.type left outer join b.tags t where 1 = 1 ";
	// if (title != null && !title.equals("")) {
	// hql += "AND b.title like ? ";
	// p.add("%" + title + "%");
	// }
	// if (typeId != null) {
	// hql += "AND b.type.id = ? ";
	// p.add(typeId);
	// }
	// if (recommend != null) {
	// hql += "AND b.recommend = ? ";
	// p.add(recommend);
	// }
	// if (tagId != null) {
	// hql += "AND t.id = ? ";
	// p.add(tagId);
	// }
	// if (content != null && !content.equals("")) {
	// hql += "AND b.content like ? ";
	// p.add("%" + content + "%");
	// }
	// hql += "GROUP BY b.id)";
	//
	// Query query = getSession().createQuery(hql);
	// for (int i = 0; i < p.size(); i++) {
	// query.setParameter(i, p.get(i));
	// }
	// System.out.println(hql);
	// result = ((Long) query.uniqueResult()).intValue();
	// return result;
	// }

	@SuppressWarnings("all")
	@Override
	public List<String> getGroupYear() {
		List<String> result = null;
		String hql = "select function('date_format',b.updateTime,'%Y') as year from Blog b group by function('date_format',b.updateTime,'%Y') order by year desc ";
		result = (List<String>) getSession().createQuery(hql).list();
		return result;
	}

	@SuppressWarnings("all")
	@Override
	public List<Blog> getByYear(String year) {
		List<Blog> result = null;
		String hql = "select b from Blog b where function('date_format',b.updateTime,'%Y') = ?";
		result = (List<Blog>) getSession().createQuery(hql).setString(0, year).list();
		return result;
	}

	@SuppressWarnings("all")
	@Override
	public List<Blog> getPageBlogs(Integer pageNo, Integer pageSize,
			List<Long> Ids) {
		List<Blog> result = null;

		String hql = "SELECT b FROM Blog b where b.id in (:Ids) ORDER BY b.updateTime DESC";
		if(pageNo == 0 && pageSize == 0){
			result = getSession().createQuery(hql).setParameterList("Ids", Ids).list();
		}else{
			result = getSession().createQuery(hql).setParameterList("Ids", Ids)
					.setFirstResult((pageNo - 1) * pageSize)
					.setMaxResults(pageSize).list();
		}

		return result;
	}

	@Override
	public List<Long> getIdsBySerach(String title, Long typeId,
			Boolean recommend, Long tagId, String content) {
		List<Long> result = null;
		List<Object> p = new ArrayList<Object>();

		String hql = "SELECT b.id FROM Blog b left outer join b.type left outer join b.tags t where 1 = 1 ";
		if (title != null && !title.equals("")) {
			hql += "AND b.title like ? ";
			p.add("%" + title + "%");
		}
		if (typeId != null) {
			hql += "AND b.type.id = ? ";
			p.add(typeId);
		}
		if (recommend != null) {
			hql += "AND b.recommend = ? ";
			p.add(recommend);
		}
		if (tagId != null) {
			hql += "AND t.id = ? ";
			p.add(tagId);
		}
		if (content != null && !content.equals("")) {
			hql += "OR b.content like ? ";
			p.add("%" + content + "%");
		}
		hql += "GROUP BY b.id";

		Query query = getSession().createQuery(hql);
		for (int i = 0; i < p.size(); i++) {
			query.setParameter(i, p.get(i));
		}
		result = query.list();
		return result;
	}

}
