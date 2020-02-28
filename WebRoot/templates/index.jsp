<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib uri="/struts-dojo-tags" prefix="sx"%>
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.w3.org/1999/xhtml">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>首页</title>
  <link rel="shortcut icon" href="../staticfile/images/browsehander.jpg">
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
  <div  class="m-container m-padded-tb-big">
    <div class="ui container">
      <div class="ui stackable grid">
        <!--左边博客列表-->
        <div class="eleven wide column">
          <!--header-->
          <div class="ui top attached segment">
            <div class="ui middle aligned two column grid">
              <div class="column">
                <h3 class="ui teal header">博客</h3>
              </div>
              <div class="right aligned column">
                共 <h2 class="ui orange header m-inline-block m-text-thin"> ${pageUtil.recordCount} </h2> 篇
              </div>
            </div>
          </div>

          <!--content-->
          <div class="ui attached  segment">
		<c:forEach items="${pageUtil.dataList }" var="blog">
            <div class="ui padded vertical segment m-padded-tb-large" >
              <div class="ui middle aligned mobile reversed stackable grid" >
                <div class="eleven wide column">
                  <h3 class="ui header" ><a href="blog_getOneBlog.action?id=${blog.id}" target="_blank" class="m-black" >${blog.title}</a></h3>
                  <p class="m-text">${blog.description}......</p>
                  <div class="ui grid">
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
                      <a href="type_types.action?typeId=${blog.type.id}" target="_blank" class="ui teal basic label m-padded-tiny m-text-thin" >${blog.type.name}</a>
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
              	<c:if test="a">
                	<a href="blog_index.action?currentPage=${pageUtil.pagePrev}" class="ui mini teal basic button">上一页</a>
                </c:if>
                <c:if test="${pageUtil.pageNo<=1}">
                	<a class="ui mini basic button">上一页</a>
                </c:if>
              </div>
              <div class="right aligned column">
                <c:if test="${pageUtil.pageNo != pageUtil.pageCount}">
                	<a href="blog_index.action?currentPage=${pageUtil.pageNext}" class="ui mini teal basic button">下一页</a>
                </c:if>
                <c:if test="${pageUtil.pageNo == pageUtil.pageCount}">
                	<a class="ui mini basic button">下一页</a>
                </c:if>
              </div>
            </div>
          </div>
        </div>

        <!--右边的top-->
        <div class="five wide column">
        
          <!--天气-->
          <div class="ui segments">
						<iframe
							src="//www.seniverse.com/weather/weather.aspx?uid=UA8CFD0221&cid=CHBJ000000&l=zh-CHS&p=SMART&a=1&u=C&s=1&m=0&x=1&d=5&fc=&bgc=&bc=&ti=0&in=0&li="
							frameborder="0" scrolling="no" width="100%" height="100%"
							allowTransparency="true"></iframe>
					</div>

          <!--分类-->
          <div class="ui segments">
            <div class="ui secondary segment">
              <div class="ui two column grid">
                <div class="column">
                  <i class="idea icon"></i>分类
                </div>
                <div class="right aligned column">
                  <a href="type_types.action" target="_blank">more <i class="angle double right icon"></i></a>
                </div>
              </div>
            </div>
            <div class="ui teal segment">
              <div class="ui fluid vertical menu" >
              <c:forEach items="${listTypes }" var="type">
                <c:if test="${(fn:length(type.blogs)) > 0}">
                	<a href="type_types.action?typeId=${type.id}" target="_blank" class="item">
	                  <span>${type.name}</span>
	                  <div class="ui teal basic left pointing label" >${fn:length(type.blogs)}</div>
	                </a>
                </c:if>
              </c:forEach>
              </div>
            </div>
          </div>

          <!--标签-->
          <div class="ui segments m-margin-top-large">
            <div class="ui secondary segment">
              <div class="ui two column grid">
                <div class="column">
                  <i class="tags icon"></i>标签
                </div>
                <div class="right aligned column">
                  <a href="tag_tags.action" target="_blank">more <i class="angle double right icon"></i></a>
                </div>
              </div>
            </div>
            <div class="ui teal segment">
            <c:forEach items="${listTags }" var="tag">
              <c:if test="${(fn:length(tag.blogs)) > 0}">
              	  <a href="tag_tags.action?tagId=${tag.id }" target="_blank" class="ui teal basic left pointing label m-margin-tb-tiny" >
	                <span>${tag.name}</span> <div class="detail">${fn:length(tag.blogs)}</div>
	              </a>
              </c:if>
            </c:forEach>
            </div>
          </div>

          <!--最新推荐-->
          <div class="ui segments m-margin-top-large">
            <div class="ui secondary segment ">
              <i class="bookmark icon"></i>最新推荐
            </div>
            <c:forEach items="${listRecommendBlogs }" var="recommendBlog">
	            <div class="ui segment" >
	              <a href="#" target="_blank" class="m-black m-text-thin" >${recommendBlog.title }</a>
	            </div>
            </c:forEach>
          </div>

          <!--二维码-->
          <h4 class="ui horizontal divider header m-margin-top-large">扫码关注我</h4>
          <div class="ui centered card" style="width: 11em">
            <img src="../staticfile/images/wechat.jpg" alt="" class="ui rounded image" >
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
	<script>
  (function(a,h,g,f,e,d,c,b){b=function(){d=h.createElement(g);c=h.getElementsByTagName(g)[0];d.src=e;d.charset="utf-8";d.async=1;c.parentNode.insertBefore(d,c)};a["SeniverseWeatherWidgetObject"]=f;a[f]||(a[f]=function(){(a[f].q=a[f].q||[]).push(arguments)});a[f].l=+new Date();if(a.attachEvent){a.attachEvent("onload",b)}else{a.addEventListener("load",b,false)}}(window,document,"script","SeniverseWeatherWidget","//cdn.sencdn.com/widget2/static/js/bundle.js?t="+parseInt((new Date().getTime() / 100000000).toString(),10)));
  window.SeniverseWeatherWidget('show', {
    flavor: "slim",
    location: "WX4FBXXFKE4F",
    geolocation: true,
    language: "auto",
    unit: "c",
    theme: "light",
    token: "58d6e44e-9e1f-4ea1-8795-40e43a6af088",
    hover: "always",
    container: "tp-weather-widget"
  });
</script>
	<c:if test="${pageUtil eq null }">
  	<script>
  		window.location.href="blog_index.action";
  	</script>
  </c:if>
</body>
</html>