package com.thinkgem.jeesite.modules.rec.web;

import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.rec.entity.ErpRec;
import com.thinkgem.jeesite.modules.rec.entity.ErpRecDetail;
import com.thinkgem.jeesite.modules.rec.service.ErpRecQueryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;


/**
 * 仓库管理--入库管理--入库查询
 * Controller
 * @author lt
 * @version 2018-08-26
 */
@Controller
@RequestMapping(value = "${adminPath}/rec/erpRecQuery")
public class ErpRecQueryController  extends BaseController  {

	
	   @Autowired
	   private ErpRecQueryService erpRecQueryService;
	   
	   @SuppressWarnings("serial")
	   @ModelAttribute("booleanMap")
	   public Map<String, String> getBooleanMap() {
	        return new LinkedHashMap<String, String>() {{
	            put("Y", "已审核");
	            put("N", "未审核");
	        }};
	    }

	// 查询入库主信息 加载主信息
	@RequestMapping("getRecMainList")
	@ResponseBody
	public Map<String, Object> getrecMainList(@RequestParam Map<String, Object> params,int page, int rows){

		params.put("page", (page-1) * rows);
		params.put("rows", rows);
		List<ErpRec> list = erpRecQueryService.findErpMainByfilter(params);
		Integer total = erpRecQueryService.findErpMainByfilterCount(params);
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("rows", list);
		jsonMap.put("total", total);
		return jsonMap;
	}

	//根据入库主表加载明细信息
	@RequestMapping("/getRecDetailList")
	@ResponseBody
	public Map<String, Object> getItemList(String id,int page, int rows) {
		Map<String, Object> params = new LinkedHashMap<String, Object>();
		params.put("id",id);
		params.put("page", (page-1) * rows);
		params.put("rows", rows);
		List<ErpRecDetail> items  = erpRecQueryService.finderpRecDetail(params);
		Integer total =erpRecQueryService.findErpMainByfilterCount(params);
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("rows", items);
		jsonMap.put("total", total);
		return jsonMap;
	}
	  

}
