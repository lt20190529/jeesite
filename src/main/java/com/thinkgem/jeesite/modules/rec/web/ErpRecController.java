/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.rec.web;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.google.common.collect.Maps;

import com.thinkgem.jeesite.common.repeatformvalidator.SameUrlData;  //防重复提交
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.modules.erpdepartments.entity.ErpDepartments;
import com.thinkgem.jeesite.modules.erpdepartments.service.ErpDepartmentsSerivce;
import com.thinkgem.jeesite.modules.erpmanf.entity.ErpManf;
import com.thinkgem.jeesite.modules.erpmanf.service.ErpManfService;
import com.thinkgem.jeesite.modules.erpuom.entity.ErpUom;
import com.thinkgem.jeesite.modules.erpuom.service.ErpUomService;
import com.thinkgem.jeesite.modules.erpvendor.entity.ErpVendor;
import com.thinkgem.jeesite.modules.erpvendor.service.ErpVendorService;
import com.thinkgem.jeesite.modules.item.entity.ErpItem;
import com.thinkgem.jeesite.modules.item.service.ErpItemService;
import com.thinkgem.jeesite.modules.rec.entity.ErpRec;
import com.thinkgem.jeesite.modules.rec.entity.ErpRecNew;
import com.thinkgem.jeesite.modules.rec.entity.ErpRecdetailNew;
import com.thinkgem.jeesite.modules.rec.service.ErpRecNewService;
import com.thinkgem.jeesite.modules.rec.service.ErpRecQueryService;
import com.thinkgem.jeesite.modules.rec.service.ErpRecService;
import com.thinkgem.jeesite.modules.sys.service.DictService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 入库Controller
 * 
 * @author lxt
 * @version 2018-07-26
 */
@Controller
@RequestMapping(value = "${adminPath}/rec/erpRec")
public class ErpRecController extends BaseController {

	@Autowired
	private ErpRecService erpRecService;

	@Autowired
	private ErpRecNewService erpRecNewService;

	@Autowired
	private ErpUomService erpUomService;

	@Autowired
	private ErpManfService erpManfService;

	@Autowired
	private ErpRecQueryService erpRecQueryService;

	@Autowired
	private DictService dictService;

	@Autowired
	private ErpItemService erpItemService;

	@Autowired
	private ErpDepartmentsSerivce erpDepartmentsSerivce;

	@Autowired
	private ErpVendorService erpVendorService;

	// **********************************************入库列表****************************************************
	// @ModelAttribute 注解的方法会在Controller每个方法执行之前都执行
	//required：是否为必需的，默认为true，表示请求中必须包含对应的参数名，如果不存在就抛出异常
	//defaultValue：默认参数名，设置该参数时，自动将required设为false。极少情况需要使用该参数，也不推荐使用该参数
	@ModelAttribute
	public ErpRecNew get(@RequestParam(required = false) String id) {
		ErpRecNew entity = null;

		if (StringUtils.isNotBlank(id)) {
			entity = erpRecNewService.get(id);
		}
		if (entity == null) {
			entity = new ErpRecNew();
		}
		return entity;
	}

	// 入库列表查询
	@RequiresPermissions("rec:erpRec:view")
	@RequestMapping(value = "list")
	public String list(ErpRecNew erpRecNew, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Page<ErpRecNew> page = erpRecNewService.findPage(new Page<ErpRecNew>(
				request, response), erpRecNew);
		model.addAttribute("page", page);
		return "modules/rec/erpRecList";
	}
	// 入库删除
	@RequiresPermissions("rec:erpRec:edit")
	@RequestMapping(value = "delete")
	public String delete(ErpRecNew erpRecNew,
			RedirectAttributes redirectAttributes) {
		erpRecNewService.delete(erpRecNew);
		addMessage(redirectAttributes, "删除入库成功");
		return "redirect:" + Global.getAdminPath() + "/rec/erpRec/?repage";
	}

