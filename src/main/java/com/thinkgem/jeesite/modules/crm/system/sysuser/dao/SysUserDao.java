package com.thinkgem.jeesite.modules.crm.system.sysuser.dao;

import java.util.List;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.crm.system.role.entity.SysRole;
import com.thinkgem.jeesite.modules.crm.system.sysuser.entity.SysUser;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import org.apache.ibatis.annotations.Param;


@MyBatisDao
public interface SysUserDao  {
	
	public List<SysUser> findUserList(PageBounds pageBounds);

	public SysUser findUserByLoginName(String loginName);

	//查询相关
	SysUser findSysUserById(String sysUserId);

	//新增用户
	void insert(SysUser sysUser);

	//新增用户保存角色
    void insertUserRole(SysUser sysUser);

    //新增用户保存组别
    void insertUserGroup(@Param("userID") String id, @Param("groupList") List<Office> groupList);

    //查询用户角色(包含已分配和未分配)
    List<SysRole> getRoleListByAdminId(String userid);

    //查询用户角色(已分配)
    List<SysRole> getRoleListByUserId(String sysUserId);
}
