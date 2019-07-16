package com.thinkgem.jeesite.modules.crm.system.sysuser.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.crm.system.sysuser.entity.SysUser;




@MyBatisDao
public interface SysUserDao extends CrudDao<SysUser>  {
	
	public List<SysUser> findUserList()throws Exception;

}
