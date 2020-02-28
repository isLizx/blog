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
  <title>博客管理</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/semantic-ui/2.2.4/semantic.min.css">
  <link rel="stylesheet" href="../../staticfile/css/me.css">
</head>
<body>

  <!--导航-->
  <c:import url="nav.jsp"></c:import>


  <!--中间内容-->
  <div  class="m-container-small m-padded-tb-big">
    <div class="ui container">
      <div class="ui success large  message">
        <h3>Hi,</h3>
        <p>${user.username }，欢迎登录！</p>
      </div>

      <img src="https://picsum.photos/id/1002/1000/300" alt="" class="ui rounded bordered fluid image">
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
    $('.menu.toggle').click(function () {
      $('.m-item').toggleClass('m-mobile-hide');
    });

    $('.ui.dropdown').dropdown({
      on : 'hover'
    });

  </script>
</body>
</html>