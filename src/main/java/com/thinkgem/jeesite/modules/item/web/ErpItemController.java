/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.item.web;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.erpuom.entity.ErpUom;
import com.thinkgem.jeesite.modules.erpuom.service.ErpUomService;
import com.thinkgem.jeesite.modules.item.entity.ErpItem;
import com.thinkgem.jeesite.modules.item.service.ErpItemService;

/**
 * 字典维护Controller
 * @author lxt
 * @version 2018-08-06
 */
@Controller
@RequestMapping(value = "${adminPath}/item/erpItem")
public class ErpItemController extends BaseController {

	@Autowired
	private ErpItemService erpItemService;
	
	@Autowired
	private ErpUomService erpUomService;
	
	@ModelAttribute
	public ErpItem get(@RequestParam(required=false) String id) {
		ErpItem entity = null;
		if (StringUtils.isNotBlank(id)){
			//entity = erpItemService.get(id);
			entity =erpItemService.getErpItemByid(id);
		}
		if (entity == null){
			entity = new ErpItem();
		}
		return entity;
	}
	
	@RequiresPermissions("item:erpItem:view")
	@RequestMapping(value = {"list", ""})
	public String list(ErpItem erpItem, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ErpItem> page = erpItemService.findErpItemPage(new Page<ErpItem>(request, response), erpItem); 
		model.addAttribute("page", page);
		return "modules/item/erpItemList";
	}

	@RequiresPermissions("item:erpItem:view")
	@RequestMapping(value = "form")
	public String form(ErpItem erpItem, Model model) {
		model.addAttribute("erpItem", erpItem);
		ErpUom erpUom = new ErpUom();	
		List<ErpUom> list1 = erpUomService.findList(erpUom);
		
		model.addAttribute("uomlist", list1);
		return "modules/item/erpItemForm";
	}

	@RequiresPermissions("item:erpItem:edit")
	@RequestMapping(value = "save")
	public String save(ErpItem erpItem, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, erpItem)){
			return form(erpItem, model);
		}
		erpItemService.save(erpItem);
		addMessage(redirectAttributes, "保存字典维护成功");
		return "redirect:"+Global.getAdminPath()+"/item/erpItem/?repage";
	}
	
	@RequiresPermissions("item:erpItem:edit")
	@RequestMapping(value = "delete")
	public String delete(ErpItem erpItem, RedirectAttributes redirectAttributes) {
		erpItemService.delete(erpItem);
		addMessage(redirectAttributes, "删除字典维护成功");
		return "redirect:"+Global.getAdminPath()+"/item/erpItem/?repage";
	}
	
	 /**
     * 验证项目代码是否唯一
     * @param itemNo 项目代码
     * @return 不存在返回true，已存在返回false
     */
    @RequestMapping(value = "checkItemCode",produces = "application/json")
    @ResponseBody
    public boolean checkItemCode(@RequestParam("itemNo")String itemNo){
        if(erpItemService.getItemNo(itemNo) == null){
            return true;
        }else{
            return false;
        }
    }
    /**
     * 验证项目描述是否唯一
     * @param itemDesc 项目代码
     * @return 不存在返回true，已存在返回false
     * @throws UnsupportedEncodingException 
     */
    @RequestMapping(value = "checkItemDesc",produces = "application/json")
    @ResponseBody
    public boolean checkItemDesc(@RequestParam("itemDesc")String itemDesc) throws UnsupportedEncodingException{
    	System.out.println(itemDesc);
        if(erpItemService.getItemDesc(itemDesc) == null){
            return true;
        }else{
            return false;
        }
    }

}