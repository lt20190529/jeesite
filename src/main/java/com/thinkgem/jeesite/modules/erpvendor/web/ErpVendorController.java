/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erpvendor.web;

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
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.erpvendor.entity.ErpVendor;
import com.thinkgem.jeesite.modules.erpvendor.service.ErpVendorService;

/**
 * 供应商维护Controller
 * @author lt
 * @version 2018-09-20
 */
@Controller
@RequestMapping(value = "${adminPath}/erpvendor/erpVendor")
public class ErpVendorController extends BaseController {

	@Autowired
	private ErpVendorService erpVendorService;
	
	//@ModelAttribute解释
	//当同一个controller中有任意一个方法被@ModelAttribute注解标记，页面请求只要进入这个控制器，
	//不管请求那个方法，均会先执行被@ModelAttribute标记的方法，所以我们可以用@ModelAttribute注解的方法做一些初始化操作。
	//当同一个controller中有多个方法被@ModelAttribute注解标记，所有被@ModelAttribute标记的方法均会被执行，按先后顺序执行，
	//然后再进入请求的方法。

	@ModelAttribute
	public ErpVendor get(@RequestParam(required=false) String id) {
		ErpVendor entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = erpVendorService.get(id);
		}
		if (entity == null){
			entity = new ErpVendor();
		}
		return entity;
	}
	
	@RequiresPermissions("erpvendor:erpVendor:view")
	@RequestMapping(value = {"list", ""})
	public String list(ErpVendor erpVendor, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ErpVendor> page = erpVendorService.findPage(new Page<ErpVendor>(request, response), erpVendor); 
		model.addAttribute("page", page);
		return "modules/erpvendor/erpVendorList";
	}

	@RequiresPermissions("erpvendor:erpVendor:view")
	@RequestMapping(value = "form")
	public String form(ErpVendor erpVendor, Model model) {
		model.addAttribute("erpVendor", erpVendor);
		return "modules/erpvendor/erpVendorForm";
	}

	@RequiresPermissions("erpvendor:erpVendor:edit")
	@RequestMapping(value = "save")
	public String save(ErpVendor erpVendor, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, erpVendor)){
			return form(erpVendor, model);
		}
		erpVendorService.save(erpVendor);
		addMessage(redirectAttributes, "保存供应商维护成功");
		return "redirect:"+Global.getAdminPath()+"/erpvendor/erpVendor/?repage";
	}
	
	@RequiresPermissions("erpvendor:erpVendor:edit")
	@RequestMapping(value = "delete")
	public String delete(ErpVendor erpVendor, RedirectAttributes redirectAttributes) {
		erpVendorService.delete(erpVendor);
		addMessage(redirectAttributes, "删除供应商维护成功");
		return "redirect:"+Global.getAdminPath()+"/erpvendor/erpVendor/?repage";
	}

}