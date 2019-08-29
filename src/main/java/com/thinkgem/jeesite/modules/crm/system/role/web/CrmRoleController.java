package com.thinkgem.jeesite.modules.crm.system.role.web;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.crm.system.role.Service.SysRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping(value = "${adminPath}/sysmgr/role")
public class CrmRoleController extends BaseController {

    @Autowired
    private SysRoleService roleService;


    @RequestMapping(value="list",method= RequestMethod.GET)
    public String list(@RequestParam(value = "page", defaultValue = "1") int page,
                       Model model){
        PageBounds pageBounds = new PageBounds(page, 6, Order.formString("id.asc"));
        model.addAttribute("flexSetList", roleService.getRoleList(pageBounds));
        return "modules/crm/system/role/list";
    }

}
