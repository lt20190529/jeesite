package com.thinkgem.jeesite.modules.crm.system.sysuser.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.thinkgem.jeesite.modules.crm.system.sysuser.dao.SysUserDao;
import com.thinkgem.jeesite.modules.crm.system.sysuser.entity.SysUser;


@Service
@Transactional(readOnly = false)
public class SysUserService {

    @Autowired
    private SysUserDao sysUserDao;

    public List<SysUser> getUserList(PageBounds pageBounds) {
        return sysUserDao.findUserList(pageBounds);
    }

    public SysUser findUserByLoginName(String loginName) {
        return sysUserDao.findUserByLoginName(loginName);
    }

    //新增用户
    public void insert(SysUser sysUser) {
        //保存用户
        sysUserDao.insert(sysUser);
        //保存用户角色
        List<String> roleIdList = sysUser.getRoleList();
        sysUserDao.insertUserRole(sysUser.getId(), roleIdList);
        //保存用户组别
        List<String> groupList=sysUser.getGroupList();
        sysUserDao.insertUserGroup(sysUser.getId(),groupList);

    }

    //根据用户ID查找用户
    public SysUser findSysUserById(String sysUserId) {
        return sysUserDao.findSysUserById(sysUserId);
    }


}
