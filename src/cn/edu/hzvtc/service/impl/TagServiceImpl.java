package cn.edu.hzvtc.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import cn.edu.hzvtc.bean.Tag;
import cn.edu.hzvtc.repository.TagRepository;
import cn.edu.hzvtc.service.TagService;
import cn.edu.hzvtc.util.PageUtil;



public class TagServiceImpl implements TagService {
	private TagRepository tagRepository;

	public void setTagRepository(TagRepository tagRepository) {
		this.tagRepository = tagRepository;
	}

	
	@Transactional
	public Tag getTag(Long id) {
		return tagRepository.getTById(id);
	}

	@Transactional
	public Tag getTagByName(String name) {
		return tagRepository.getTagByName(name);
	}
	
	@Transactional
	public Integer deleteTag(Long id) {
		Integer result = 0;
		Tag t = tagRepository.getTById(id);
		if (t != null) {
			tagRepository.delete(t);
			result = 1;
		}else{
			result = -1;
		}
		return result;
	}

	// 封装分页数据到pagebean对象里面
	@Transactional
	public PageUtil<Tag> getListPage(Integer currentPage, Integer pageSize) {
		if(currentPage ==null){
			currentPage = 1;
		}
		
		PageUtil<Tag> result = null;
		
		result = new PageUtil<Tag>();
		
		result.setPageNo(currentPage);
		result.setPageSize(pageSize);
		result.setRecordCount(tagRepository.getCount());
		result.setDataList(tagRepository.getPage(result.getPageNo(), result.getPageSize()));
	
		return result;
	}

	public List<Tag> getListTag() {
		return tagRepository.getAll();
	}

	private List<Long> convertToList(String ids) {
		List<Long> list = new ArrayList<>();
        if (!"".equals(ids) && ids != null) {
            String[] idarray = ids.split(",");
            for (int i=0; i < idarray.length;i++) {
                list.add(new Long(idarray[i]));
            }
        }
        return list;
	}

	@Override
	public List<Tag> getListTag(String ids) {
		return tagRepository.getListType(convertToList(ids));
	}

	@Override
	public List<Tag> getListTagTop(Integer size) {
		return tagRepository.getListTagTop(size);
	}

	@Transactional
	public Integer saveOrUpdate(Tag tag) {
		Integer result = 0;
		if(tag.getId() == null || tag.getId() == 0){
			tagRepository.saveOrUpdate(tag);
			result = 1;
		}else{
			Tag tagDB = tagRepository.getTById(tag.getId());
			if(tagDB != null){
				tagDB.setName(tag.getName());
				tagRepository.saveOrUpdate(tagDB);
				result = 1;
			}else{
				result = -1;
			}
		}
		return result;
	}



	

}
