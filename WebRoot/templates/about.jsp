<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>关于我</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/semantic-ui/2.2.4/semantic.min.css">
  <link rel="stylesheet" href="../staticfile/css/me.css">
  <!-- 在JSP页面中加入head标签
            负责在页面上导入Dojo所需要的CSS库和JavaScript库 -->
</head>
<body>

  <!--导航-->
 <c:import url="nav.jsp"></c:import>

  <!--中间内容-->
  <div  class="m-container m-padded-tb-big">
    <div class="ui container">

      <div class="ui stackable grid">
        <div class="eleven wide column">
          <div class="ui segment">
            <img src="https://picsum.photos/id/124//800/600" alt="" class="ui rounded image">
          </div>
        </div>
        <div class="five wide column">
          <div class="ui top attached segment">
            <div class="ui header">关于我</div>
          </div>
          <div class="ui attached segment">
            <p class="m-text">RAYMOND</p>
            <p class="m-text">热爱编程，喜欢折腾，正在探索高效学习编程技术的方法...</p>
          </div>
          <div class="ui attached segment">
            <div class="ui orange basic left pointing label">编程</div>
            <div class="ui orange basic left pointing label">写作</div>
            <div class="ui orange basic left pointing label">思考</div>
            <div class="ui orange basic left pointing label">运动</div>
          </div>
          <div class="ui attached segment">
            <div class="ui teal basic left pointing label m-margin-tb-tiny">Java</div>
            <div class="ui teal basic left pointing label m-margin-tb-tiny">JavaScript</div>
            <div class="ui teal basic left pointing label m-margin-tb-tiny">J2EE</div>
            <div class="ui teal basic left pointing label m-margin-tb-tiny">算法</div>
            <div class="ui teal basic left pointing label m-margin-tb-tiny">后端</div>
            <div class="ui teal basic left pointing label m-margin-tb-tiny">MYSQL</div>
            <div class="ui teal basic left pointing label m-margin-tb-tiny">...</div>
          </div>
          <div class="ui bottom attached segment">
            <a href="https://github.com/isLizx"  target="_blank" class="ui circular icon button"><i class="github icon"></i></a>
            <a href="#" class="ui wechat circular icon button"><i class="weixin icon"></i></a>
            <a href="#" class="ui qq circular icon button" data-content="3022823354" data-position="bottom center"><i class="qq icon"></i></a>
          </div>

          <div class="ui wechat-qr flowing popup transition hidden">
            <img src="../staticfile/images/wechat.jpg" alt="" class="ui rounded image" style="width: 110px">
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
		$("#menu5").addClass("active");
	});
    $('.menu.toggle').click(function () {
      $('.m-item').toggleClass('m-mobile-hide');
    });

    $('.wechat').popup({
      popup : $('.wechat-qr'),
      position: 'bottom center'
    });
    $('.qq').popup();

  </script>
</body>
</html>