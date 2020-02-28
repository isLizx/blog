package cn.edu.hzvtc.service.impl;

import org.springframework.transaction.annotation.Transactional;


import cn.edu.hzvtc.bean.User;
import cn.edu.hzvtc.repository.UserRepository;
import cn.edu.hzvtc.service.UserService;
import cn.edu.hzvtc.util.MD5Utils;


public class UserServiceImpl implements UserService {
	private UserRepository userRepository;
	public void setUserRepository(UserRepository userRepository) {
		this.userRepository = userRepository;
	}

	@Transactional
	public User getCheckUser(String username, String password) {
		User user = userRepository.findByUsernameAndPassword(username, MD5Utils.code(password));
        return user;
	}

}
