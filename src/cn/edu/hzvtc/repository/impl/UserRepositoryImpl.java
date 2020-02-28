package cn.edu.hzvtc.repository.impl;

import java.util.List;


import cn.edu.hzvtc.bean.User;
import cn.edu.hzvtc.repository.UserRepository;

public class UserRepositoryImpl extends BaseRepositoryImpl<User> implements UserRepository {

	@SuppressWarnings("all")
	@Override
	public User findByUsernameAndPassword(String username, String code) {
		List<User> list = null;
		User result = null;
		String hql = "from User where username = ? and password = ?";
		
		list = getSession().createQuery(hql).setString(0, username).setString(1, code).list();
		
		if(list != null && list.size()!=0){
			result = list.get(0);
		}
		return result;
	}

}
