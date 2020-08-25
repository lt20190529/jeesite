package com.thinkgem.jeesite.modules.Drug.web;

import java.io.File;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONArray;
import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.thinkgem.jeesite.modules.Drug.entity.Drug;
import com.thinkgem.jeesite.modules.Drug.entity.DrugVo;
import com.thinkgem.jeesite.modules.Drug.service.DrugService;
import com.thinkgem.jeesite.modules.erpuom.entity.ErpUom;
import com.thinkgem.jeesite.modules.erpuom.service.ErpUomService;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;


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
	public String form(Model model,DrugVo drugVo) throws Exception {
		model.addAttribute("Drug", new Drug());
		ErpUom erpUom = new ErpUom();	
		List<ErpUom> list1 = erpUomService.findList(erpUom);
		List<Drug> drugList=drugService.findDrugList(drugVo);
		model.addAttribute("druglist",drugList);
		model.addAttribute("uomlist", list1);
		return "modules/Drug/DrugInfo";
	}
	
	
	/**
	 * &#x6821;&#x9a8c;&#x4ee3;&#x7801;&#x662f;&#x5426;&#x5b58;&#x5728;
	 * @param drug_Code
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
	
	@RequestMapping(value="getDrugInfo/{drugID}",method = RequestMethod.POST)
	@ResponseBody
	public String getDrugInfo(@PathVariable("drugID")String drugID){
		Drug drug=drugService.getDrugInfoByID(drugID);
		return JsonMapper.getInstance().toJson(drug);
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
        Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("rows", pageInfo.getList());
		jsonMap.put("total", pageInfo.getTotal());
		return jsonMap;
       
    }
	@RequestMapping(value="/photoUpload",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> test(MultipartFile photo, HttpServletRequest request){
		Map<String, String> ret = new HashMap<String, String>();
		if (photo == null) {
			ret.put("type", "error");
			ret.put("msg", "选择要上传的文件！");
			return ret;
		}
		if (photo.getSize() > 1024 * 1024 * 10) {
			ret.put("type", "error");
			ret.put("msg", "文件大小不能超过10M！");
			return ret;
		}
		//获取文件后缀
		String suffix = photo.getOriginalFilename().substring(photo.getOriginalFilename().lastIndexOf(".") + 1, photo.getOriginalFilename().length());
		if (!"jpg,jpeg,gif,png".toUpperCase().contains(suffix.toUpperCase())) {
			ret.put("type", "error");
			ret.put("msg", "请选择jpg,jpeg,gif,png格式的图片！");
			return ret;
		}
		//获取项目根目录加上图片目录 webapp/static/imgages/upload/
		String savePath = request.getSession().getServletContext().getRealPath("/") + "\\static\\images\\";
		File savePathFile = new File(savePath);
		if (!savePathFile.exists()) {
			//若不存在该目录，则创建目录
			savePathFile.mkdir();
		}
		String filename = new Date().getTime() + "." + suffix;
		try {
			//将文件保存指定目录
			photo.transferTo(new File(savePath + filename));
		} catch (Exception e) {
			ret.put("type", "error");
			ret.put("msg", "保存文件异常！");
			e.printStackTrace();
			return ret;
		}
		System.out.println("图片上传。。。");
		ret.put("type", "success");
		ret.put("msg", "falil");
		ret.put("filepath", request.getSession().getServletContext().getContextPath() + "/static/images/");
		ret.put("filename", filename);
		return ret;
	}

    @RequestMapping(value="Excel",method=RequestMethod.POST)
    public ModelAndView ExcelDrugInfo(DrugVo drugVo, HttpServletRequest request, HttpServletResponse response){
        Map<String, Object> map = new HashMap<String, Object>();
	    try{
	        String fileName="药品数据"+ DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
			DrugVo drug=new DrugVo();
	        List<Drug> listDrug=drugService.findDrugList(drug);
            new ExportExcel("药品数据", Drug.class).setDataList(listDrug).write(response, fileName).dispose();
            return null;
        }catch (Exception e){
           map.put("message","导出药品数据错误,信息:"+e.getMessage());
        }
       return new ModelAndView("redirect:"  + "/modules/Drug/DrugInfo").addAllObjects(map);
    }

	/**
	 * 下载导入药品数据模板
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "import/template")
	public ModelAndView importFileTemplate(HttpServletResponse response) {
		try {
			String fileName = "药品数据导入模板.xlsx";
			List<Drug> list = Lists.newArrayList();
			new ExportExcel("药品数据", Drug.class, 2).setDataList(list).write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			System.out.println("导入模板下载失败！失败信息："+e.getMessage());
		}
		return new ModelAndView("redirect:"  + "/modules/Drug/DrugInfo");
	}
}
