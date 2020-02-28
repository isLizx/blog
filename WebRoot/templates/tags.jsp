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
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>标签</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/semantic-ui/2.2.4/semantic.min.css">
  <link rel="stylesheet" href="../staticfile/css/me.css">
  <!-- 在JSP页面中加入head标签
            负责在页面上导入Dojo所需要的CSS库和JavaScript库 -->
<sx:head />
</head>
<body>

  <!--导航-->
  <c:import url="nav.jsp"></c:import>

  <!--中间内容-->
  <div  class="m-container-small m-padded-tb-big animated fadeIn">
    <div class="ui container">
      <!--header-->
      <div class="ui top attached segment">
        <div class="ui middle aligned two column grid">
          <div class="column">
            <h3 class="ui teal header">标签</h3>
          </div>
          <div class="right aligned column">
            共 <h2 class="ui orange header m-inline-block m-text-thin"> ${fn:length(tags)} </h2> 个
          </div>
        </div>
      </div>

      <div class="ui attached segment m-padded-tb-large">
	      <c:forEach items="${tags}" var="tag">
	      	<c:if test="${fn:length(tag.blogs) eq 0}">
		         <a class="ui basic left pointing large label m-margin-tb-tiny ">
		         <span>${tag.name}</span> <div class="detail">${fn:length(tag.blogs)}</div>
		         </a>
	      	</c:if>
	      	<c:if test="${fn:length(tag.blogs) ne 0}">
		         <a href="tag_tags.action?tagId=${tag.id}" class="ui basic left pointing large label m-margin-tb-tiny ${tag.id==activeTagId ? 'teal':''}" >
		         <span>${tag.name}</span> <div class="detail">${fn:length(tag.blogs)}</div>
		         </a>
	      	</c:if>
	      </c:forEach>
      </div>

      <div class="ui top attached teal segment">
      <c:forEach items="${pageUtil.dataList}" var="blog">
        <div class="ui padded vertical segment m-padded-tb-large">
          <div class="ui middle aligned mobile reversed stackable grid" >
            <div class="eleven wide column">
              <h3 class="ui header" ><a href="blog_getOneBlog.action?id=${blog.id}" target="_blank" class="m-black" >${blog.title}</a></h3>
              <p class="m-text" >${blog.description}......</p>
              <div class="ui grid">
                <div class="row">
                  <div class="eleven wide column">
                    <div class="ui mini horizontal link list">
                      <div class="item">
                        <img src="${blog.user.avatar}" alt="" class="ui avatar image">
                        <div class="content"><a href="#" class="header" >${blog.user.nickname}</a></div>
                      </div>
                      <div class="item">
                        <i class="calendar icon"></i><span><fmt:formatDate value="${blog.updateTime}" pattern="yyyy-MM-dd"/></span>
                      </div>
                      <div class="item">
                        <i class="eye icon"></i> <span>${blog.views}</span>
                      </div>
                    </div>
                  </div>
                  <div class="right aligned five wide column">
                    <a href="${pageContext.request.contextPath }/templates/type_types.action?typeId=${blog.type.id}" target="_blank" class="ui teal basic label m-padded-tiny m-text-thin">${blog.type.name}</a>
                  </div>
                </div>
                <div class="row">
                  <div class="column">
                  <c:forEach items="${blog.tags}" var="tag">
                    <a href="${pageContext.request.contextPath }/templates/tag_tags.action?tagId=${tag.id}" class="ui  basic left pointing label m-padded-mini m-text-thin ${tag.id==activeTagId ? 'teal':''}">${tag.name}</a>
                  </c:forEach>
                  </div>
                </div>
              </div>
            </div>

            <div class="five wide column">
              <a href="${pageContext.request.contextPath }/templates/blog_getOneBlog.action?id=${blog.id}" target="_blank">
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
            	<a href="tag_tags.action?currentPage=${pageUtil.pagePrev}&activeTagId=${activeTagId}" class="ui mini teal basic button">上一页</a>
            </c:if>
            <c:if test="${pageUtil.pageNo<=1}">
            	<a class="ui mini basic button">上一页</a>
            </c:if>
          </div>
          <div class="right aligned column">
            <c:if test="${pageUtil.pageNo != pageUtil.pageCount}">
            	<a href="tag_tags.action?currentPage=${pageUtil.pageNext}&activeTagId=${activeTagId}" class="ui mini teal basic button">下一页</a>
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
  <!--/*/<th:block th:replace="_fragments :: script">/*/-->
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.2/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/semantic-ui/2.2.4/semantic.min.js"></script>
  <!--/*/</th:block>/*/-->

  <script>
  $(document).ready(function() {
		$("#menu3").addClass("active");
	});
    $('.menu.toggle').click(function () {
      $('.m-item').toggleClass('m-mobile-hide');
    });

  </script>
</body>
</html>