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
  <title>归档</title>
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
  <div  class="m-container-small m-padded-tb-big">
    <div class="ui container">
      <!--header-->
      <div class="ui top attached padded segment">
        <div class="ui middle aligned two column grid">
          <div class="column">
            <h3 class="ui teal header">归档</h3>
          </div>
          <div class="right aligned column">
            共 <h2 class="ui orange header m-inline-block m-text-thin"> ${blogCount} </h2> 篇博客
          </div>
        </div>
      </div>

	<c:forEach items="${archiveMap}" var="item">
      <h3 class="ui center aligned header" >${item.key}</h3>
      <div class="ui fluid vertical menu">
      <c:forEach items="${item.value}" var="blog">
        <a href="${pageContext.request.contextPath }/templates/blog_getOneBlog.action?id=${blog.id}" target="_blank" class="item">
          <span>
            <i class="mini teal circle icon"></i><span>${blog.title}</span>
            <div class="ui teal basic left pointing label m-padded-mini ">
            	<fmt:formatDate value="${blog.updateTime}" pattern="MMMdd"/>
            </div>
          </span>
          <div class="ui orange basic left pointing label m-padded-mini ">${blog.flag}</div>
        </a>
      </c:forEach>
      </div>
	</c:forEach>
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
		$("#menu4").addClass("active");
	});
    $('.menu.toggle').click(function () {
      $('.m-item').toggleClass('m-mobile-hide');
    });

  </script>
</body>
</html>