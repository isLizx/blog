package cn.edu.hzvtc.repository;

import cn.edu.hzvtc.bean.User;

public interface UserRepository extends BaseRepository<User>{

	User findByUsernameAndPassword(String username, String code);

}
