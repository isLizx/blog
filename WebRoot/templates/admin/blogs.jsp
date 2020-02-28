<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="/struts-dojo-tags" prefix="sx"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>博客管理</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/semantic-ui/2.2.4/semantic.min.css">
  <link rel="stylesheet" href="../../staticfile/css/me.css">
  <!-- 在JSP页面中加入head标签
            负责在页面上导入Dojo所需要的CSS库和JavaScript库 -->
        <sx:head />
</head>
<body>

  <!--导航-->
  <c:import url="nav.jsp"></c:import>
  <div class="ui attached pointing menu">
    <div class="ui container">
      <div class="right menu">
        <a href="blog_toAddPage" class=" item">新增</a>
        <a href="#" class="teal active item">列表</a>
      </div>
    </div>
  </div>

  <!--中间内容-->
  <div  class="m-container-small m-padded-tb-big">
    <div class="ui container">
      <div  class="ui secondary segment form">
        <input type="hidden" name="page" value="0" >
        <div class="inline fields">
          <div class="field">
            <input type="text" name="title" placeholder="标题">
          </div>
          <div class="field">
            <div class="ui labeled action input">
              <div class="ui type selection dropdown">
                <input type="hidden" name="typeId">
                <i class="dropdown icon"></i>
                <div class="default text">分类</div>
                <div class="menu">
                  <c:forEach items="${listType }" var="type">
                  	<div class="item" data-value="${type.id }">${type.name }</div>
                  </c:forEach>
                </div>
              </div>
              <button id="clear-btn" class="ui compact button">clear</button>
            </div>

          </div>
          <div class="field">
            <div class="ui checkbox">
              <input type="checkbox" id="recommend" name="recommend" value="true">
              <label for="recommend">推荐</label>
            </div>
          </div>
          <div class="field">
            <button  type="button" id="ajaxSearch" class="ui mini teal basic button "><i class="search icon"></i>搜索</button>
          </div>
        </div>
      </div>
      <div id="table-container">
        <table class="ui compact teal table">
          <thead>
          <tr>
            <th></th>
            <th>标题</th>
            <th>类型</th>
            <th>推荐</th>
            <th>状态</th>
            <th>更新时间</th>
            <th>操作</th>
          </tr>
          </thead>
          <tbody>
          <c:set var="i" value="1" />
          <c:forEach items="${pageUtil.dataList }" var="blog" >
          	   <tr>
	            <td>${((pageUtil.pageNo)-1)*pageUtil.pageSize+i }</td>
	            <td>${blog.title}</td>
	            <td>${blog.type.name}</td>
	            <td>${blog.recommend ? '是':'否'}</td>
	            <td>${blog.published ? '发布':'草稿'}</td>
	            <td><fmt:formatDate value="${blog.updateTime}" type="both"  pattern="yyyy-MM-dd HH:mm:ss"/></td>
	            <td>
	              <a href="${pageContext.request.contextPath }/templates/admin/blog_toUpdatePage.action?id=${blog.id}&currentPage=${pageUtil.pageNo}" class="ui mini teal basic button">编辑</a>
	              <a href="${pageContext.request.contextPath }/templates/admin/blog_ajaxDelete.action?id=${blog.id}&currentPage=${pageUtil.pageNo}" class="ui mini red basic button ajaxDelete">删除</a>
	              <input type="hidden" value="${blog.title}" class="title"/>
	              <input type="hidden" value="${blog.id}" class="blogId"/>
	            </td>
	          </tr>
	          <c:set var="i" value="${i+1}" />
          </c:forEach>
          
          </tbody>
          <tfoot>
          <tr>
            <th colspan="7">
              <div class="ui mini pagination menu">
              <c:if test="${pageUtil.pageNo != 1}">
                <a href="blog_listpage?currentPage=${pageUtil.pagePrev}" class="item" >上一页</a>
              </c:if>
              <c:if test="${pageUtil.pageNo == 1}">
                <a class="active item">上一页</a>
              </c:if>
              <c:if test="${pageUtil.pageNo < pageUtil.pageCount}">
                <a href="blog_listpage?currentPage=${pageUtil.pageNext}" class="item" >下一页</a>
              </c:if>
              <c:if test="${pageUtil.pageNo >= pageUtil.pageCount}">
                <a class="active item">下一页</a>
              </c:if>
              </div>
              <a href="blog_toAddPage.action" class="ui mini right floated teal basic button">新增</a>
            </th>
          </tr>
          </tfoot>
        </table>

        <c:if test="${sessionScope.msg ne null && sessionScope.msg ne '' }">
      	<div class="ui success message" id="infoMessageStatus">
	        <i class="close icon"></i>
	        <div class="header">提示：</div>
	        <p>${sessionScope.msg }</p>
      	</div>
      </c:if>
      <c:set var="theString" value="${sessionScope.msg }"/>
      <c:remove var="msg" scope="session" />
      </div>
    </div>
  </div>

  <br>
  <br>
  <!--底部footer-->
  <c:import url="footer.jsp"></c:import>
  <!--/*/<th:block th:replace="admin/_fragments :: script">/*/-->
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.2/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/semantic-ui/2.2.4/semantic.min.js"></script>
  <!--/*/</th:block>/*/-->
  
   <!-- 根据传递过来的信息是否包含！，来判断是否位错误信息。 -->
  <c:if test="${fn:contains(theString, '!') }">
	<script type="text/javascript">
		$("#infoMessageStatus").removeClass("success").addClass("negative");
	</script>
  </c:if>
  <script>
  $(document).ready(function() {
		$("#menu1").addClass("active");
		
		$('.menu.toggle').click(function () {
		      $('.m-item').toggleClass('m-mobile-hide');
		 });

	    $('.ui.dropdown').dropdown({
	      on : 'hover'
	    });
	    
	    //消息提示关闭初始化
	     $(document).on("click",".message .close",function(){
	    	 $(this)
	          .closest('.message')
	          .transition('fade');
	     });
/* 	    $('.message .close')
	      .on('click', function () {
	        $(this)
	          .closest('.message')
	          .transition('fade');
	     }); */
	    
		// 清除条件设置
	    $('#clear-btn')
	      .on('click', function() {
	        $('.ui.type.dropdown')
	          .dropdown('clear')
	        ;
	     });
		
	      /* function page(obj) {
	        $("[name='page']").val($(obj).data("page"));
	        loaddata();
	     }   */

	      $("#search-btn").click(function () {
	        $("[name='page']").val(0);
	        loaddata();
	      });
	       
	      function loaddata() {
	    	  var title = $("[name='title']").val();
			  var typeId = $("[name='typeId']").val();
			  var recommend = $("[name='recommend']").prop('checked');
			  var currentPage = $("[name='page']").val();
			  
			  location.href = "blog_search?title="+title+"&typeId="+typeId+"&recommend="+recommend+"&currentPage="+currentPage;
	      } 
	});
  
  $(function(){
	  // 异步查询
	  $(document).on("click","#ajaxSearch",function(){
		  $("[name='page']").val(-1);
		  var title = $("[name='title']").val();
		  var typeId = $("[name='typeId']").val();
		  var recommend = $("[name='recommend']").prop('checked');
		  var currentPage = $("[name='page']").val();
		  $.ajax({
			  url:"blog_ajaxSearch",
			  type:"post",
			  data:{
				  "title":title,
				  "typeId":typeId,
				  "recommend":recommend,
				  "currentPage":currentPage
			  },
			  dataType:"json",
			  success:function(data){
				renderBlog(data);
			  }
		  });
	  });
	// 异步删除
	$(document).on("click",".ajaxDelete",function(){
		  var title = $(this).next(".title").val();
		  var flag = confirm("确定要删除"+title+"吗?");
		  if(flag){ 
			  var currentPage = $("[name='page']").val();
			 
			  var url = this.href;
			  if(currentPage == -1){
				  var STitle= $("[name='title']").val();
				  var typeId = $("[name='typeId']").val();
				  var recommend = $("[name='recommend']").prop('checked');
				  var blogId = $(this).next().next(".blogId").val();
				  url = "blog_ajaxDelete.action?" + "currentPage=0" + "&title=" + STitle + "&typeId=" + typeId + "&recommend=" + recommend + "&id=" + blogId;
			  }
			  $.ajax({
				  url:url,
				  type:"post",
				  dataType:"json",
				  success:function(data){
					renderBlog(data);
					if(data.pageUtil.pageNo!=null){
						$("[name='page']").val(data.pageUtil.pageNo);
					}
				  }
			  });
		  }
		  return false;
	  });
	  
	// 异步分页查询
	  $(document).on("click",".ajaxSearchByPage",function(){
		  var url = this.href;
		  $.ajax({
			  url:url,
			  type:"post",
			  dataType:"json",
			  success:function(data){
				renderBlog(data);
				if(data.pageUtil.pageNo!=null){
					$("[name='page']").val(data.pageUtil.pageNo);
				}
			  }
		  });
		  return false;
	  });
	  
	  function renderBlog(data){
		  $("tbody").remove();
		  $("tfoot").remove();
		  var str = "<tbody>";
		  if(data.pageUtil == null || data.pageUtil.dataList == null){
			  $("table").append("<tbody><tr style='height:100px'><td colspan='4'></td><td colspan='1'>没有查询到符合条件的博客</td><td colspan='2'></td></tr></tbody>");
				return;
		  }
		  var pageUtil = data.pageUtil;
		  var blogs = data.pageUtil.dataList;
		  var msg = data.msg;
		  var index = 1;
		  for(var i in blogs){
			  var recommend = blogs[i].recommend ? '是':'否';
			  var published = blogs[i].published ? '发布':'草稿';
			  str += "<tr><td>" + (((pageUtil.pageNo)-1)*pageUtil.pageSize+index) + "</td>";
			  str += "<td>" + blogs[i].title + "</td>";
			  str += "<td>" + blogs[i].type.name + "</td>";
			  str += "<td>" + recommend + "</td>";
			  str += "<td>" + published + "</td>";
			  str += "<td>" + blogs[i].updateTime + "</td><td> <a href='blog_toUpdatePage.action?id=" + blogs[i].id + "&currentPage=" + pageUtil.pageNo + "' class='ui mini teal basic button'>编辑</a>  <a href='blog_ajaxDelete.action?id=" + blogs[i].id + "&currentPage=" + pageUtil.pageNo + "' class='ui mini red basic button ajaxDelete'>删除</a> <input type='hidden' value='" + blogs[i].title + "' class='title'/><input type='hidden' value='" + blogs[i].id + "' class='blogId'/> </td></tr>";
			  index ++;
			  
		  }
		
	  	str += "</tbody><tfoot><tr><th colspan='7'>";
  		str += "<div class='ui mini pagination menu'>";
  		if(pageUtil.pageNo != 1){
  			str += " <a href='blog_ajaxSearchByPage?currentPage=" + pageUtil.pagePrev + "' class='item ajaxSearchByPage' >上一页</a> ";
  		}else{
  			str += " <a class='active item'>上一页</a> ";
  		}
  		if(pageUtil.pageNo < pageUtil.pageCount){
  			str += " <a href='blog_ajaxSearchByPage?currentPage=" + pageUtil.pageNext + "' class='item ajaxSearchByPage' >下一页</a> ";
  		}else{
  			str += " <a class='active item'>下一页</a> ";
  		}
  		str += "</div>";
  		str += " <a href='blog_toAddPage.action' class='ui mini right floated teal basic button'>新增</a> </th></tr></tfoot>";
  	
	  	$("table").append(str);
	  	
	  	if(msg != null){
	  		$("#table-container").append("<div class='ui success message' id='infoMessageStatus'><i class='close icon'></i><div class='header'>提示：</div><p>" + msg + "</p>");
	  	}
	  	
	  }
  });
    

    

  </script>
</body>
</html>