package cn.edu.hzvtc.service;

import java.util.List;

import cn.edu.hzvtc.bean.Tag;
import cn.edu.hzvtc.util.PageUtil;

public interface TagService {

	// 根据id获取type
	Tag getTag(Long id);

    // 根据类型名字获取type
	Tag getTagByName(String name);

    // 保存或修改一个标签
	Integer saveOrUpdate(Tag tag);

    // 删除type
    Integer deleteTag(Long id);
    
    PageUtil<Tag> getListPage(Integer currentPage,Integer pageSize);
    
    // 查询所有标签
    List<Tag> getListTag();
    
    List<Tag> getListTag(String ids);
    
    // 查询前几的tag
	List<Tag> getListTagTop(Integer size);
    
}