	// 入库审核
	@RequiresPermissions("rec:erpRec:Audit")
	@RequestMapping(value = "erpRecAudit")
	@ResponseBody
	public Map<String, Object> erpRecAudit(String id, RedirectAttributes redirectAttributes) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("rid", id);
		m.put("audituser", "1");
		m.put("msg", "-1");
		erpRecNewService.AuditRecById(m);
		resultMap.put("result", m.get("msg"));
		addMessage(redirectAttributes, m.get("msg").toString());
		return resultMap;
	}
	/**
	 * 导出入库主记录信息
	 */
	@RequiresPermissions("rec:erpRec:edit")
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(ErpRec erpRec, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "入库数据" + DateUtils.getDate("yyyyMMddHHmmss")+ ".xlsx";
			Page<ErpRec> page = erpRecService.findPage(new Page<ErpRec>(request, response, -1), erpRec);
			new ExportExcel("入库数据", ErpRec.class).setDataList(page.getList()).write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出入库信息失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + adminPath + "/rec/erpRec/?repage";
	}
		
		
	// **********************************************入库制单界面[EasyUI]****************************************************


	@RequestMapping("GetDetailListE")
	@ResponseBody
	public Map<String, Object> GetDetailE(String id, Model model) {
		System.out.println(id);
		List<ErpRecdetailNew> list = erpRecNewService
				.findErpRecdetailListByRecIdnew(id);
		System.out.println(list);
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("rows", list);
		jsonMap.put("total", list.size());
		return jsonMap;
	}

	// EasyUI入库制单
	@RequestMapping("/getItemListnew")
	@ResponseBody
	public Map<String, Object> getItemListnew() {
		List<ErpItem> items = new ArrayList<ErpItem>();
		ErpItem item = new ErpItem();
		items = erpItemService.findErpItemList(item);
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("rows", items);
		jsonMap.put("total", items.size());
		return jsonMap;
	}

	// 单据编号

	@RequestMapping(value = "GetMaxNo")
	@ResponseBody
	public Map<String, Object> GetMaxNo(String id) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("prefix", "REC");
		m.put("num", 8);
		m.put("OrderNo", "-1");
		erpRecNewService.GetMaxNo(m);
		resultMap.put("result", m.get("OrderNo"));
		return resultMap;
	}

	// 获取单位
	@RequestMapping("/getUomListuom")
	@ResponseBody
	public List<ErpUom> getListuom() {
		List<ErpUom> uoms = new ArrayList<ErpUom>();
		ErpUom uom = new ErpUom();
		uoms = erpUomService.findList(uom);
		return uoms;
	}

	// 获取厂家
	@RequestMapping("/getListManf")
	@ResponseBody
	public List<ErpManf> getListManf() {
		List<ErpManf> manfs = new ArrayList<ErpManf>();
		ErpManf manf = new ErpManf();
		manfs = erpManfService.findList(manf);
		return manfs;
	}



	// 已保存明细的删除
	@RequestMapping(value = "DeleteRecDetailByid")
	@ResponseBody
	public String DeleteRecDetailByid(String detailid) {
		System.out.print(detailid);
		erpRecNewService.deleteE(detailid);
		return "success";

	}
	
	//项目检索列表
	@RequestMapping("/getListnewBy")
	@ResponseBody
	public Map<String, Object> getListnew(String input,int page,int rows) {	
		System.out.print(input+"--"+page+"--"+rows);
        List<ErpItem> items = new ArrayList<ErpItem>();
        Map<String,Object> params = new LinkedHashMap<String,Object>();
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
	
	// **********************************查询页签**********************************
	@RequiresPermissions("rec:erpRec:Query")
	@RequestMapping(value = "erpRecQuery")
	public String erpRecQuery(ErpRecNew erpRecNew, Model model,
			HttpServletRequest request, HttpServletResponse response) throws BadHanyuPinyinOutputFormatCombination {
		
		ErpVendor erpVendor = new ErpVendor();
		List<ErpVendor> erpVendorlist = erpVendorService.findList(erpVendor);
		model.addAttribute("erpVendorlist", erpVendorlist);

		ErpDepartments erpDepartments = new ErpDepartments();
		List<ErpDepartments> erpDepartmentslist = erpDepartmentsSerivce
				.findList(erpDepartments);
		model.addAttribute("erpDepartmentslist", erpDepartmentslist);
		
		return "modules/rec/erpRecQuery";
		
	}
	


	// 查询入库主信息 加载主信息
	@RequestMapping("getrecMainList")
	@ResponseBody
	public Map<String, Object> getrecMainList(String no,String depid,String vendorid,HttpServletRequest request,
			int page,int rows,HttpServletResponse response) throws UnsupportedEncodingException {
		List<ErpRecNew> list = new ArrayList<ErpRecNew>(); // 数据库 获取数据
		int start =(page-1) * rows ;
		Map<String,Object> params = new LinkedHashMap<String,Object>();
        params.put("no", no);       //当sql的条件有模糊匹配时，参数需前后带上%
        params.put("depid", depid);
        params.put("vendorid", vendorid);
        params.put("start", start);
        params.put("pagesize", rows);
		list = erpRecQueryService.findErpMainByfilter(params);
		Integer total=erpRecQueryService.findErpMainByfilterCount(params);
        Map<String,Object> jsonMap = new HashMap<String,Object>(); 
        jsonMap.put("rows",list);
        jsonMap.put("total",total);
        return jsonMap;
	}



	// 加载 明细信息
	@RequestMapping("getListjqGridDetail")
	@ResponseBody
	public Map<String, Object> getListjqGridDetail(@RequestParam("ids")String ids) {
		List<ErpRecdetailNew> list = new ArrayList<ErpRecdetailNew>(); // 数据库 获取数据
		list = erpRecQueryService.finderpRecDetail(ids);
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("rows", list);
		jsonMap.put("total", list.size());
		return jsonMap;

	}
	
		

	// **********************************入库报表页签**********************************
	@RequiresPermissions("rec:erpRec:Report")
	@RequestMapping(value = "erpRecReport")
	public String erpRecReport(ErpRec erpRec, Model model,
			HttpServletRequest request, HttpServletResponse response) {
		return "modules/rec/erpRecReport";
	}

    /* **********************************************入库制单界面[New]****************************************************

     ***********************************************入库制单界面[New]****************************************************/
    // 跳转到入库制单
    @RequiresPermissions("rec:erpRec:view")
    @RequestMapping(value = "form")
    @SameUrlData(save=true)
    public String formA(ErpRecNew erpRecNew, Model model) {
        System.out.print(erpRecNew);
        model.addAttribute("erpRecNew", erpRecNew);

        ErpVendor erpVendor = new ErpVendor();
        List<ErpVendor> erpVendorlist = erpVendorService.findList(erpVendor);
        model.addAttribute("erpVendorlist", erpVendorlist);

        ErpDepartments erpDepartments = new ErpDepartments();
        List<ErpDepartments> erpDepartmentslist = erpDepartmentsSerivce
                .findList(erpDepartments);
        model.addAttribute("erpDepartmentslist", erpDepartmentslist);

        return "modules/rec/erpRecFormA";
    }

    // 提交保存

    @RequestMapping("SaveListjqGridItemE")
    @ResponseBody
    @SameUrlData(remove=true)
    public String SaveListjqGridItemE(@RequestBody ErpRecNew erpRecNew) {
        System.out.println(erpRecNew.toString());
        erpRecNewService.save(erpRecNew);
        return "success";

    }
    // 提交保存入库数据
    @RequestMapping(value = "SaveRecItemA")
    @ResponseBody
    public String SaveRecItemA(ErpRecNew erpRecNew) {
        System.out.println(erpRecNew.toString());
        //erpRecNewService.save(erpRecNew);
        return "success";

    }
    //项目检索列表
    @RequestMapping("/getItemList")
    @ResponseBody
    public Map<String, Object> getItemList(String input,int pageNumber,int pageSize) {
        System.out.print(input);
        List<ErpItem> items = new ArrayList<ErpItem>();
        Map<String,Object> params = new LinkedHashMap<String,Object>();
        params.put("input", "%"+input+"%");    //当sql的条件有模糊匹配时，参数需前后带上%
        params.put("start", (pageNumber-1)*8);
        params.put("pagesize", pageSize);
        items=erpItemService.findErpItemListBy(params);
        Integer total=erpItemService.getErpItemBybrevitycodeCount(params);
        Map<String,Object> jsonMap = new HashMap<String,Object>();
        jsonMap.put("rows",items);
        jsonMap.put("total",total);
        return jsonMap;
    }

    @RequestMapping(value = "/ItemInfo/{params}",method = RequestMethod.POST)
	public String itemInfo(Model model,@PathVariable("params")String params){
    	model.addAttribute("params",params);
    	return "modules/rec/ItemInfo";
	}
}