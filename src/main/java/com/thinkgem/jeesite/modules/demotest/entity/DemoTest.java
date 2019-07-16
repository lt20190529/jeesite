/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.demotest.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 测试用户Entity
 * @author lxt
 * @version 2018-07-25
 */
public class DemoTest extends DataEntity<DemoTest> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 姓名
	private String age;		// 年龄
	
	public DemoTest() {
		super();
	}

	public DemoTest(String id){
		super(id);
	}

	@Length(min=0, max=50, message="姓名长度必须介于 0 和 50 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=20, message="年龄长度必须介于 0 和 20 之间")
	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}
	
}