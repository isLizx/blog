package cn.edu.hzvtc.util;

import java.util.List;

public class PageUtil<T> {
	private Integer pageNo;//当前页码
	private Integer pageSize;//每页显示的条目
	private Integer recordCount;//记录总数
	private List<T> dataList;//当前页需要显示的记录集合
	private Integer pageCount;
	
	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}

	public Integer getPageNo() {
		return pageNo;
	}
	
	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {		
		if(recordCount != null){
			pageCount = recordCount%pageSize == 0 ? recordCount/pageSize : recordCount/pageSize+1;
		}
		this.pageSize = pageSize;
	}
	
	public void setRecordCount(Integer recordCount) {		
		this.recordCount = recordCount;
		if(pageSize != null){
			pageCount = recordCount%pageSize == 0 ? recordCount/pageSize : recordCount/pageSize+1;
		}
		if(pageNo > pageCount)
			pageNo = pageCount;
		if(pageNo < 1)
			pageNo = 1;
	}
	
	
	public void setDataList(List<T> dataList) {
		this.dataList = dataList;
	}

	public List<T> getDataList() {
		return dataList;
	}
	
	public Integer getPageCount() {
		return pageCount;
	}
	
	//样式： 首页 上一页 下一页 末页
	private Integer pageFirst;//首页
	private Integer pagePrev;//上一页
	private Integer pageNext;//下一页
	private Integer pageLast;//末页
	
	public Integer getPageFirst() {
		pageFirst = 1;		
		return pageFirst;
	}
	
	public Integer getRecordCount() {
		return recordCount;
	}

	public Integer getPageLast() {
		pageLast = pageCount;
		return pageLast;
	}
	
	public Integer getPagePrev() {
		if(pageNo > 1)
			pagePrev = pageNo - 1;
		else
			pagePrev =1;
		return pagePrev;
	}
	
	public Integer getPageNext() {
		if(pageNo < pageCount)
			pageNext = pageNo + 1;
		else
			pageNext = pageCount;				
		return pageNext;
	}
	
	//样式: 。。。 7 8 9 10 11 。。。
	private Integer pageStartDot;
	private Integer pageStart;
	private Integer pageEnd;
	private Integer pageEndDot;
	
	private Integer pageField = 2;
	
	public Integer getPageStartDot() {
		pageStartDot = getPageStart();
		if(pageStartDot > 1)
			pageStartDot --;		
		return pageStartDot;
	}
	
	public Integer getPageStart() {
		pageStart = pageNo;
		for(int i = 0;i < pageField;i++){
			if(pageStart>1)
				pageStart--;
		}		
		return pageStart;
	}
	public Integer getPageEnd() {
		pageEnd = pageNo;
		for(int i = 0;i < pageField;i++){
			if(pageEnd < pageCount)
				pageEnd++;
		}		
		return pageEnd;
	}
	public Integer getPageEndDot() {
		pageEndDot = getPageEnd();
		if(pageEnd < pageCount)
			pageEndDot++;
		return pageEndDot;
	}
}
