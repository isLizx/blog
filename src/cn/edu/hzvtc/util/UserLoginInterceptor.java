package cn.edu.hzvtc.util;



import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.StrutsStatics;

import cn.edu.hzvtc.bean.User;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;



public class UserLoginInterceptor extends MethodFilterInterceptor {

	@Override
	protected String doIntercept(ActionInvocation invocation) throws Exception {
		System.out.println("-----------UserLoginInterceptor-------------");
		ActionContext ctx = invocation.getInvocationContext();
		Map session = ctx.getSession();
		// 取出名为loginAdmin的session属性
		User loginUser = (User) session.get("user");
		if(loginUser != null){
			return invocation.invoke();
		}
		HttpServletRequest request=
                (HttpServletRequest) ctx.get(StrutsStatics.HTTP_REQUEST);
		request.setAttribute("msg", "请先进行登录操作!");
		return "toLoginPage";
	}

}
