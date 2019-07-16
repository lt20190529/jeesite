package com.thinkgem.jeesite.modules.Drug.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.thinkgem.jeesite.modules.Drug.entity.Drug;
import com.thinkgem.jeesite.modules.Drug.entity.DrugVo;
import com.thinkgem.jeesite.modules.Drug.service.DrugService;
import com.thinkgem.jeesite.modules.erpuom.entity.ErpUom;
import com.thinkgem.jeesite.modules.erpuom.service.ErpUomService;





import java.util.LinkedHashMap;


@Controller
@RequestMapping(value = "${adminPath}/Drug/DrugInfo")
public class DrugController {

	@Autowired
	private DrugService drugService;
	
	@Autowired
	private ErpUomService erpUomService;
	
	@ModelAttribute("booleanMap")
	public Map getBooleanMap() {
	    return new LinkedHashMap<String, String>() {{
                put("Y", "是");
	            put("N", "否");
	        }};
	}
	@RequestMapping("QueryDrugInfo")
	public String form(Model model) {
		model.addAttribute("Drug", new Drug());
		ErpUom erpUom = new ErpUom();	
		List<ErpUom> list1 = erpUomService.findList(erpUom);
		model.addAttribute("uomlist", list1);
		return "modules/Drug/DrugInfo";
	}
	
	
	/**
	 * 校验代码是否存在
	 * @param drug
	 * @return
	 * @throws Exception 
	 */
	
	@RequestMapping(value="checkDrugByCode",produces="application/json")
	@ResponseBody
	public boolean checkDrugByCode(@RequestParam("Drug_Code")String drug_Code ) throws Exception{
		if(drugService.checkDrugByCode(drug_Code)>0){
			return false;
		}else{
			return true;
		}
	}
	
	/**
	 * 校验描述是否存在
	 * @param drug
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="checkDrugByDesc",produces="application/json")
	@ResponseBody
	public boolean checkDrugByDesc(@RequestParam("Drug_Desc")String drug_Desc) throws Exception{
		if(drugService.checkDrugByDesc(drug_Desc)>0){
			return false;
		}else{
			return true;
		}
	}
	
	
	@RequestMapping("Save")
	@ResponseBody
	public String addDrug(@ModelAttribute("Drug")Drug drug) {
		drugService.Save(drug);
		JSONObject result = new JSONObject();  
		result.put("state", "success");  
		return result.toJSONString();  
	    
	}
	
	
	
	//jqGrid  数据准备
	@RequestMapping("getListjqGrid")
    public  @ResponseBody Map<String,Object> getListjqGrid(
            DrugVo drugVo,
    		int page,//页码
			int rows//每页显示个数
    		)throws Exception{
 	    int pageSize=rows; 
 	    int pageNum=page; 

        PageHelper.startPage(pageNum, pageSize);
		List<Drug> basedatalist = drugService.findDrugList(drugVo);
		PageInfo<Drug> pageInfo = new PageInfo<Drug>(basedatalist);
        System.out.println("总页数："+pageInfo.getTotal());
        System.out.println("数据明细："+pageInfo.getList());

        Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("rows", pageInfo.getList());
		jsonMap.put("total", pageInfo.getTotal());
		return jsonMap;
       
    }
}
