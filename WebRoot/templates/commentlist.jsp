<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/struts-dojo-tags" prefix="sx"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

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