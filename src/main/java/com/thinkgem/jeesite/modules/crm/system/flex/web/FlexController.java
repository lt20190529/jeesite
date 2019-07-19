package com.thinkgem.jeesite.modules.crm.system.flex.web;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.thinkgem.jeesite.common.mapper.BeanMapper;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.crm.system.flex.entity.FlexSet;
import com.thinkgem.jeesite.modules.crm.system.flex.entity.FlexValue;
import com.thinkgem.jeesite.modules.crm.system.flex.service.FlexService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

@Controller
@RequestMapping(value = "${adminPath}/sysmgr/flex")
public class FlexController extends BaseController {
	
	@Autowired
	private FlexService flexService;
     
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(@ModelAttribute("flexSet") FlexSet flexSet,
			@RequestParam(value = "page", defaultValue = "1") int page,
			Model model){
		PageBounds pageBounds = new PageBounds(page, 6,Order.formString("id.asc"));
		model.addAttribute("flexSetList", flexService.getFlexSetList(flexSet,pageBounds));
		return "modules/crm/system/flex/list";
	}
	
	@RequestMapping(value="flexList",method=RequestMethod.POST)
	public String list(@RequestParam(value = "page", defaultValue = "1") int page,
            @ModelAttribute("flexSet") FlexSet flexSet,
            Model model){
		PageBounds pageBounds = new PageBounds(page, 6,Order.formString("id.asc"));
		System.out.println("xxx");
		model.addAttribute("flexSetList", flexService.getFlexSetList(flexSet,pageBounds));
		return "modules/crm/system/flex/list";
	}
	
	@RequestMapping(value = "insert", method = RequestMethod.GET)
    public String flexSetInsert(@RequestParam(value= "treeFlag", required = false) String treeFlag,Model model) {
        model.addAttribute("treeFlag",treeFlag);
        return "modules/crm/system/flex/insert";
    }
	
	@RequestMapping(value = "insert", method = RequestMethod.POST)
    public String flexSetInsert(@ModelAttribute("flexSet") FlexSet flexSet,
			RedirectAttributes redirectAttributes,
    		Model model) {
		flexService.insertFlexSet(flexSet);
		redirectAttributes.addFlashAttribute("message", "保存成功");
		flexSet.setId(flexSet.getId());
		return "redirect:" + adminPath + "/sysmgr/flex";
		
    }
	
	@RequestMapping(value = "modify/{setId}", method = RequestMethod.GET)
    public String flexSetModify(@PathVariable("setId") int flexSetId, Model model,
                                @RequestParam(value= "treeFlag", required = false) String treeFlag) {
        model.addAttribute("treeFlag",treeFlag);
        model.addAttribute("flexSet", flexService.getFlexSetById(flexSetId));
        return "modules/crm/system/flex/modify";
    }
	
	@RequestMapping(value = "modify", method = RequestMethod.POST)
    public String flexSetModify(@ModelAttribute("flexSet") FlexSet flexSet,
    		RedirectAttributes redirectAttributes) {
		flexService.updateFlexSet(flexSet);
        redirectAttributes.addFlashAttribute("message", "修改成功");
        return "redirect:" + adminPath + "/sysmgr/flex";
    }
	/*
	 * 字典分类页面点击名称链接跳转至字典明细列表界面
	 */
	@RequestMapping(value="flexDetail/{setId}/{reserved}")
	public String flexDetail(@PathVariable("setId") int flexSetId,
			@PathVariable("reserved") String reserved,
			@RequestParam(value = "page", defaultValue = "1") int page,
			Model model){
		PageBounds pageBounds = new PageBounds(page, 10, Order.formString("id.asc"));
		List<FlexValue> flexValue=flexService.getFlexValueByFlexSetId(flexSetId, pageBounds);
		model.addAttribute("flexValue",flexValue);
		FlexSet flexSet=flexService.getFlexSetById(flexSetId);
		model.addAttribute("flexSetCode",flexSet.getCode());
		model.addAttribute("setId",flexSetId);
		model.addAttribute("reserved",reserved);
		model.addAttribute("userId",UserUtils.getUser().getId());
		return "modules/crm/system/flex/flexDetail";
	}
	
	
	/*
	 * 字典明细新增跳转
	 */
	@RequestMapping(value="flexDetailInsert/{setId}",method=RequestMethod.GET)
	public String flexSetDetailInsert(@ModelAttribute("flexValue") FlexValue flexValue,
            Model model,
            @RequestParam(value = "reserved", required = false) String reserved,
            @RequestParam(value= "treeFlag", required = false) String treeFlag){
		flexValue.setIstree(treeFlag);
		model.addAttribute("flexValue",flexValue);
		model.addAttribute("reserved",reserved);
		model.addAttribute("userId",UserUtils.getUser().getId());
		return "modules/crm/system/flex/flexDetailInsert";
	}
	/*
	 * 字典明细新增提交
	 */
	@RequestMapping(value="flexDetailInsert",method=RequestMethod.POST)
	public String flexSetDetailInsert(@ModelAttribute("flexValue") FlexValue flexValue,
            RedirectAttributes redirectAttributes,
            @RequestParam(value = "reserved", required = false) String reserved){
		flexValue.setUuid(UUID.randomUUID().toString().replace("-", ""));
		flexService.flexSetDetailInsert(flexValue);
		int flextValueId = flexValue.getSetId();
		redirectAttributes.addAttribute("message", "保存字典明细成功！");
		return "redirect:" + adminPath + "/sysmgr/flex/flexDetail/"+flextValueId+"/reserved="+reserved;
	}
	
