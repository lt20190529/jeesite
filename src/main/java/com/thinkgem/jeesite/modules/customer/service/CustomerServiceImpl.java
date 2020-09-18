package com.thinkgem.jeesite.modules.customer.service;

import com.thinkgem.jeesite.modules.customer.dao.CustomerDao;
import com.thinkgem.jeesite.modules.test.entity.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    private CustomerDao customerDao;
    @Override
    public void insertCustomer(Customer customer) {
      this.customerDao.insertCustomer(customer);
    }
}
