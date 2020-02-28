<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>分类新增</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/semantic-ui/2.2.4/semantic.min.css">
  <link rel="stylesheet" href="../../staticfile/lib/editormd/css/editormd.min.css">
  <link rel="stylesheet" href="../../staticfile/css/me.css">
</head>
<body>

  <!--导航-->
  <c:import url="nav.jsp"></c:import>
  <div class="ui attached pointing menu">
    <div class="ui container">
      <div class="right menu">
         <a href="#" class="teal active item">${type.id eq null ? '新增':'修改' }</a>
        <a href="${pageContext.request.contextPath }/templates/admin/type_listpage.action" class="teal  item">列表</a>
      </div>
    </div>
  </div>

  <!--中间内容-->
  <div  class="m-container-small m-padded-tb-big">
    <div class="ui container">
      <form action="${pageContext.request.contextPath }/templates/admin/type_saveOrUpdate.action" method="post" class="ui form">
      	<input type="hidden" value="${currentPage }" name="currentPage"/>
        <input type="hidden" name="type.id" value="${type.id }">
        <div class=" field">
          <div class="ui left labeled input">
            <label class="ui teal basic label">名称</label>
            <input type="text" name="type.name" placeholder="分类名称" value="${type.name }">
          </div>
        </div>

        	<div class="ui error message">${sessionScope.msg }</div>
        <c:if test="${sessionScope.msg ne null && sessionScope.msg ne ''}">
	        <div class="ui negative message">
	          <i class="close icon"></i>
	          <div class="header">验证失败</div>
	          <p>${sessionScope.msg }</p>
	        </div>
        </c:if>
        <c:remove var="msg" scope="session" />
        <div class="ui right aligned container">
          <button type="button" class="ui button" onclick="window.history.go(-1)" >返回</button>
          <s:token/>
          <button class="ui teal submit button" type="submit">提交</button>
        </div>

      </form>
    </div>
  </div>

  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
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
		$("#menu2").addClass("active");
	});
    $('.menu.toggle').click(function () {
      $('.m-item').toggleClass('m-mobile-hide');
    });

    $('.ui.dropdown').dropdown({
      on : 'hover'
    });

    $('.ui.form').form({
      fields : {
        title : {
          identifier: 'name',
          rules: [{
            type : 'empty',
            prompt: '请输入分类名称'
          }]
        }
      }
    });

  </script>
</body>
</html>