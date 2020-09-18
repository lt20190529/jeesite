package com.thinkgem.jeesite.modules.customer.dao;

import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.test.entity.Customer;

@MyBatisDao
public interface CustomerDao {

   void insertCustomer(Customer customer);

   void updateCustommer(Customer customer);
}
