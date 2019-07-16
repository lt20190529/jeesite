/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erpmanf.web;

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
import com.thinkgem.jeesite.modules.erpmanf.entity.ErpManf;
import com.thinkgem.jeesite.modules.erpmanf.service.ErpManfService;

/**
 * 厂家维护Controller
 * @author lt
 * @version 2018-10-30
 */
@Controller
@RequestMapping(value = "${adminPath}/erpmanf/erpManf")
public class ErpManfController extends BaseController {

	@Autowired
	private ErpManfService erpManfService;
	
	@ModelAttribute
	public ErpManf get(@RequestParam(required=false) String id) {
		ErpManf entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = erpManfService.get(id);
		}
		if (entity == null){
			entity = new ErpManf();
		}
		return entity;
	}
	
	@RequiresPermissions("erpmanf:erpManf:view")
	@RequestMapping(value = {"list", ""})
	public String list(ErpManf erpManf, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ErpManf> page = erpManfService.findPage(new Page<ErpManf>(request, response), erpManf); 
		model.addAttribute("page", page);
		return "modules/erpmanf/erpManfList";
	}

	@RequiresPermissions("erpmanf:erpManf:view")
	@RequestMapping(value = "form")
	public String form(ErpManf erpManf, Model model) {
		model.addAttribute("erpManf", erpManf);
		return "modules/erpmanf/erpManfForm";
	}

	@RequiresPermissions("erpmanf:erpManf:edit")
	@RequestMapping(value = "save")
	public String save(ErpManf erpManf, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, erpManf)){
			return form(erpManf, model);
		}
		erpManfService.save(erpManf);
		addMessage(redirectAttributes, "保存厂家维护成功");
		return "redirect:"+Global.getAdminPath()+"/erpmanf/erpManf/?repage";
	}
	
	@RequiresPermissions("erpmanf:erpManf:edit")
	@RequestMapping(value = "delete")
	public String delete(ErpManf erpManf, RedirectAttributes redirectAttributes) {
		erpManfService.delete(erpManf);
		addMessage(redirectAttributes, "删除厂家维护成功");
		return "redirect:"+Global.getAdminPath()+"/erpmanf/erpManf/?repage";
	}

}