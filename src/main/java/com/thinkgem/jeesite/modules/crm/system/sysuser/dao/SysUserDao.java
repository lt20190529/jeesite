package com.thinkgem.jeesite.modules.crm.system.sysuser.dao;

import java.util.List;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.crm.system.sysuser.entity.SysUser;




@MyBatisDao
public interface SysUserDao  {
	
	public List<SysUser> findUserList(PageBounds pageBounds);

	public SysUser findUserByLoginName(String loginName);

	//查询相关
	SysUser findSysUserById(String sysUserId);

	//新增用户
	void insert(SysUser sysUser);

}
