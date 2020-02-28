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
        <h2 class="ui teal header item">管理后台</h2>
        <a href="${pageContext.request.contextPath }/templates/admin/blog_listpage.action?currentPage=1" class="m-item item m-mobile-hide" id="menu1"><i class="mini home icon"></i>博客</a>
        <a href="${pageContext.request.contextPath }/templates/admin/type_listpage.action?currentPage=1" class=" m-item item m-mobile-hide" id="menu2"><i class="mini idea icon"></i>分类</a>
        <a href="${pageContext.request.contextPath }/templates/admin/tag_listpage.action?currentPage=1" class="m-item item m-mobile-hide" id="menu3"><i class="mini tags icon"></i>标签</a>
        <div class="right m-item m-mobile-hide menu">
          <div class="ui dropdown  item">
            <div class="text">
              <img class="ui avatar image" src="${user.avatar }">
              ${user.username }
            </div>
            <i class="dropdown icon"></i>
            <div class="menu">
              <a href="${pageContext.request.contextPath }/templates/admin/user_logout.action" class="item">注销</a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <a href="#" class="ui menu toggle black icon button m-right-top m-mobile-show">
      <i class="sidebar icon"></i>
    </a>
  </nav>
