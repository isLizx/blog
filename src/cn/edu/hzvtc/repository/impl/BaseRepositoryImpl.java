package cn.edu.hzvtc.repository.impl;

import java.lang.reflect.ParameterizedType;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import cn.edu.hzvtc.repository.BaseRepository;

public class BaseRepositoryImpl<T> implements BaseRepository<T> {
	private Class clazz;
	public BaseRepositoryImpl() {
		ParameterizedType type = (ParameterizedType) this.getClass().getGenericSuperclass();
		clazz = (Class) type.getActualTypeArguments()[0];
	}

	private SessionFactory sessionFactory;

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	protected Session getSession() {
		return this.sessionFactory.getCurrentSession();
	}
	
	@Override
	public List<T> getAll() {
		List<T> result = null;
		
		String hql = "FROM " + clazz.getName();
		result = getSession().createQuery(hql).list();
		
		return result;
	}

	@Override
	public Integer getCount() {
		Integer result = 0;
		
		String hql = "SELECT COUNT(t) FROM " + clazz.getName() + " t";
		result = ((Long)getSession().createQuery(hql).uniqueResult()).intValue();
		
		return result;
	}

	@Override
	public T getTById(Long id) {
		T result = null;
		
		result = (T) getSession().get(clazz, id);
		
		return result;
	}

	@Override
	public void delete(T t) {
		getSession().delete(t);
	}

	public void saveOrUpdate(T t) {
		getSession().saveOrUpdate(t);
	}

}
