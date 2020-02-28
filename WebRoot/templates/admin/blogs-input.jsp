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
  <title>博客发布</title>
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/semantic-ui/2.2.4/semantic.min.css">
  <!-- <link rel="stylesheet" href="../../staticfile/lib/editormd/css/editormd.min.css"> -->
  <link rel="stylesheet" href="../../staticfile/lib/editormd/css/editormd.css" />
  <link rel="stylesheet" href="../../staticfile/css/me.css">
</head>
<body>

  <!--导航-->
  <c:import url="nav.jsp"></c:import>
  <div class="ui attached pointing menu">
    <div class="ui container">
      <div class="right menu">
        <a href="#" class=" active item">${blog.id eq null ? '新增':'修改' }</a>
        <a href="${pageContext.request.contextPath }/templates/admin/blog_listpage" class="teal item">列表</a>
      </div>
    </div>
  </div>

  <!--中间内容-->
  <div  class="m-container m-padded-tb-big">
    <div class="ui container">
      <form id="blog-form" action="${pageContext.request.contextPath }/templates/admin/blog_saveOrUpdate.action" method="post" class="ui form">
        <input type="hidden" name="blog.published" value="${blog.published }">
        <input type="hidden" name="blog.id" value="${blog.id }">
        <input type="hidden" name="currentPage" value="${currentPage }" />
        <div class="required field">
          <div class="ui left labeled input">
            <div class="ui selection compact teal basic dropdown label">
              <input type="hidden" value="${blog.flag }" name="blog.flag" id="flag">
              <i class="dropdown icon"></i>
              <div class="text">选择类型</div>
              <div class="menu">
                <div class="item" data-value="原创">原创</div>
                <div class="item" data-value="转载">转载</div>
                <div class="item" data-value="翻译">翻译</div>
              </div>
            </div>
            <input type="text" name="blog.title" placeholder="标题" value="${blog.title }" id="title">
          </div>
        </div>

        <div class="required field">
          <div id="md-content" style="z-index: 1 !important;">
            <textarea placeholder="博客内容" name="blog.content" style="display: none" text="${blog.content }" id="content">${blog.content }</textarea>
          </div>
        </div>

        <div class="two fields">
          <div class="required field">
            <div class="ui left labeled action input">
              <label class="ui compact teal basic label">分类</label>
              <div class="ui fluid selection dropdown">
                <input type="hidden" name="blog.type.id" value="${blog.type.id }" id="typeid">
                <i class="dropdown icon"></i>
                <div class="default text">分类</div>
                <div class="menu">
                <c:forEach items="${listType }" var="type">
                  <div class="item" data-value="${type.id }">${type.name }</div>
                </c:forEach>
                </div>
              </div>
            </div>
          </div>
          <div class=" field">
            <div class="ui left labeled action input">
              <label class="ui compact teal basic label">标签</label>
              <div class="ui fluid selection multiple search  dropdown">
                <input type="hidden" name="blog.tagIds" value="${blog.tagIds }" >
                <i class="dropdown icon"></i>
                <div class="default text">标签</div>
                <div class="menu">
                <c:forEach items="${listTag }" var="tag">
                  <div class="item" data-value="${tag.id }">${tag.name }</div>
                </c:forEach>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="required field">
          <div class="ui left labeled input">
            <label class="ui teal basic label">首图</label>
            <input type="text" name="blog.firstPicture" placeholder="首图引用地址" value="${blog.firstPicture }" id="firstPicture">
          </div>
        </div>

        <div class="required field">
          <textarea placeholder="博客描述..." maxlength="200" name="blog.description">${blog.description }</textarea>
        </div>

        <div class="inline fields">
          <div class="field">
            <div class="ui checkbox">
              <input type="checkbox" id="recommend" name="blog.recommend" value="true" ${blog.recommend  ? 'checked':''} class="hidden">
              <label for="recommend">推荐</label>
            </div>
          </div>
          <div class="field">
            <div class="ui checkbox">
              <input type="checkbox" id="shareStatement" name="blog.shareStatement" value="true" ${blog.shareStatement ? 'checked':'' } class="hidden">
              <label for="shareStatement">转载声明</label>
            </div>
          </div>
          <div class="field">
            <div class="ui checkbox">
              <input type="checkbox" id="appreciation" name="blog.appreciation" value="true" ${blog.appreciation ? 'checked':'' } class="hidden">
              <label for="appreciation">赞赏</label>
            </div>
          </div>
          <div class="field">
            <div class="ui checkbox">
              <input type="checkbox" id="commentabled" name="blog.commentabled" value="true" ${blog.appreciation ? 'checked':''} class="hidden">
              <label for="commentabled">评论</label>
            </div>
          </div>
        </div>

        <div class="ui error message"></div>

        <div class="ui right aligned container">
        <s:token/>
          <button type="button" class="ui button" onclick="window.history.go(-1)" >返回</button>
          <button type="button" id="save-btn" class="ui secondary button">保存</button>
          <button type="button" id="publish-btn" class="ui teal button">发布</button>
        </div>
      </form>
    </div>
  </div>

  <br>
  <br>
  <!--底部footer-->
  <c:import url="footer.jsp"></c:import>

  <!--/*/<th:block th:replace="admin/_fragments :: script">/*/-->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.2/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/semantic-ui/2.2.4/semantic.min.js"></script>
<%--   <script src="https://cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script> --%>
<script src="../../staticfile/lib/editormd/editormd.min.js"></script>
  <!--/*/</th:block>/*/-->


  <script>
  $(document).ready(function() {
		$("#menu1").addClass("active");
	});
    //初始化Markdown编辑器
    var contentEditor;
    $(function() {
      contentEditor = editormd("md-content", {
        width   : "100%",
        height  : 640,
        syncScrolling : "single",
		path: "../../staticfile/lib/editormd/lib/"
      });
    });
    $('.menu.toggle').click(function () {
      $('.m-item').toggleClass('m-mobile-hide');
    });

    $('.ui.dropdown').dropdown({
      on : 'hover'
    });

    $('#save-btn').click(function () {
      $('[name="blog.published"]').val(false);
      $('#blog-form').submit();
    });


    $('#publish-btn').click(function () {
      $('[name="blog.published"]').val(true);
      $('#blog-form').submit();
    });



    $('.ui.form').form({
      fields : {
        flag : {
           identifier: 'flag',
           rules: [{
             type : 'empty',
             prompt: '请选择文章为原创，转载，翻译类型'
           }]
         },
        title : {
          identifier: 'title',
          rules: [{
            type : 'empty',
            prompt: '标题：请输入文章标题'
          }]
        },
        content : {
          identifier: 'content',
          rules: [{
            type : 'empty',
            prompt: '标题：请输入文章内容'
          }]
        },
        typeId : {
          identifier: 'typeid',
          rules: [{
            type : 'empty',
            prompt: '标题：请输入文章分类'
          }]
        },
        firstPicture : {
          identifier: 'firstPicture',
          rules: [{
            type : 'empty',
            prompt: '标题：请输入文章首图'
          }]
        }
      }
    });

  </script>
</body>
</html>