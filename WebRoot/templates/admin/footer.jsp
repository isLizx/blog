<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!--底部footer-->
  <footer class="ui inverted vertical segment m-padded-tb-massive">
    <div class="ui center aligned container">
      <div class="ui inverted divided stackable grid">
        <div class="three wide column">
          <div class="ui inverted link list">
            <div class="item">
              <img src="../../staticfile/images/wechat.png" class="ui rounded image" alt="" style="width: 110px">
            </div>
          </div>
        </div>
        <div class="three wide column">
          <h4 class="ui inverted header m-text-thin m-text-spaced " >最新博客</h4>
          <div class="ui inverted link list">
            <a href="#" class="item m-text-thin">用户故事（User Story）</a>
            <a href="#" class="item m-text-thin">用户故事（User Story）</a>
            <a href="#" class="item m-text-thin">用户故事（User Story）</a>
          </div>
        </div>
        <div class="three wide column">
          <h4 class="ui inverted header m-text-thin m-text-spaced ">联系我</h4>
          <div class="ui inverted link list">
            <a href="#" class="item m-text-thin">Email：isLizx@163.com</a>
            <a href="#" class="item m-text-thin">QQ：3022823354</a>
          </div>
        </div>
        <div class="seven wide column">
          <h4 class="ui inverted header m-text-thin m-text-spaced ">Blog</h4>
          <p class="m-text-thin m-text-spaced m-opacity-mini">这是我的个人博客、会分享关于编程、写作、思考相关的任何内容，希望可以给来到这儿的人有所帮助...</p>
        </div>
      </div>
      <div class="ui inverted section divider"></div>
      <p class="m-text-thin m-text-spaced m-opacity-tiny">Copyright © 2018 - 2019 Lizhixiang Designed by Lizhixiang</p>
    </div>

  </footer>