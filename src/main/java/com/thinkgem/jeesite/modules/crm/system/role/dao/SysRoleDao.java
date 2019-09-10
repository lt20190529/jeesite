package com.thinkgem.jeesite.modules.crm.system.role.dao;

import com.fasterxml.jackson.databind.annotation.JsonPOJOBuilder;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.crm.system.role.entity.SysRole;
import org.apache.ibatis.annotations.Param;
import sun.awt.SunHints;

import java.util.List;

@MyBatisDao
public interface SysRoleDao {

    public List<SysRole> findRoleList(PageBounds pageBounds);

    void insert(SysRole role);

    SysRole getRoleByroleId(@Param(value="roleId") String roleId);

    void update(SysRole sysRole);
}
