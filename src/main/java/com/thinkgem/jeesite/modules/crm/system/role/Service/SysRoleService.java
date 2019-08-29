package com.thinkgem.jeesite.modules.crm.system.role.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;


import com.thinkgem.jeesite.modules.crm.system.role.dao.SysRoleDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = false)
public class SysRoleService {

    @Autowired
    private SysRoleDao sysRoleDao;

    public Object getRoleList(PageBounds pageBounds) {
        return sysRoleDao.findRoleList(pageBounds);
    }
}
