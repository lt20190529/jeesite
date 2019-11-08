package com.thinkgem.jeesite.modules.crm.system.role.dao;

import com.fasterxml.jackson.databind.annotation.JsonPOJOBuilder;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.crm.system.role.entity.SysRole;
import com.thinkgem.jeesite.modules.sys.entity.Menu;
import org.apache.ibatis.annotations.Param;
import sun.awt.SunHints;

import java.util.List;

@MyBatisDao
public interface SysRoleDao {

    public List<SysRole> findRoleList(PageBounds pageBounds);

    void insert(SysRole role);

    SysRole getRoleByroleId(@Param(value="roleId") String roleId);

    void update(SysRole sysRole);

    List<Menu> getAllMenuList();  //加载权限设置树菜单

    void deleteRoleMenu(String roleId);  //删除角色菜单权限

    void insertRoleMenu(@Param(value="roleId")String roleId, @Param(value="id")String id);  //保存用户角色菜单

    List<String> findAllMenuByRole(@Param(value="roleId") String roleId);  //获取角色已经存在的菜单权限
}
