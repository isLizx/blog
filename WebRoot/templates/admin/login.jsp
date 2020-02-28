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
  <title>博客管理登录</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/semantic-ui/2.2.4/semantic.min.css">
  <link rel="stylesheet" href="../../staticfile/css/me.css">
</head>
<body>

<br>
<br>
<br>
 <div class="m-container-small m-padded-tb-massive" style="max-width: 30em !important;">
   <div class="ur container">
     <div class="ui middle aligned center aligned grid">
       <div class="column">
         <h2 class="ui teal image header">
           <div class="content">
             管理后台登录
           </div>
         </h2>
         <form class="ui large form" method="post" action="${pageContext.request.contextPath }/templates/admin/user_login.action">
           <div class="ui  segment">
             <div class="field">
               <div class="ui left icon input">
                 <i class="user icon"></i>
                 <input type="text" name="username" placeholder="用户名" value="${username }">
               </div>
             </div>
             <div class="field">
               <div class="ui left icon input">
                 <i class="lock icon"></i>
                 <input type="password" name="password" placeholder="密码" value="${password }">
               </div>
             </div>
             <div class="field">
               <div class="ui left icon input">
                 <i class="write icon"></i>
                 <input type="number" name="verifyCode" placeholder="验证码">
                 &nbsp;
                 <img src="user_verifyCode" class="img-rounded" alt="点击获取验证码" title="点击刷新" onclick="this.src='user_verifyCode?code='+Date.parse(new Date())"/>
               </div>
             </div>
             <button class="ui fluid large teal submit button">登   录</button>
           </div>
		   <!-- <img src="VerifyCodeServlet" class="img-rounded" alt="点击获取验证码" title="点击刷新" onclick="this.src='VerifyCodeServlet?code='+Date.parse(new Date())"/> -->
           <div class="ui error mini message"></div>
           <c:if test="${msg ne null}">
           	<div class="ui mini negative message" >${msg }</div>
           </c:if>
         </form>

       </div>
     </div>
   </div>
 </div>

<!--/*/<th:block th:replace="_fragments :: script">/*/-->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.2/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/semantic-ui/2.2.4/semantic.min.js"></script>
<!--/*/</th:block>/*/-->

<script>
  $('.ui.form').form({
    fields : {
      username : {
        identifier: 'username',
        rules: [{
          type : 'empty',
          prompt: '请输入用户名'
        }]
      },
      password : {
        identifier: 'password',
        rules: [{
          type : 'empty',
          prompt: '请输入密码'
        }]
      },
      verifyCode : {
          identifier: 'verifyCode',
          rules: [{
            type : 'empty',
            prompt: '请输入验证码'
          }]
        }
    }
  });
</script>

</body>
</html>