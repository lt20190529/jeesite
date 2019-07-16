/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.erpuom.web;

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
import com.thinkgem.jeesite.modules.erpuom.entity.ErpUom;
import com.thinkgem.jeesite.modules.erpuom.service.ErpUomService;

/**
 * 单位维护Controller
 * @author 单位维护
 * @version 2018-09-20
 */
@Controller
@RequestMapping(value = "${adminPath}/erpuom/erpUom")
public class ErpUomController extends BaseController {

	@Autowired
	private ErpUomService erpUomService;
	
	@ModelAttribute
	public ErpUom get(@RequestParam(required=false) String id) {
		ErpUom entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = erpUomService.get(id);
		}
		if (entity == null){
			entity = new ErpUom();
		}
		return entity;
	}
	
	@RequiresPermissions("erpuom:erpUom:view")
	@RequestMapping(value = {"list", ""})
	public String list(ErpUom erpUom, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ErpUom> page = erpUomService.findPage(new Page<ErpUom>(request, response), erpUom); 
		model.addAttribute("page", page);
		return "modules/erpuom/erpUomList";
	}

	@RequiresPermissions("erpuom:erpUom:view")
	@RequestMapping(value = "form")
	public String form(ErpUom erpUom, Model model) {
		model.addAttribute("erpUom", erpUom);
		return "modules/erpuom/erpUomForm";
	}

	@RequiresPermissions("erpuom:erpUom:edit")
	@RequestMapping(value = "save")
	public String save(ErpUom erpUom, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, erpUom)){
			return form(erpUom, model);
		}
		erpUomService.save(erpUom);
		addMessage(redirectAttributes, "保存单位维护成功");
		return "redirect:"+Global.getAdminPath()+"/erpuom/erpUom/?repage";
	}
	
	@RequiresPermissions("erpuom:erpUom:edit")
	@RequestMapping(value = "delete")
	public String delete(ErpUom erpUom, RedirectAttributes redirectAttributes) {
		erpUomService.delete(erpUom);
		addMessage(redirectAttributes, "删除单位维护成功");
		return "redirect:"+Global.getAdminPath()+"/erpuom/erpUom/?repage";
	}

}