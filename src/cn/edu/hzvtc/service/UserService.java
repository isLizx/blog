package cn.edu.hzvtc.service;

import cn.edu.hzvtc.bean.User;

public interface UserService {
	User getCheckUser(String username, String password);
}
