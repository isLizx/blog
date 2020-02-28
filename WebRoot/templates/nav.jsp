<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
 <!--导航-->
  <nav class="ui inverted attached segment m-padded-tb-mini m-shadow-small" >
    <div class="ui container">
      <div class="ui inverted secondary stackable menu">
        <h2 class="ui teal header item">Blog</h2>
        <a href="${pageContext.request.contextPath }/templates/blog_index.action" class=" m-item item m-mobile-hide" id="menu1"><i class="mini home icon"></i>首页</a>
        <a href="${pageContext.request.contextPath }/templates/type_types.action" class=" m-item item m-mobile-hide" id="menu2"><i class="mini idea icon"></i>分类</a>
        <a href="${pageContext.request.contextPath }/templates/tag_tags.action" class="m-item item m-mobile-hide" id="menu3"><i class="mini tags icon"></i>标签</a>
        <a href="${pageContext.request.contextPath }/templates/archive_archives.action" class="m-item item m-mobile-hide" id="menu4"><i class="mini clone icon"></i>归档</a>
        <a href="${pageContext.request.contextPath }/templates/about.action" class="m-item item m-mobile-hide" id="menu5"><i class="mini info icon"></i>关于我</a>
        <div class="right m-item item m-mobile-hide">
        <form name="search" action="blog_search.action" method="post" target="_blank">
          <div class="ui icon inverted transparent input m-margin-tb-tiny">
            <input type="text" placeholder="Search...." name="query" value="${query }">
            <i onclick="document.forms['search'].submit()" class="search link icon"></i>
          </div>
        </form>
        </div>
      </div>
    </div>
    <a href="#" class="ui menu toggle black icon button m-right-top m-mobile-show">
      <i class="sidebar icon"></i>
    </a>
  </nav>

