package com.thinkgem.jeesite.modules.note.mybatis;

public interface ICustomerDao {

    @Select("select username from customer where id = #{uId}")
    String QueryCustomer(String uId);
}
