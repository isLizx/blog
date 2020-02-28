package cn.edu.hzvtc.service.impl;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import cn.edu.hzvtc.bean.Type;
import cn.edu.hzvtc.repository.TypeRepository;
import cn.edu.hzvtc.service.TypeService;
import cn.edu.hzvtc.util.PageUtil;


public class TypeServiceImpl implements TypeService {
	private TypeRepository typeRepository;

	public void setTypeRepository(TypeRepository typeRepository) {
		this.typeRepository = typeRepository;
	}
	@Transactional
	public Type getType(Long id) {
		return typeRepository.getTById(id);
	}

	@Transactional
	public Type getTypeByName(String name) {
		return typeRepository.getTypeByName(name);
	}
	

	@Transactional
	public Integer deleteType(Long id) {
		Integer result = 0;
		Type t = typeRepository.getTById(id);
		if (t == null) {
			result = -1;
		}else{
			typeRepository.delete(t);
			result = 1;
		}
		return result;
	}

	// 封装分页数据到pagebean对象里面
	@Transactional
	public PageUtil<Type> getListPage(Integer currentPage, Integer pageSize) {
		PageUtil<Type> result = null;
		if(currentPage == null){
			currentPage = 1;
		}
		
		result = new PageUtil<Type>();
		result.setPageNo(currentPage);
		result.setPageSize(pageSize);
		result.setRecordCount(typeRepository.getCount());
		result.setDataList(typeRepository.getPage(result.getPageNo(), result.getPageSize()));
		

		return result;
	}

	@Override
	public List<Type> getListType() {
		return typeRepository.getAll();
	}

	@Override
	public List<Type> getListTypeTop(Integer size) {
		return typeRepository.getListTypeTop(size);
	}

	@Transactional
	public Integer saveOrUpdate(Type type) {
		Integer result = 0;
		if(type.getId() == null || type.getId() == 0){
			typeRepository.saveOrUpdate(type);
			result = 1;
		}else{
			Type typeDB = typeRepository.getTById(type.getId());
			if(typeDB != null){
				typeDB.setName(type.getName());
				
				typeRepository.saveOrUpdate(typeDB);
				result = 1;
			}else{
				result = -1;
			}
		}
		
		return result;
	}

}
