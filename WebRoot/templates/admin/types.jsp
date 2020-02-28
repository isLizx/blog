<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.w3.org/1999/xhtml">
<head th:replace="admin/_fragments :: head(~{::title})">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>分类管理</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/semantic-ui/2.2.4/semantic.min.css">
  <link rel="stylesheet" href="../../staticfile/css/me.css">
</head>
<body>

  <!--导航-->
  <c:import url="nav.jsp"></c:import>
  <div class="ui attached pointing menu">
    <div class="ui container">
      <div class="right menu">
        <a href="${pageContext.request.contextPath }/templates/admin/type_toAddPage?id=${type.id}&currentPage=${pageUtil.pageCount + 1}" class="item">新增</a>
        <a href="#" class="teal active item">列表</a>
      </div>
    </div>
  </div>

  <!--中间内容-->
  <div  class="m-container-small m-padded-tb-big">
    <div class="ui container">
      <c:if test="${sessionScope.msg ne null && sessionScope.msg ne '' }">
      	<div class="ui success message" id="infoMessageStatus">
	        <i class="close icon"></i>
	        <div class="header">提示：</div>
	        <p>${sessionScope.msg }</p>
      	</div>
      </c:if>
      <c:set var="theString" value="${sessionScope.msg }"/>
      <c:remove var="msg" scope="session" />
      <table class="ui celled table" id="table">
        <thead>
          <tr>
            <th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
            <th>名称</th>
            <th>操作</th>
          </tr>
        </thead>
        <tbody>
        <c:set var="i" value="1" />
        <c:forEach items="${pageUtil.dataList }" var="type">
	        <tr>
	            <td>${((pageUtil.pageNo)-1)*pageUtil.pageSize+i }</td>
	            <td>${type.name }</td>
	            <td>
	              <a href="${pageContext.request.contextPath }/templates/admin/type_findTypeById.action?id=${type.id}&currentPage=${pageUtil.pageNo}" class="ui mini teal basic button">编辑</a>
	              <a href="${pageContext.request.contextPath }/templates/admin/type_ajaxDelete.action?id=${type.id}&currentPage=${pageUtil.pageNo}" class="ui mini red basic button ajaxDelete">删除</a>
	              <input type="hidden" value="${type.name }" class="typename">
	            </td>
	          </tr>
	          <c:set var="i" value="${i+1}" />
        </c:forEach>
          
          
        </tbody>
        <tfoot>
          <tr>
            <th colspan="6" >
              <div class="ui mini pagination menu">
              <!-- 
				当前页-1 
				判断如果第一页，没有前一页
				如果最后一页，没有后一页
			 -->
				  <c:if test="${pageUtil.pageNo != 1}">
	                <a href="type_listpage.action?currentPage=${pageUtil.pagePrev}" class="  item">上一页</a>
	              </c:if>
	              <c:if test="${pageUtil.pageNo == 1}">
	                <a class="active item">上一页</a>
	              </c:if>
	              <c:if test="${pageUtil.pageNo != pageUtil.pageCount}">
	                <a href="type_listpage.action?currentPage=${pageUtil.pageNext}" class=" item">下一页</a>
	              </c:if>
	              <c:if test="${pageUtil.pageNo == pageUtil.pageCount}">
	                <a class="active item">下一页</a>
	              </c:if>
              </div>
              <a href="type_toAddPage.action?currentPage=${pageUtil.pageCount + 1 }"  class="ui mini right floated teal basic button">新增</a>
            </th>
          </tr>
        </tfoot>
      </table>
    </div>
  </div>

  <br>
  <br>
  <!--底部footer-->
  <c:import url="footer.jsp"></c:import>
  <!--/*/<th:block th:replace="_fragments :: script">/*/-->
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
		$("#menu2").addClass("active");
	});
    $('.menu.toggle').click(function () {
      $('.m-item').toggleClass('m-mobile-hide');
    });

    $('.ui.dropdown').dropdown({
      on : 'hover'
    });

    //消息提示关闭初始化
    $('.message .close')
      .on('click', function () {
        $(this)
          .closest('.message')
          .transition('fade');
      });
    $(function(){
    	// 异步删除
    	$(document).on("click",".ajaxDelete",function(){
    		  var typename = $(this).next(".typename").val();
    		  var flag = confirm("确定要删除"+typename+"吗?");
    		  if(flag){ 
    			  var url = this.href;
    			  $.ajax({
    				  url:url,
    				  type:"post",
    				  dataType:"json",
    				  success:function(data){
    					renderBlog(data);
    				  }
    			  });
    		  }
    		  return false;
    	  });
    	
    	
    	 function renderBlog(data){
   		  $("tbody").remove();
   		  $("tfoot").remove();
   		  var pageUtil = data.pageUtil;
   		  var types = data.pageUtil.dataList;
   		  var msg = data.msg;
   		  var str = "<tbody>";
   		  if(pageUtil == null || types == null){
   			  $("#table").append("<td colspan='5' class='text-center'><p class='text-info'>没有查询到类型</p></td></tbody>");
   				return;
   		  }
   		  var index = 1;
   		  for(var i in types){
   			  var id = types[i].id;
   			  str += "<tr><td>" + (((pageUtil.pageNo)-1)*pageUtil.pageSize+index) + "</td>";
   			  str += "<td>" + types[i].name + "</td>";
   			  console.log(types[i].id);
   			  str += "<td> <a href='type_findTypeById.action?id=" + id + "&currentPage=" + pageUtil.pageNo + "' class='ui mini teal basic button'>编辑</a>";
   			  str += "<a href='type_ajaxDelete.action?id=" + id + "&currentPage=" + pageUtil.pageNo + "' class='ui mini red basic button ajaxDelete'>删除</a> <input type='hidden' value='" + types[i].name + "' class='typename' /></td></tr>";
   			  index ++;
   		  }
   		
   		
   	  	str += "</tbody><tfoot><tr><th colspan='7'>";
     		str += "<div class='ui mini pagination menu'>";
     		if(pageUtil.pageNo != 1){
     			str += " <a href='type_listpage?currentPage=" + pageUtil.pagePrev + "' class='item' >上一页</a> ";
     		}else{
     			str += " <a class='active item'>上一页</a> ";
     		}
     		if(pageUtil.pageNo < pageUtil.pageCount){
     			str += " <a href='type_listpage?currentPage=" + pageUtil.pageNext + "' class='item' >下一页</a> ";
     		}else{
     			str += " <a class='active item'>下一页</a> ";
     		}
     		str += "</div>";
     		str += " <a href='type_toAddPage.action?currentPage=" + pageUtil.pageNo + "' class='ui mini right floated teal basic button'>新增</a> </th></tr></tfoot>";
     	
   	  	$("table").append(str);
   	  	
   	  	if(msg != null){
   	  		$("#table-container").append("<div class='ui success message' id='infoMessageStatus'><i class='close icon'></i><div class='header'>提示：</div><p>" + msg + "</p>");
   	  	}
   	  	
   	  }
    	  
    });

  </script>
</body>
</html>