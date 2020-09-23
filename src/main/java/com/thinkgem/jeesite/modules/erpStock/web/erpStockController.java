package com.thinkgem.jeesite.modules.erpStock.web;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.erpStock.entity.ErpStock;
import com.thinkgem.jeesite.modules.erpStock.service.StockMangerService;
import com.thinkgem.jeesite.modules.erpdepartments.entity.ErpDepartments;
import com.thinkgem.jeesite.modules.erpdepartments.service.ErpDepartmentsSerivce;

/*
 * 库存管理--库存查询
 * lt
 * 
 */
@Controller
@RequestMapping(value = "${adminPath}/erp/StockManger")
public class erpStockController extends BaseController {

	@Autowired
	private ErpDepartmentsSerivce erpDepartmentsSerivce;

	@Autowired
	private StockMangerService stockMangerService;
	
	
	@RequiresPermissions("erp:StockManger:Query")
	@RequestMapping(value = "query")
	
	public String list(Model model) {
		
		ErpDepartments erpDepartments = new ErpDepartments();
		List<ErpDepartments> erpDepartmentslist = erpDepartmentsSerivce
				.findList(erpDepartments);
		model.addAttribute("erpDepartmentslist", erpDepartmentslist);
		ErpStock erpStock=new ErpStock();
		model.addAttribute("erpStock", erpStock);
		
		return "modules/erpstock/StockQuery";
	}
	
	    // 查询库房库存信息
		@RequestMapping("getDepStockInfo")
		@ResponseBody
		public Map<String, Object> getrecMainList(ErpStock erpStock,String vendorid,HttpServletRequest request,
				int page,int rows,HttpServletResponse response) throws UnsupportedEncodingException {
			List<ErpStock> list = new ArrayList<ErpStock>(); // 数据库 获取数据
			int start =(page-1) * rows ;
			Map<String,Object> params = new LinkedHashMap<String,Object>();
	        params.put("itemno", erpStock.getErpItem().getItemNo());       //当sql的条件有模糊匹配时，参数需前后带上%
	        params.put("depid", erpStock.getErpDepartments().getId());
	        params.put("itemdesc", erpStock.getErpItem().getItemDesc());
	        params.put("itemBrevitycode", erpStock.getErpItem().getItemBrevitycode());
	        params.put("start", start);
	        params.put("pagesize", rows);
	        list = stockMangerService.findDepStockByfilter(params);
			Integer total=stockMangerService.findDepStockByfilterCount(params);
	        Map<String,Object> jsonMap = new HashMap<String,Object>(); 
	        jsonMap.put("rows",list);
	        jsonMap.put("total",total);
	        return jsonMap;
		}
		
		
		
	
}
