<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="/struts-dojo-tags" prefix="sx"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>博客详情</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/semantic-ui/2.2.4/semantic.min.css">
<link rel="stylesheet" href="../staticfile/css/typo.css">
<link rel="stylesheet" href="../staticfile/css/animate.css">
<link rel="stylesheet" href="../staticfile/lib/prism/prism.css">
<link rel="stylesheet" href="../staticfile/lib/tocbot/tocbot.css">
<link rel="stylesheet" href="../staticfile/css/me.css">
<!-- 在JSP页面中加入head标签
            负责在页面上导入Dojo所需要的CSS库和JavaScript库 -->
<sx:head />
</head>
<body>

	<!--导航-->
	<c:import url="nav.jsp"></c:import>

	<!--中间内容-->
	<div id="waypoint"
		class="m-container-small m-padded-tb-big animated fadeIn">
		<div class="ui container">
			<div class="ui top attached segment">
				<div class="ui horizontal link list">
					<div class="item">
						<img src="${blog.user.avatar}" alt="" class="ui avatar image">
						<div class="content">
							<a href="#" class="header">${blog.user.nickname}</a>
						</div>
					</div>
					<div class="item">
						<i class="calendar icon"></i> <span><fmt:formatDate
								value="${blog.updateTime}" pattern="yyyy-MM-dd" /></span>
					</div>
					<div class="item">
						<i class="eye icon"></i> <span>${blog.views}</span>
					</div>
				</div>
			</div>
			<div class="ui attached segment">
				<!--图片区域-->
				<img src="${blog.firstPicture}" alt=""
					class="ui fluid rounded image">
			</div>
			<div class="ui  attached padded segment">
				<!--内容-->
				<div class="ui right aligned basic segment">
					<div class="ui orange basic label">${blog.flag}</div>
				</div>

				<h2 class="ui center aligned header">${blog.title}</h2>
				<br>
				<!--中间主要内容部分-->
				<div id="content"
					class="typo  typo-selection js-toc-content m-padded-lr-responsive m-padded-tb-large">
					${blog.content}</div>

				<!--标签-->
				<div class="m-padded-lr-responsive">
					<c:forEach items="${blog.tags }" var="tag">
						<div class="ui basic teal left pointing label">${tag.name}</div>
					</c:forEach>
				</div>

				<!--赞赏-->
				<div class="ui center aligned basic segment">
					<button id="payButton" class="ui orange basic circular button">赞赏</button>
				</div>
				<div class="ui payQR flowing popup transition hidden">
					<div class="ui orange basic label">
						<div class="ui images" style="font-size: inherit !important;">
							<div class="image">
								<img src="../staticfile/images/wechat.jpg" alt=""
									class="ui rounded bordered image" style="width: 120px">
								<div>支付宝</div>
							</div>
							<div class="image">
								<img src="../staticfile/images/wechat.jpg" alt=""
									class="ui rounded bordered image" style="width: 120px">
								<div>微信</div>
							</div>
						</div>
					</div>
				</div>

			</div>
			<div class="ui attached positive message">
				<!--博客信息-->
				<div class="ui middle aligned grid">
					<div class="eleven wide column">
						<ui class="list">
						<li>作者：<span>${blog.user.nickname}</span><a href="#"
							th:href="@{/about}" target="_blank">（联系作者）</a></li>
						<li>发表时间：<span><fmt:formatDate
									value="${blog.updateTime}" pattern="yyyy-MM-dd HH:mm" /></span></li>
						<li>版权声明：自由转载-非商用-非衍生-保持署名（创意共享3.0许可证）</li>
						<li>公众号转载：请在文末添加作者二维码</li>
						</ui>
					</div>
					<div class="five wide column">
						<img src="../staticfile/images/wechat.jpg" alt=""
							class="ui right floated rounded bordered image"
							style="width: 110px">
					</div>
				</div>
			</div>
			<c:if test="${blog.commentabled }">
				<div class="ui bottom attached segment">
					<!--留言区域列表-->

			<sx:div>
					<div class="ui teal segment" id="comment-container">
						<div class="ui threaded comments">
							<h3 class="ui dividing header">Comments</h3>
							<c:forEach items="${comments }" var="comment">
								<div class="comment">
									<a class="avatar"> <img src="${comment.avatar}">
									</a>
									<div class="content">
										<a class="author"> <span>${comment.nickname}</span> <c:if
												test="${comment.adminComment}">
												<div
													class="ui mini basic teal left pointing label m-padded-mini">博主</div>
											</c:if>
										</a>
										<div class="metadata">
											<span class="date"> <fmt:formatDate
													value="${comment.createTime}" pattern="yyyy-MM-dd HH:mm" />
											</span>
										</div>
										<div class="text">${comment.content}</div>
										<div class="actions">
											<a class="reply" data-commentid="${comment.id}"
												data-commentnickname="${comment.nickname}"
												onclick="reply(this)">回复</a>
										</div>
									</div>
									<c:if test="${fn:length(comment.replyComments)>0}">
										<div class="comments">
											<c:forEach items="${comment.replyComments}" var="reply">
												<div class="comment">
													<a class="avatar"> <img src="${reply.avatar}">
													</a>
													<div class="content">
														<a class="author"> <span>${reply.nickname}</span> <c:if
																test="${reply.adminComment}">
																<div
																	class="ui mini basic teal left pointing label m-padded-mini">博主</div>
															</c:if> &nbsp;<span class="m-teal">@
																${reply.parentComment.nickname}</span>
														</a>
														<div class="metadata">
															<span class="date"> <fmt:formatDate
																	value="${reply.createTime}" pattern="yyyy-MM-dd HH:mm" />
															</span>
														</div>
														<div class="text">${reply.content}</div>
														<div class="actions">
															<a class="reply" data-commentid="${reply.id}"
																data-commentnickname="${reply.nickname}"
																onclick="reply(this)">回复</a>
														</div>
													</div>
												</div>
											</c:forEach>
										</div>
									</c:if>
								</div>
							</c:forEach>
						</div>
					</div>
			        <c:if test="${msg ne null}">
		           	  <div class="ui mini negative message" >${msg }</div>
		            </c:if>   
			</sx:div>
					<div id="comment-form" class="ui form">
						<input type="hidden" name="blog.id" value="${blog.id}"> <input
							type="hidden" name="parentComment.id" value="-1">
						<div class="field">
							<textarea name="content" placeholder="请输入评论信息..."  maxlength="50"></textarea>
						</div>
						<div class="fields">
							<div class="field m-mobile-wide m-margin-bottom-small">
								<div class="ui left icon input">
									<i class="user icon"></i> <input type="text" name="nickname"
										placeholder="姓名" value="${user!=null ? user.nickname:''}" maxlength="10">
								</div>
							</div>
							<div class="field m-mobile-wide m-margin-bottom-small">
								<div class="ui left icon input">
									<i class="mail icon"></i> <input type="text" name="email"
										placeholder="邮箱" value="${user!=null ? user.email:''}">
								</div>
							</div>
							<div class="field  m-margin-bottom-small m-mobile-wide">
								<button id="commentpost-btn" type="button"
									class="ui teal button m-mobile-wide">
									<i class="edit icon"></i>发布
								</button>
							</div>
						</div>
						<div class="ui error mini message"></div>
					</div>

				</div>
