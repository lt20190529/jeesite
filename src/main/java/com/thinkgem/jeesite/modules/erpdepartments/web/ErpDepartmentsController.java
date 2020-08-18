package com.thinkgem.jeesite.modules.erpdepartments.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.erpdepartments.entity.ErpDepartments;
import com.thinkgem.jeesite.modules.erpdepartments.service.ErpDepartmentsSerivce;
import com.thinkgem.jeesite.modules.erpvendor.entity.ErpVendor;
import com.thinkgem.jeesite.modules.erpvendor.service.ErpVendorService;
import com.thinkgem.jeesite.modules.item.entity.ErpItem;




/**
 * 部门维护Controller
 * @author 部门维护
 * @version 2018-09-26
 */

@Controller
@RequestMapping(value = "${adminPath}/erpdepartments/departments")
public class ErpDepartmentsController extends BaseController  {

	
	@Autowired
	private ErpDepartmentsSerivce erpDepartmentsSerivce;
	
	//@ModelAttribute解释
	//当同一个controller中有任意一个方法被@ModelAttribute注解标记，页面请求只要进入这个控制器，
	//不管请求那个方法，均会先执行被@ModelAttribute标记的方法，所以我们可以用@ModelAttribute注解的方法做一些初始化操作。
	//当同一个controller中有多个方法被@ModelAttribute注解标记，所有被@ModelAttribute标记的方法均会被执行，按先后顺序执行，
	//然后再进入请求的方法。
	
	@ModelAttribute
	public ErpDepartments get(@RequestParam(required=false) String id) {
		ErpDepartments erpDepartments = null;
		if (StringUtils.isNotBlank(id)){
			erpDepartments = erpDepartmentsSerivce.get(id);
		}
		if (erpDepartments == null){
			erpDepartments = new ErpDepartments();
		}
		return erpDepartments;
	}
	
	/*
	 * 部门列表
	 */


	@RequiresPermissions("erpdepartments:departments:view")
	@RequestMapping(value = {"list", ""})
	public String list(ErpDepartments erpDepartments,HttpServletRequest request,
			HttpServletResponse response,Model model) {
		Page<ErpDepartments> page = erpDepartmentsSerivce.findPage(new Page<ErpDepartments>(request, response), erpDepartments); 
		model.addAttribute("page", page);
        //response.setHeader("Access-Control-Allow-Origin", "https://www.runoob.com/try/ajax/json_demo.json");
        response.setHeader("Cache-Control","no-cache");
		return "modules/erpdepartments/erpdepartmentsList";
	}
	
	/*
	 * 部门维护
	 */
	@RequiresPermissions("erpdepartments:departments:view")
	@RequestMapping(value = {"form"})
	public String form(ErpDepartments erpDepartments,Model model) {
		return "modules/erpdepartments/erpdepartmentsForm";
	}
	
	
	@RequiresPermissions("erpdepartments:departments:edit")
	@RequestMapping(value = "save")
	public String save(ErpDepartments erpDepartments,Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, erpDepartments)){
			return form(erpDepartments, model);
		}
		erpDepartmentsSerivce.save(erpDepartments);
		addMessage(redirectAttributes, "保存部门成功");
		return "redirect:"+Global.getAdminPath()+"/erpdepartments/departments/?repage";
	}
	
	@RequiresPermissions("erpdepartments:departments:edit")
	@RequestMapping(value = "delete")
	public String delete(ErpDepartments erpDepartments, RedirectAttributes redirectAttributes) {
		erpDepartmentsSerivce.delete(erpDepartments);
		addMessage(redirectAttributes, "删除部门成功");
		return "redirect:"+Global.getAdminPath()+"/erpdepartments/departments/?repage";
	}
	
}
