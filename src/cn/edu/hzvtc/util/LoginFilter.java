package cn.edu.hzvtc.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginFilter implements Filter {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,
			FilterChain chain) throws IOException, ServletException {
		System.out.println("--------loginfilter--------");
		HttpServletRequest request = (HttpServletRequest)servletRequest;
		HttpServletResponse response = (HttpServletResponse)servletResponse;
		String currentURL = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String targetURL = currentURL.substring(ctxPath.length());
		if (request.getSession().getAttribute("user") == null && !(targetURL.contains("login.jsp"))) {
			request.setAttribute("msg", "请先进行登录操作!");
			request.getRequestDispatcher("login.jsp").forward(request,
					response);
			return;
		}
		chain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub

	}

}
