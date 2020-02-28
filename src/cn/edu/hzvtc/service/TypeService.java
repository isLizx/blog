package cn.edu.hzvtc.service;

import java.util.List;

import cn.edu.hzvtc.bean.Type;
import cn.edu.hzvtc.util.PageUtil;

public interface TypeService {

	// 根据id获取type
    Type getType(Long id);

    // 根据类型名字获取type
    Type getTypeByName(String name);
    
    // 删除一个类型
    Integer deleteType(Long id);

    // 添加或修改类型
    Integer saveOrUpdate(Type type);
    
    // 分页查询type
    PageUtil getListPage(Integer currentPage, Integer pageSize);
    
    // 查询所有的Type
    List<Type> getListType();
    
    // 查询前几的标签
    List<Type> getListTypeTop(Integer size);
}