</c:if>
		</div>
	</div>
	<!-- 模态框 -->
	<div class="ui modal">
	  <div class="header">
	    验证通过发送评论
	  </div>
	  <div class="image content">
	    <div id="rotateWrap1" style="margin:auto;">
	    	<div class="rotateverify-contaniner">
				<div class="rotate-can-wrap">
					<canvas class="rotateCan rotate-can" width="200" height="200"></canvas>
					<div class="statusBg status-bg"></div>
				</div>
				<div class="control-wrap slideDragWrap">
					<div class="control-tips">
						<p class="c-tips-txt cTipsTxt">滑动将图片转正</p>
					</div>
					<div class="control-bor-wrap controlBorWrap"></div>
					<div class="control-btn slideDragBtn">
						<i class="control-btn-ico"></i>
					</div>
				</div>
			</div>
	    </div>
	  </div>
	  <div class="actions">
	    <div class="ui black deny button">取消</div>
	  </div>
	</div>

	<div id="toolbar" class="m-padded m-fixed m-right-bottom"
		style="display: none">
		<div class="ui vertical icon buttons ">
			<button type="button" class="ui toc teal button">目录</button>
			<a href="#comment-container" class="ui teal button">留言</a>
			<button class="ui weibo icon button">
				<i class="weibo icon"></i>
			</button>
			<div id="toTop-button" class="ui icon button">
				<i class="chevron up icon"></i>
			</div>
		</div>
	</div>

	<div class="ui toc-container flowing popup transition hidden"
		style="width: 250px!important;">
		<ol class="js-toc">

		</ol>
	</div>

	<div id="qrcode" class="ui weibo-qr flowing popup transition hidden "
		style="width: 130px !important;">
	</div>

	<br>
	<br>
	<!--底部footer-->
	<c:import url="footer.jsp"></c:import>

	<script
		src="https://cdn.jsdelivr.net/npm/jquery@3.2/dist/jquery.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/semantic-ui/2.2.4/semantic.min.js"></script>
	<script
		src="//cdn.jsdelivr.net/npm/jquery.scrollto@2.1.2/jquery.scrollTo.min.js"></script>

	<script src="../staticfile/lib/prism/prism.js"></script>
	<script src="../staticfile/lib/tocbot/tocbot.min.js"></script>
	<script src="../staticfile/lib/qrcode/qrcode.min.js"></script>
	<script src="../staticfile/lib/waypoints/jquery.waypoints.min.js"></script>
	<script src="../staticfile/js/yz.js"></script>




	<script type="text/javascript">
		$(document).ready(function() {
			$("#menu1").addClass("active");
		});
		$('.menu.toggle').click(function() {
			$('.m-item').toggleClass('m-mobile-hide');
		});

		$('#payButton').popup({
			popup : $('.payQR.popup'),
			on : 'click',
			position : 'bottom center'
		});

		tocbot.init({
			// Where to render the table of contents.
			tocSelector : '.js-toc',
			// Where to grab the headings to build the table of contents.
			contentSelector : '.js-toc-content',
			// Which headings to grab inside of the contentSelector element.
			headingSelector : 'h1, h2, h3',
		});

		$('.toc.button').popup({
			popup : $('.toc-container.popup'),
			on : 'click',
			position : 'left center'
		});

		$('.weibo').popup({
			popup : $('.weibo-qr'),
			position : 'left center'
		});

		var serurl = "weibo.com/p/1005055403112140";
		var url = /*[[@{/blog/{id}(id=${blog.id})}]]*/"";
		var qrcode = new QRCode("qrcode", {
			text : serurl + url,
			width : 110,
			height : 110,
			colorDark : "#000000",
			colorLight : "#ffffff",
			correctLevel : QRCode.CorrectLevel.H
		});

		$('#toTop-button').click(function() {
			$(window).scrollTo(0, 500);
		});

		var waypoint = new Waypoint({
			element : document.getElementById('waypoint'),
			handler : function(direction) {
				if (direction == 'down') {
					$('#toolbar').show(100);
				} else {
					$('#toolbar').hide(500);
				}
				console.log('Scrolled to waypoint!  ' + direction);
			}
		})
		//评论表单验证
		$('.ui.form').form({
			fields : {
				title : {
					identifier : 'content',
					rules : [ {
						type : 'empty',
						prompt : '请输入评论内容'
					} ]
				},
				content : {
					identifier : 'nickname',
					rules : [ {
						type : 'empty',
						prompt : '请输入你的大名'
					} ]
				},
				type : {
					identifier : 'email',
					rules : [ {
						type : 'email',
						prompt : '请填写正确的邮箱地址'
					} ]
				},
				verifyCode : {
					identifier : 'verifyCode',
					rules : [ {
						type : 'empty',
						prompt : '请填写验证码'
					} ]
				}
			}
		});

		$('#commentpost-btn').click(function() {
			var boo = $('.ui.form').form('validate form');
			if (boo) {
				console.log('校验成功');
				$('.ui.modal').modal('show');
				new RotateVerify('#rotateWrap1', {
					initText: '滑动将图片转正',//默认
					slideImage: ['../staticfile/images/1.png', '../staticfile/images/2.png', '../staticfile/images/4.png', '../staticfile/images/5.png'],//arr  [imgsrc1,imgsrc2] 或者str 'imgsrc1'
					slideAreaNum: 10,// 误差范围角度 +- 10(默认)
					getSuccessState: function (res) {//验证通过 返回  true;
						console.log($("[name='blog.id']").val());
						$('.ui.modal').modal('hide');
						postData();
					}
				});
				
			} else {
				console.log('校验失败');
			}

		});

		function postData() {
			$("#comment-container").load("comment_save", {
				"comment.parentComment.id" : $("[name='parentComment.id']").val(),
				"comment.blog.id" : $("[name='blog.id']").val(),
				"comment.nickname" : $("[name='nickname']").val(),
				"comment.email" : $("[name='email']").val(),
				"comment.content" : $("[name='content']").val(),
			}, function(responseTxt, statusTxt, xhr) {
				clearContent();
			});
		}

		function clearContent() {
			$("[name='content']").val('');
			$("[name='parentComment.id']").val(-1);
			$("[name='content']").attr("placeholder", "请输入评论信息...");
		}

		function reply(obj) {
			var commentId = $(obj).data('commentid');
			var commentNickname = $(obj).data('commentnickname');
			$("[name='content']").attr("placeholder", "@" + commentNickname)
					.focus();
			$("[name='parentComment.id']").val(commentId);
			$(window).scrollTo($('#comment-form'), 500);
		}
	</script>
</body>
</html>