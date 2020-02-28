<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.w3.org/1999/xhtml">
<head th:replace="_fragments :: head(~{::title})">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>搜索结果</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/semantic-ui/2.2.4/semantic.min.css">
  <link rel="stylesheet" href="../staticfile/css/me.css">
  <!-- 在JSP页面中加入head标签
            负责在页面上导入Dojo所需要的CSS库和JavaScript库 -->
</head>
<body>

  <!--导航-->
  <c:import url="nav.jsp"></c:import>

  <!--中间内容-->
  <div  class="m-container-small m-padded-tb-big">
    <div class="ui container">
      <!--header-->
      <div class="ui top attached segment">
        <div class="ui middle aligned two column grid">
          <div class="column">
            <h3 class="ui teal header">搜索结果</h3>
          </div>
          <div class="right aligned column">
            共 <h2 class="ui orange header m-inline-block m-text-thin" > ${pageUtil.recordCount } </h2> 个
          </div>
        </div>
      </div>



      <div class="ui top attached teal segment">
      <c:forEach items="${pageUtil.dataList }" var="blog">
        <div class="ui padded vertical segment m-padded-tb-large" >
          <div class="ui middle aligned mobile reversed stackable grid" >
            <div class="eleven wide column">
              <h3 class="ui header" ><a href="blog_getOneBlog.action?id=${blog.id}" target="_blank" class="m-black">${blog.title}</a></h3>
              <p class="m-text">${blog.description}......</p>
              <div class="ui grid">
                <div class="eleven wide column">
                  <div class="ui mini horizontal link list">
                    <div class="item">
                      <img src="${blog.user.avatar}" alt="作者" class="ui avatar image">
                      <div class="content"><a href="#" class="header" >${blog.user.nickname}</a></div>
                    </div>
                    <div class="item">
                      <i class="calendar icon"></i><span ><fmt:formatDate value="${blog.updateTime}" pattern="yyyy-MM-dd"/></span>
                    </div>
                    <div class="item">
                      <i class="eye icon"></i> <span >${blog.views}</span>
                    </div>
                  </div>
                </div>
                <div class="right aligned five wide column">
                  <a href="#" target="_blank" class="ui teal basic label m-padded-tiny m-text-thin" >${blog.type.name}</a>
                </div>
              </div>
            </div>

            <div class="five wide column">
              <a href="blog_getOneBlog.action?id=${blog.id}" target="_blank">
                <img src="${blog.firstPicture}" alt="" class="ui rounded image">
              </a>
            </div>

          </div>
        </div>
      </c:forEach>
      </div>

      <!--footer-->
      <div class="ui bottom attached segment" >
        <div class="ui middle aligned two column grid">
          <div class="column">
          	<c:if test="${pageUtil.pageNo != 1}">
            	<a href="blog_search.action?currentPage=${pageUtil.pagePrev}&query=${query}" class="ui mini teal basic button">上一页</a>
            </c:if>
            <c:if test="${pageUtil.pageNo <= 1}">
            	<a class="ui mini basic button">上一页</a>
            </c:if>
          </div>
          <div class="right aligned column">
            <c:if test="${pageUtil.pageNo != pageUtil.pageCount}">
            	<a href="blog_search.action?currentPage=${pageUtil.pageNext}&query=${query}" class="ui mini teal basic button">下一页</a>
            </c:if>
            <c:if test="${pageUtil.pageNo == pageUtil.pageCount}">
            	<a class="ui mini basic button">下一页</a>
            </c:if>
          </div>
        </div>
      </div>

    </div>
  </div>

  <br>
  <br>
  <!--底部footer-->
  <c:import url="footer.jsp"></c:import>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.2/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/semantic-ui/2.2.4/semantic.min.js"></script>

  <script>
  $(document).ready(function() {
		$("#menu1").addClass("active");
	});
    $('.menu.toggle').click(function () {
      $('.m-item').toggleClass('m-mobile-hide');
    });

  </script>
</body>
</html>