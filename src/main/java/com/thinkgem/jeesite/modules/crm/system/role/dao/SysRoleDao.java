package com.thinkgem.jeesite.modules.crm.system.role.dao;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.crm.system.role.entity.SysRole;

import java.util.List;

@MyBatisDao
public interface SysRoleDao {

    public List<SysRole> findRoleList(PageBounds pageBounds);
}
