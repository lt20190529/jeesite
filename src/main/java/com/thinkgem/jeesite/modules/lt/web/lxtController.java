package com.thinkgem.jeesite.modules.lt.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.erpuom.entity.ErpUom;
import com.thinkgem.jeesite.modules.erpuom.service.ErpUomService;
import com.thinkgem.jeesite.modules.item.entity.ErpItem;
import com.thinkgem.jeesite.modules.item.service.ErpItemService;
import com.thinkgem.jeesite.modules.rec.service.ErpRecService;



/**
 * 入库Controller
 * @author lxt
 * @version 2018-07-26
 */
@Controller
@RequestMapping(value = "${adminPath}/lxt/test")
public class lxtController extends BaseController {

	@Autowired
	private ErpItemService erpItemService;
	
	@Autowired
	private ErpUomService erpUomService;
	
	@RequiresPermissions("lxt:test:view")
	@RequestMapping(value = {"list", ""})
	public String list(Model model) {
		return "modules/lxt/test";
	}

	@RequiresPermissions("lxt:test:edit")
	@RequestMapping(value = "form")
	public String form(Model model) {
		return "modules/lxt/test";
	}
	
	// 测试数据
	@RequestMapping("/getListnew")
	@ResponseBody
	public Map<String, Object> getListnew() {	
        List<ErpItem> items = new ArrayList<ErpItem>();
        ErpItem item = new ErpItem();
        items=erpItemService.findErpItemList(item);
        Map<String,Object> jsonMap = new HashMap<String,Object>(); 
        jsonMap.put("rows",items);
        jsonMap.put("total",items.size());
        return jsonMap;
	}
	// 测试数据
		@RequestMapping("/getListnewBy")
		@ResponseBody
		public Map<String, Object> getListnew(String input,int page,int rows) {	
			System.out.print(input+"--"+page+"--"+rows);
	        List<ErpItem> items = new ArrayList<ErpItem>();
	        Map<String,Object> params = new LinkedHashMap<String,Object>();
	      /*  int start=0;
	        if (page==1){
	        	   start=0;
	           }else{
	        	   start =(page-1) * rows ;
	        }*/
	        int start =(page-1) * rows ;
            params.put("input", "%"+input+"%");    //当sql的条件有模糊匹配时，参数需前后带上%
            params.put("start", start);
            params.put("pagesize", rows);
	        items=erpItemService.findErpItemListBy(params);
	        Integer total=erpItemService.getErpItemBybrevitycodeCount(params);
	        Map<String,Object> jsonMap = new HashMap<String,Object>(); 
	        jsonMap.put("rows",items);
	        jsonMap.put("total",total);
	        return jsonMap;
		}

	// 获取单位
		@RequestMapping("/getListuom")
		@ResponseBody
		public List<ErpUom> getListuom() {	
	        List<ErpUom> uoms = new ArrayList<ErpUom>();
	        ErpUom uom = new ErpUom();
	        uoms=erpUomService.findList(uom);
	        return uoms;
		}
}
