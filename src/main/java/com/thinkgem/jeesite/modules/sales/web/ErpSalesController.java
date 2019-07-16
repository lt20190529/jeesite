package com.thinkgem.jeesite.modules.sales.web;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.erpdepartments.entity.ErpDepartments;
import com.thinkgem.jeesite.modules.erpdepartments.service.ErpDepartmentsSerivce;
import com.thinkgem.jeesite.modules.rec.entity.ErpRec;
import com.thinkgem.jeesite.modules.rec.entity.ErpRecNew;
import com.thinkgem.jeesite.modules.rec.entity.ErpRecdetailNew;
import com.thinkgem.jeesite.modules.sales.entity.ErpSales;
import com.thinkgem.jeesite.modules.sales.entity.ErpSalesDetail;
import com.thinkgem.jeesite.modules.sales.service.ErpSalesService;


/**
 * 入库Controller
 * 
 * @author lxt
 * @version 2018-07-26
 */
@Controller
@RequestMapping(value = "${adminPath}/sales/erpSales")
public class ErpSalesController extends BaseController{
	
		@Autowired
	    private ErpSalesService erpSalesService;
		
		@Autowired
		private ErpDepartmentsSerivce erpDepartmentsSerivce;
	
	    // **********************************************销售制单****************************************************
		@RequiresPermissions("sales:erpSales:view")
		@RequestMapping(value = "erpSalesForm")
		public String erpSalesForm(ErpSales erpSales,Model model) {
			model.addAttribute("ErpSales", erpSales);

			ErpDepartments erpDepartments = new ErpDepartments();
			List<ErpDepartments> erpDepartmentslist = erpDepartmentsSerivce
					.findList(erpDepartments);
			model.addAttribute("erpDepartmentslist", erpDepartmentslist);
			return "modules/sales/erpSalesForm";
		}
		
		
		// 单据编号

		@RequestMapping(value = "GetMaxNo")
		@ResponseBody
		public Map<String, Object> GetMaxNo(String id) {

			Map<String, Object> resultMap = new HashMap<String, Object>();
			Map<String, Object> m = new HashMap<String, Object>();
			m.put("prefix", "SAL");
			m.put("num", 8);
			m.put("SalesNo", "-1");
			erpSalesService.GetMaxNo(m);
			resultMap.put("result", m.get("SalesNo"));
			return resultMap;
		}
		
		// 提交保存
		@RequestMapping("SaveErpSalesDetail")
		@ResponseBody
		public String SaveErpSalesDetail(@RequestBody ErpSales erpSales) {
			System.out.println(erpSales.toString());
			erpSalesService.save(erpSales);
			return "success";

		}
		

		// **********************************************销售审核****************************************************
		//@ModelAttribute 注解的方法会在Controller每个方法执行之前都执行
		@ModelAttribute
		public ErpSales get(@RequestParam(required = false) String id, Model model) {
			ErpSales entity = null;

			if (StringUtils.isNotBlank(id)) {
				entity = erpSalesService.get(id);
			}
			if (entity == null) {
				entity = new ErpSales();
			}
			return entity;
		}

		@RequiresPermissions("sales:erpSales:Audit")
		@RequestMapping(value = "erpSalesAudit")
		public String erpSalesAudit(ErpSales erpSales,Model model,
				HttpServletRequest request, HttpServletResponse response)  {
			Page<ErpSales> page = erpSalesService.findPage(new Page<ErpSales>(
					request, response), erpSales);
			model.addAttribute("page", page);
			return "modules/sales/erpSalesAudit";
			
		}
		//审核跳转至编辑界面加载明细
		@RequestMapping("GetSalesDetailList")
		@ResponseBody
		public Map<String, Object> GetDetailE(String id, Model model) {
			System.out.println(id);
			List<ErpSalesDetail> list = erpSalesService.findErpSalesDetailListBySalesId(id);
			System.out.println(list);
			Map<String, Object> jsonMap = new HashMap<String, Object>();
			jsonMap.put("rows", list);
			jsonMap.put("total", list.size());
			return jsonMap;
		}
		
		// 已保存明细的删除
		@RequestMapping(value = "DeleteSalesDetailByid")
		@ResponseBody
		public String DeleteSalesDetailByid(String detailid) {
			erpSalesService.deleteE(detailid);
			return "success";

		}
		
		// 销售审核
		@RequiresPermissions("sales:erpSales:Audit")
		@RequestMapping(value = "erpSalesAuditBySalesId")
		@ResponseBody
		public Map<String, Object> erpSalesAudit(String id, RedirectAttributes redirectAttributes) {

			Map<String, Object> resultMap = new HashMap<String, Object>();
			Map<String, Object> m = new HashMap<String, Object>();
			m.put("rid", id);
			m.put("audituser", "1");
			m.put("msg", "-1");
			erpSalesService.AuditSalesById(m);
			resultMap.put("result", m.get("msg"));
			addMessage(redirectAttributes, m.get("msg").toString());
			return resultMap;
		}
		
		
		
		// **********************************************销售查询****************************************************
		@RequiresPermissions("sales:erpSales:Query")
		@RequestMapping(value = "erpSalesQuery")
		public String erpSalesQuery(ErpSales erpSales,Model model,HttpServletRequest request, HttpServletResponse response)  {
			ErpDepartments erpDepartments = new ErpDepartments();
			List<ErpDepartments> erpDepartmentslist = erpDepartmentsSerivce
					.findList(erpDepartments);
			model.addAttribute("erpDepartmentslist", erpDepartmentslist);
			return "modules/sales/erpSalesQuery";
			
		}
		
		// 查询入库主信息 加载主信息
		@RequestMapping("getSalesMainList")
		@ResponseBody
		public Map<String, Object> getSalesMainList(String no,String depid,String vendorid,HttpServletRequest request,
				int page,int rows,HttpServletResponse response) throws UnsupportedEncodingException {
			List<ErpSales> list = new ArrayList<ErpSales>(); // 数据库 获取数据
			int start =(page-1) * rows ;
			Map<String,Object> params = new LinkedHashMap<String,Object>();
	        params.put("no", no);       //当sql的条件有模糊匹配时，参数需前后带上%
	        params.put("depid", depid);
	        params.put("start", start);
	        params.put("pagesize", rows);
			list = erpSalesService.findErpSalesByfilter(params);
			Integer total=erpSalesService.findErpSalesByfilterCount(params);
	        Map<String,Object> jsonMap = new HashMap<String,Object>(); 
	        jsonMap.put("rows",list);
	        jsonMap.put("total",total);
	        return jsonMap;
		}



		// 加载 明细信息
		@RequestMapping("getSalesListjqGridDetail")
		@ResponseBody
		public Map<String, Object> getSalesListjqGridDetail(@RequestParam("ids")String ids) {
			List<ErpSalesDetail> list = new ArrayList<ErpSalesDetail>(); // 数据库 获取数据
			list = erpSalesService.findErpSalesDetail(ids);
			Map<String, Object> jsonMap = new HashMap<String, Object>();
			jsonMap.put("rows", list);
			jsonMap.put("total", list.size());
			return jsonMap;

		}
		
		
		
		
		// *************************************************销售汇总*******************
		@RequiresPermissions("sales:erpSales:Report")
		@RequestMapping(value = "erpSalesReport")
		public String erpSalesReport(Model model,
				HttpServletRequest request, HttpServletResponse response) {
			return "modules/sales/erpSalesReport";
		}

}
