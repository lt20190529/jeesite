package com.thinkgem.jeesite.modules.crm.system.sysuser.service;

import java.util.List;

import com.thinkgem.jeesite.common.service.ServiceException;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.crm.system.role.entity.SysRole;
import org.activiti.crystalball.simulator.delegate.event.impl.EventLog2SimulationEventFunction;
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
    public void Save(SysUser sysUser) {

        //保存用户信息
        if (StringUtils.isBlank(sysUser.getId())) {
            //保存用户
            sysUserDao.insert(sysUser);
            //保存用户组别
            //List<Office> groupList=sysUser.getGroupList();
            //sysUserDao.insertUserGroup(sysUser.getId(),groupList);
        }else{
            sysUserDao.update(sysUser);

        }

        //保存用户角色信息
        //1:删除之前保存的角色
        sysUserDao.deleteSysUserRole(sysUser);
        //2：保存用户新的角色();
        if (sysUser.getRoleList() != null && sysUser.getRoleList().size() > 0){
            sysUserDao.insertUserRole(sysUser);
        }else{
            throw new ServiceException(sysUser.getLoginName() + "没有设置角色！");
        }

    }

    //根据用户ID查找用户
    public SysUser findSysUserById(String sysUserId) {
        return sysUserDao.findSysUserById(sysUserId);
    }

    /**
     * 获取租户下所有角色（包括保留角色）
     * @param userid
     * @return
     */
    public List<SysRole> getRoleListByAdminId(String userid){

       return sysUserDao.getRoleListByAdminId(userid);

    }

    //获取用户已分配角色
    public List<SysRole> getRoleListByUserID(String userid){
        return sysUserDao.getRoleListByUserId(userid);
    }
}
