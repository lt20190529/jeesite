package com.thinkgem.jeesite.modules.erpStock.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.modules.erpStock.dao.StockMangerDao;
import com.thinkgem.jeesite.modules.erpStock.entity.ErpStock;


@Service
@Transactional
public class StockMangerService {

	@Autowired
	private StockMangerDao stockMangerDao;
	
	public List<ErpStock> findDepStockByfilter(Map<String,Object> map) {
		return stockMangerDao.findDepStockByfilter(map);
	}
	
	public  Integer findDepStockByfilterCount(Map<String,Object> map){
		return stockMangerDao.findDepStockByfilterCount(map);
	};
}
