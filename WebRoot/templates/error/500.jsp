<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>博客</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/semantic-ui/2.2.4/semantic.min.css" >
  <link rel="stylesheet" href="../../staticfile/css/me.css" >
  <link rel="stylesheet" href="../staticfile/css/me.css" >
</head>
<body>

<!--导航-->
<c:import url="../nav.jsp"></c:import>

<br>
<br>
<br>

  <div class="m-container-small m-padded-tb-massive">
    <div class="ui error message m-padded-tb-huge" >
      <div class="ui contianer">
        <h2>500</h2>
        <p>对不起，服务异常，请联系管理员</p>
        <button type="button" class="ui button" onclick="window.history.go(-1)" >返回</button>
      </div>
    </div>
  </div>
<br>
<br>
<br>
<br>


<c:import url="../footer.jsp"></c:import>
</body>
</html>