package com.thinkgem.jeesite.modules.rec.web;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.rec.entity.ErpRec;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.rec.service.ErpRecQueryService;


/**
 * 仓库管理--入库管理--入库查询
 * Controller
 * @author lt 111
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
	  

}
