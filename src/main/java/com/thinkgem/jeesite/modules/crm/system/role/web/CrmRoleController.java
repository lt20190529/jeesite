package com.thinkgem.jeesite.modules.crm.system.role.web;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.thinkgem.jeesite.common.utils.AlertInfo;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.crm.system.flex.service.FlexService;
import com.thinkgem.jeesite.modules.crm.system.role.Service.SysRoleService;
import com.thinkgem.jeesite.modules.crm.system.role.entity.SysRole;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomBooleanEditor;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

@Controller
@RequestMapping(value = "${adminPath}/sysmgr/role")
public class CrmRoleController extends BaseController {

    @Autowired
    private SysRoleService sysroleService;

    @Autowired
    private FlexService flexService;

    @SuppressWarnings("serial")
    private Map<String, String> roleStatus = new LinkedHashMap<String, String>() {{
        put("Y", "是");
        put("N", "否");
    }};
    @SuppressWarnings("serial")
    private Map<String, String> sysFlag = new LinkedHashMap<String, String>() {{
        put("Y", "系统角色");
        put("N", "非系统角色");
    }};

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Boolean.class, "reserved", new CustomBooleanEditor("Y", "N", true));
        binder.registerCustomEditor(Boolean.class, "sysflag", new CustomBooleanEditor("Y", "N", true));
        DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(fmt, true));
    }
    @RequestMapping(value="list",method= RequestMethod.GET)
    public String list(@RequestParam(value = "page", defaultValue = "1") int page,
                       Model model){
        PageBounds pageBounds = new PageBounds(page, 6, Order.formString("id.asc"));
        model.addAttribute("roleList", sysroleService.getRoleList(pageBounds));
        return "modules/crm/system/role/list";
    }
    @RequestMapping(value="query",method=RequestMethod.POST)   //get常用于取回数据，post用于提交数据
    public String query(@RequestParam(value = "page", defaultValue = "1") int page,Model model){
        PageBounds pageBounds = new PageBounds(page, 6,Order.formString("id.asc"));
        model.addAttribute("roleList", sysroleService.getRoleList(pageBounds));
        return "modules/crm/system/role/list";
    }
    @RequestMapping(value="insert",method=RequestMethod.GET)
    public String insert(Model model){
        SysRole sysRole=new SysRole();
        model.addAttribute("roleStatus",roleStatus);
        model.addAttribute("sysFlag",sysFlag);
        model.addAttribute("ROLE_TYPE",flexService.getOptionsBySetCode("ROLE_TYPE",true));
        model.addAttribute("role",sysRole);
        return "modules/crm/system/role/insert";
    }

    @RequestMapping(value="insert",method=RequestMethod.POST)
    public String insert(@ModelAttribute("sysUser") SysRole role,
                         RedirectAttributes redirectAttributes){
        sysroleService.insert(role);
        AlertInfo alertInfo = new AlertInfo(AlertInfo.Type.success, "保存成功..");
        redirectAttributes.addFlashAttribute("alertInfo", alertInfo);
        return "redirect:" + adminPath + "/sysmgr/role/insert";
    }

    @RequestMapping(value="modify/{roleId}",method=RequestMethod.GET)
    public String modify(@PathVariable("roleId")String roleId,Model model){
        model.addAttribute("roleStatus",roleStatus);
        model.addAttribute("sysFlag",sysFlag);
        model.addAttribute("ROLE_TYPE",flexService.getOptionsBySetCode("ROLE_TYPE",true));
        model.addAttribute("Role",sysroleService.getRoleByroleId(roleId));
        return "modules/crm/system/role/modify";
    }

    @RequestMapping(value="modify",method=RequestMethod.POST)
    public String modify(Model model,SysRole sysRole){
        sysroleService.update(sysRole);
        return "redirect:" + adminPath + "/sysmgr/role/list";
    }
    @RequestMapping(value="delete/{roleId}",method=RequestMethod.GET)
    public String delete(@PathVariable("roleId")String roleId){

        return "modules/crm/system/role/list";
    }

    @RequestMapping(value="toggleStatus/{roleId}",method=RequestMethod.GET)
    public String toggleStatus(@PathVariable("roleId")String roleId){
        return "modules/crm/system/role/list";
    }

}
