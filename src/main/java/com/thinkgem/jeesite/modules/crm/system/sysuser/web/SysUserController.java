package com.thinkgem.jeesite.modules.crm.system.sysuser.web;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomBooleanEditor;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.crm.system.sysuser.entity.SysUser;
import com.thinkgem.jeesite.modules.crm.system.sysuser.service.SysUserService;

@Controller
@RequestMapping(value = "${adminPath}/sysmgr/user")
public class SysUserController extends BaseController {

	@Autowired
	private SysUserService userService;
	@InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Boolean.class, "enabled", new CustomBooleanEditor("Y", "N", true));
        DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(fmt, true));
    }

	@RequestMapping(value="list",method=RequestMethod.GET)     //get常用于取回数据，post用于提交数据
	public String list(Model model,
			@RequestParam(value = "page", defaultValue = "1") int page){
		PageBounds pageBounds = new PageBounds(page, 6,Order.formString("id.asc"));
		List<SysUser> userList = userService.getUserList(pageBounds);
		model.addAttribute("userList", userList);
		return "modules/user/list";
	}
	
	@RequestMapping(value="query",method=RequestMethod.POST)   //get常用于取回数据，post用于提交数据
	public String query(@RequestParam(value = "page", defaultValue = "1") int page,Model model){
		PageBounds pageBounds = new PageBounds(page, 6,Order.formString("id.asc"));
		model.addAttribute("userList", userService.getUserList(pageBounds));
		return "modules/user/list";
	}
	
	@RequestMapping(value="insert",method = RequestMethod.GET)
	public String insert(Model model){
		SysUser sysUser=new SysUser();
		model.addAttribute("sysUser",sysUser);
		return "modules/user/insert";
	}
	
	@RequestMapping(value="insert",method = RequestMethod.POST)
	public String insert(){
		 return "redirect:/sysmgr/user/insert";
	}
}
