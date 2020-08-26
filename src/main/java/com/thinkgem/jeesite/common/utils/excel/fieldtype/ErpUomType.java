package com.thinkgem.jeesite.common.utils.excel.fieldtype;

import com.thinkgem.jeesite.common.utils.SpringContextHolder;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.erpuom.entity.ErpUom;
import com.thinkgem.jeesite.modules.erpuom.service.ErpUomService;
import com.thinkgem.jeesite.modules.sys.entity.Area;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

public class ErpUomType {

    private static ErpUomService erpUomService = SpringContextHolder.getBean(ErpUomService.class);
    /**
     * 获取对象值（导入）
     */
    public static Object getValue(String val) {
        for (ErpUom e : erpUomService.findList(new ErpUom())){
            if (StringUtils.trimToEmpty(val).equals(e.getErpUomdesc())){
                return e;
            }
        }
        return null;
    }

    /**
     * 获取对象值（导出）
     */
    public static String setValue(Object val) {
        if (val != null && ((ErpUom)val).getErpUomdesc() != null){
            return ((ErpUom)val).getErpUomdesc();
        }
        return "";
    }
}
