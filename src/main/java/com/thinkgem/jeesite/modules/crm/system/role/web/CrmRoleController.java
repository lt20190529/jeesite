package com.thinkgem.jeesite.modules.crm.system.role.web;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.crm.system.flex.service.FlexService;
import com.thinkgem.jeesite.modules.crm.system.role.Service.SysRoleService;
import com.thinkgem.jeesite.modules.crm.system.role.entity.SysRole;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
    private Map<String, String> roleFlag = new LinkedHashMap<String, String>() {{
        put("Y", "是");
        put("N", "否");
    }};

    @RequestMapping(value="list",method= RequestMethod.GET)
    public String list(@RequestParam(value = "page", defaultValue = "1") int page,
                       Model model){
        PageBounds pageBounds = new PageBounds(page, 6, Order.formString("id.asc"));
        model.addAttribute("roleList", sysroleService.getRoleList(pageBounds));
        return "modules/crm/system/role/list";
    }

    @RequestMapping(value="insert",method=RequestMethod.GET)
    public String insert(Model model){
        SysRole sysRole=new SysRole();
        model.addAttribute("roleStatus",roleStatus);
        model.addAttribute("roleFlag",roleFlag);
        model.addAttribute("ROLE_TYPE",flexService.getOptionsBySetCode("ROLE_TYPE",true));
        model.addAttribute("role",sysRole);
        return "modules/crm/system/role/insert";
    }

    @RequestMapping(value="modify/{roleId}",method=RequestMethod.GET)
    public String modify(@PathVariable("roleId")String roleId){
        return "modules/crm/system/role/modify";
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
