package cn.edu.hzvtc.web.admin;

import java.io.IOException;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.interceptor.SessionAware;

import cn.edu.hzvtc.bean.User;
import cn.edu.hzvtc.service.UserService;
import cn.edu.hzvtc.util.VerifyCodeUtil;

import com.opensymphony.xwork2.ActionSupport;

public class LoginController extends ActionSupport implements ServletResponseAware,SessionAware{
	private UserService userService;
	private HttpServletResponse response;
	private Map<String, Object> session;
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	// 属性封装
	private String username;
	private String password;
	private String verifyCode;
	
	public String getVerifyCode() {
		return verifyCode;
	}

	public String getMsg() {
		return msg;
	}

	public void setVerifyCode(String verifyCode) {
		this.verifyCode = verifyCode;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	private String msg;
	
	public void setMsg(String msg) {
		this.msg = msg;
	}

	// 登陆
	public String login() {
		if(verifyCode.equals("")){
			msg = "验证码不能为空!";
			return "login";
		}
		if(!verifyCode.equals(session.get("verifyCode"))){
			msg = "验证码错误!";
			return "login";
		}
		User user = userService.getCheckUser(username, password);
		if (user != null) {
			user.setPassword(null);
			this.session.put("user", user);
			return "loginsuccess";
		} else {
			// 失败
			msg = "用户名或密码错误!";
			return "login";
		}
	}
	
	// 用户退出
	public String logout(){
		this.session.remove("user");
		return "logoutsuccess";
	}
	
	// 验证码刷新
	public String verifyCode(){
		response.setContentType("image/jpeg");
		//设置页面不缓存
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		
		VerifyCodeUtil vcUtil = VerifyCodeUtil.Instance();
		//将随机码设置在session中
		session.put("verifyCode", vcUtil.getResult()+"");
		try {
			ImageIO.write(vcUtil.getImage(), "jpeg", response.getOutputStream());
			
			response.getOutputStream().flush();
			response.getOutputStream().close();
			response.flushBuffer();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return NONE;
	}

	@Override
	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;
	}

	@Override
	public void setSession(Map<String, Object> arg0) {
		this.session = arg0;
	}
	
}
