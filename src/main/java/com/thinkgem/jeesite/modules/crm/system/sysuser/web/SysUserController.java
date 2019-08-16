package com.thinkgem.jeesite.modules.crm.system.sysuser.web;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.xmlbeans.impl.xb.xsdschema.Public;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomBooleanEditor;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.thinkgem.jeesite.common.utils.AlertInfo;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.crm.system.flex.service.FlexService;
import com.thinkgem.jeesite.modules.crm.system.role.entity.Role;
import com.thinkgem.jeesite.modules.crm.system.sysuser.entity.SysUser;
import com.thinkgem.jeesite.modules.crm.system.sysuser.service.SysUserService;

import javax.jws.WebParam;

@Controller
@RequestMapping(value = "${adminPath}/sysmgr/user")
public class SysUserController extends BaseController {

	@Autowired
	private SysUserService sysUserService;
	
	@Autowired
	private FlexService flexService;
	
	@SuppressWarnings("serial")
	private Map<String, String> userStatus = new LinkedHashMap<String, String>() {{
        put("Y", "是");
        put("N", "否");
    }};
	
	@InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Boolean.class, "enabled", new CustomBooleanEditor("Y", "N", true));
        DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(fmt, true));
    }

	@RequestMapping(value="list",method=RequestMethod.GET)     //get常用于取回数11111据，post用于提交数据
	public String list(Model model,
			@RequestParam(value = "page", defaultValue = "1") int page){
		PageBounds pageBounds = new PageBounds(page, 6,Order.formString("id.asc"));
		List<SysUser> userList = sysUserService.getUserList(pageBounds);
		model.addAttribute("userList", userList);
		return "modules/user/list";
	}
	
	@RequestMapping(value="query",method=RequestMethod.POST)   //get常用于取回数据，post用于提交数据
	public String query(@RequestParam(value = "page", defaultValue = "1") int page,Model model){
		PageBounds pageBounds = new PageBounds(page, 6,Order.formString("id.asc"));
		model.addAttribute("userList", sysUserService.getUserList(pageBounds));
		return "modules/user/list";
	}
	
	@RequestMapping(value="insert",method = RequestMethod.GET)
	public String insert(Model model){
		SysUser sysUser=new SysUser();
		model.addAttribute("userStatus",userStatus);
		model.addAttribute("USER_TYPE",flexService.getOptionsBySetCode("USER_TYPE",true));
		Role role=new Role();
		role.setId(1);
		role.setCode("01");
		role.setName("系统管理员");
		Role role1=new Role();
		role1.setId(2);
		role1.setCode("02");
		role1.setName("工商管理员");
		Role role2=new Role();
		role2.setId(3);
		role2.setCode("03");
		role2.setName("普通用户");
		
		List<Role> list=new ArrayList<Role>();
		list.add(role);
		list.add(role1);
		list.add(role2);
		model.addAttribute("roleList",list);
		model.addAttribute("sysUser",sysUser);
		return "modules/user/insert";
	}
	
	@RequestMapping(value="insert",method = RequestMethod.POST)
	public String insert(@ModelAttribute("sysUser") SysUser sysUser,
            RedirectAttributes redirectAttributes){
		 sysUserService.insert(sysUser);
		 AlertInfo alertInfo = new AlertInfo(AlertInfo.Type.success, "保存成功..");
		 redirectAttributes.addFlashAttribute("alertInfo", alertInfo);
		 return "redirect:" + adminPath + "/sysmgr/user/insert";
	}
	
	@RequestMapping(value="modify/{sysUserId}",method=RequestMethod.GET)
    public String modify(@PathVariable("sysUserId") String sysUserId,Model model){
	    SysUser sysUser=new SysUser();
	    sysUser.setLoginName("admin");
	    sysUser.setDisplayName("admin");
	    model.addAttribute("sysUser",sysUser);
	    return  "modules/user/modify";
    }

    @RequestMapping(value = "modify",method = RequestMethod.POST)
    public String modify(Model model,RedirectAttributes redirectAttributes){
	    AlertInfo alertInfo=new AlertInfo(AlertInfo.Type.success,"保存成功..");
	    redirectAttributes.addFlashAttribute("alertinfo",alertInfo);
	    return "redirect:"+adminPath+"/sysmgr/user/list";
    }

	 @RequestMapping(value="checkLoginName",produces = "application/json")
	 public @ResponseBody  String checkLoginName(@RequestParam("loginName") String loginName){
		boolean result = true;
		if(sysUserService.findUserByLoginName(loginName)==null){
			result = true;
		}else{
			result = false;
		}
		Map<String, Boolean> map = new HashMap<String, Boolean>();
        map.put("valid", result);  //BootStrap检验只接受{'valid'.true/false}格式
        ObjectMapper mapper = new ObjectMapper();
        String resultString = "";
        try {
            resultString = mapper.writeValueAsString(map);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        } catch (IOException e) {
			e.printStackTrace();
		}
        return resultString;
	}
}