	/*
	 * 字典明细修改跳转
	 */
	@RequestMapping(value="flexDetailModify/{valueId}/{setId}",method=RequestMethod.GET)
	public String flexSetDetailUpdate(@PathVariable("valueId")int valueId,
			@PathVariable("setId")int setId,
			Model model,
			@RequestParam(value = "reserved", required = false) String reserved,
            @RequestParam(value= "treeFlag", required = false) String treeFlag){
		FlexSet flexSet=flexService.getFlexSetById(setId);
		model.addAttribute("flexSet",flexSet);
		FlexValue flexValue=flexService.findFlexDetailById(valueId);
		model.addAttribute("flexValue",flexValue);
		model.addAttribute("reserved",reserved);
		model.addAttribute("userId",UserUtils.getUser().getId());
		return "modules/crm/system/flex/flexDetailModify";
	}
	/*
	 * 字典明细修改提交
	 */
	@RequestMapping(value="flexDetailModify",method=RequestMethod.POST)
	public String flexSetDetailUpdate(@ModelAttribute("flexValue") FlexValue flexValue,
            RedirectAttributes redirectAttributes,
            @RequestParam(value = "reserved", required = false) String reserved){
		flexService.flexSetDetailUpdate(flexValue);
		redirectAttributes.addFlashAttribute("message","修改字典明细成功!");
		return "redirect:" + adminPath + "/sysmgr/flex/flexDetail/" +flexValue.getSetId()+ "/reserved="+reserved;
		
	}
	
	/*
	 * 字典状态修改111
	 */
	@RequestMapping(value="toggleStatus/{setId}")
	public ModelAndView flextoggleStatus(@PathVariable("setId")int flexSetId){
		flexService.flextoggleStatus(flexSetId);
		FlexSet flexSet = new FlexSet();
		PageBounds page = new PageBounds(1, 10);
        Map<String, Object> map = BeanMapper.map(flexSet, Map.class);
        map.put("page", page);
		return new ModelAndView("redirect:" + adminPath + "/sysmgr/flex").addAllObjects(map);
	}
	
	/*
	 * 删除字典分类
	 */
	@RequestMapping(value="delete/{setId}")
	public String flexSetDelete(@PathVariable("setId") int flexSetId) {
		flexService.deleteFlexSet(flexSetId);
		flexService.deleteFlexValue(flexSetId);
		return "redirect:" + adminPath + "/sysmgr/flex";
    }
	
	/*
	 * 修改字典明细状态
	 */
	@RequestMapping(value="toggleValueStatus/{flexValueId}/{flexSetId}/{reserved}")
	public ModelAndView toggleFlexValueStatus(@PathVariable("flexValueId") int flexValueId,
			@PathVariable("flexSetId") int flexSetId,
			@PathVariable("reserved") String reserved){
		flexService.flexValueToggleStatus(flexValueId);
		return new ModelAndView("redirect:" + adminPath + "/sysmgr/flex/flexDetail/" +flexSetId+ "/reserved="+reserved);
	}
	
	/*
	 * 删除字典明细
	 */
	@RequestMapping(value="flexValueDelete/{flexValueId}/{flexSetId}/{reserved}")
	public String flexValueDelete(@PathVariable("flexValueId") int flexValueId,
			@PathVariable("flexSetId") int flexSetId,
			@PathVariable("reserved") String reserved,
			Model model){
		flexService.deleteFlexValueBySetId(flexValueId);
		return "redirect:" + adminPath + "/sysmgr/flex/flexDetail/" +flexSetId+ "/reserved="+reserved;
	}
}
