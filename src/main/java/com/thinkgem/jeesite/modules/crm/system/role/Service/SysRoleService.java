package com.thinkgem.jeesite.modules.crm.system.role.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;


import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.modules.crm.system.role.dao.SysRoleDao;
import com.thinkgem.jeesite.modules.crm.system.role.entity.SysRole;
import com.thinkgem.jeesite.modules.sys.entity.Menu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class SysRoleService {

    @Autowired
    private SysRoleDao sysRoleDao;

    public Object getRoleList(PageBounds pageBounds) {
        return sysRoleDao.findRoleList(pageBounds);
    }

    public void insert(SysRole role) {
        role.setUuid(IdGen.uuid());
        sysRoleDao.insert(role);
    }

    public SysRole getRoleByroleId(String roleId) {
        return sysRoleDao.getRoleByroleId(roleId);
    }

    public void update(SysRole sysRole) {
        sysRoleDao.update(sysRole);
    }

    public List<Menu> findAllMenu() {
        return sysRoleDao.getAllMenuList();
    }

    @Transactional(readOnly = false)
    public void saveRoleMenu(String roleId, String[] ids) {
        //删除角色菜单权限
        sysRoleDao.deleteRoleMenu(roleId);
        //保存角色菜单权限
        for (String id : ids) {
            sysRoleDao.insertRoleMenu(roleId,id);
        }
    }


    public List<String> findAllMenuByRole(String roleId) {
        return sysRoleDao.findAllMenuByRole(roleId);
    }
}
