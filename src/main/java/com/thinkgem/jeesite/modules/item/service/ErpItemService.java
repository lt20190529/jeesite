/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.item.service;

import java.util.List;
import java.util.Map;

import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.HanziUtils;
import com.thinkgem.jeesite.modules.item.entity.ErpItem;
import com.thinkgem.jeesite.modules.item.dao.ErpItemDao;

/**
 * 字典维护Service
 * @author lxt
 * @version 2018-08-06
 */
@Service
@Transactional(readOnly = true)
public class ErpItemService extends CrudService<ErpItemDao, ErpItem> {

	@Autowired
	private ErpItemDao erpItemDao;
	
	//继承超类的根据id获取ErpItem
	public ErpItem get(String id) {
		return super.get(id);
	}
	
	//重写根据ID获取ErpItem
	public ErpItem getErpItemByid(String id) {
		return erpItemDao.getErpItemByid(id);
	}
	
	public List<ErpItem> findList(ErpItem erpItem) {
		return super.findList(erpItem);
	}
	
	//获取所有字典(字典列表使用)
	public List<ErpItem> findErpItemList(ErpItem erpItem) {
		return erpItemDao.findErpItemList(erpItem);
	}
	
	//获取所有字典(字典列表使用模糊检索)
	public List<ErpItem>  findErpItemListBy(Map<String,Object> map){
		return erpItemDao.getErpItemBybrevitycode(map);
	}
	//项目选择框检索总条数
	public  Integer getErpItemBybrevitycodeCount(Map<String,Object> map){
		return erpItemDao.getErpItemBybrevitycodeCount(map);
	};

	public Page<ErpItem> findErpItemPage(Page<ErpItem> page, ErpItem erpItem) {
		erpItem.setPage(page);
		page.setList(erpItemDao.findErpItemList(erpItem));
		return page;
	}

	
	
	public Page<ErpItem> findPage(Page<ErpItem> page, ErpItem erpItem) {
		return super.findPage(page, erpItem);
	}
	
	@Transactional(readOnly = false)
	public void save(ErpItem erpItem) {
		HanziUtils pinyin4j = new HanziUtils();
		String ItemDesc=erpItem.getItemDesc();
		try {
			erpItem.setItemBrevitycode(pinyin4j.toPinYinLowercase(ItemDesc)); //设置简码根据名称自动生成
			super.save(erpItem);
		} catch (BadHanyuPinyinOutputFormatCombination e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	@Transactional(readOnly = false)
	public void delete(ErpItem erpItem) {
		super.delete(erpItem);
	}
	
	//项目代码唯一性校验
	public ErpItem getItemNo(String itemNo) {
		return erpItemDao.getErpItemByItemNo(itemNo);
	}
	
	//项目唯一性校验
	public ErpItem getItemDesc(String itemDesc) {
		return erpItemDao.getErpItemByItemDesc(itemDesc);
	}
	
}