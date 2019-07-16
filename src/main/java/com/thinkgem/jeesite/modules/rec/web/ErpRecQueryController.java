package com.thinkgem.jeesite.modules.rec.web;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.rec.entity.ErpRec;
import com.thinkgem.jeesite.modules.rec.service.ErpRecQueryService;
import com.thinkgem.jeesite.modules.rec.service.ErpRecService;



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
	  
	    //入库查询
		@RequiresPermissions("rec:erpRecQuery:Query")
		@RequestMapping(value = "erpRecQuery")
		public String erpRecQuery(ErpRec erpRec, Model model,HttpServletRequest request, HttpServletResponse response) {
			//Page<ErpRec> erpRecpage = erpRecQueryService.findErpRecPage(new Page<ErpRec>(request, response), erpRec); 
			System.out.print("*******************query*********************");
			//model.addAttribute("erpRecpage", erpRecpage.getList());
			return "modules/rec/erpRecQuery";
		}
}
