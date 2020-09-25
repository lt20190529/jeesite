package com.thinkgem.jeesite.modules.rec.web;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.repeatformvalidator.SameUrlData;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.erpdepartments.entity.ErpDepartments;
import com.thinkgem.jeesite.modules.erpdepartments.service.ErpDepartmentsSerivce;
import com.thinkgem.jeesite.modules.erpvendor.entity.ErpVendor;
import com.thinkgem.jeesite.modules.erpvendor.service.ErpVendorService;
import com.thinkgem.jeesite.modules.item.entity.ErpItem;
import com.thinkgem.jeesite.modules.item.service.ErpItemService;
import com.thinkgem.jeesite.modules.rec.entity.ErpRec;
import com.thinkgem.jeesite.modules.rec.entity.ErpRecDetail;
import com.thinkgem.jeesite.modules.rec.service.ErpRecQueryService;
import com.thinkgem.jeesite.modules.rec.service.ErpRecService;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.util.*;

/**
 * 入库Controller
 *
 * @author lxt
 * @version 2018-07-26
 */
@Controller
@RequestMapping(value = "${adminPath}/rec/erpRec")
public class ErpRecController extends BaseController {

    @Autowired
    private ErpRecService erpRecService;

    @Autowired
    private ErpRecQueryService erpRecQueryService;

    @Autowired
    private ErpItemService erpItemService;

    @Autowired
    private ErpDepartmentsSerivce erpDepartmentsSerivce;

    @Autowired
    private ErpVendorService erpVendorService;

    // **********************************************入库列表****************************************************
    // @ModelAttribute 注解的方法会在Controller每个方法执行之前都执行
    //required：是否为必需的，默认为true，表示请求中必须包含对应的参数名，如果不存在就抛出异常
    //defaultValue：默认参数名，设置该参数时，自动将required设为false。极少情况需要使用该参数，也不推荐使用该参数
    @ModelAttribute
    public ErpRec get(@RequestParam(required = false) String id) {
        ErpRec erpRec = null;
        if (StringUtils.isNotBlank(id)) {
            erpRec = erpRecService.get(id);
        }
        if (erpRec == null) {
            erpRec = new ErpRec();
        }
        return erpRec;
    }
    // 单据编号

    @RequestMapping(value = "GetMaxNo")
    @ResponseBody
    public Map<String, Object> GetMaxNo(String id) {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        Map<String, Object> m = new HashMap<String, Object>();
        m.put("prefix", "REC");
        m.put("num", 8);
        m.put("OrderNo", "");
        erpRecService.GetMaxNo(m);
        resultMap.put("result", m.get("OrderNo"));
        return resultMap;
    }

    // 跳转到入库制单
    @RequiresPermissions("rec:erpRec:view")
    @RequestMapping(value = "form")
    @SameUrlData(save = true)
    public String form(ErpRec erpRec, Model model) {
        model.addAttribute("erpRec", erpRec);
        model.addAttribute("erpRecDetaillist", erpRec.getErpRecDetailList());
        ErpVendor erpVendor = new ErpVendor();
        List<ErpVendor> erpVendorlist = erpVendorService.findList(erpVendor);
        model.addAttribute("erpVendorlist", erpVendorlist);
        ErpDepartments erpDepartments = new ErpDepartments();
        List<ErpDepartments> erpDepartmentslist = erpDepartmentsSerivce
                .findList(erpDepartments);
        model.addAttribute("erpDepartmentslist", erpDepartmentslist);
        return "modules/rec/erpRecForm";
    }

    // 提交保存
    @RequestMapping("Save")
    @ResponseBody
    @SameUrlData(remove = true)
    public String Save(@RequestBody ErpRec erpRec) {
        erpRecService.save(erpRec);
        return "success";
    }

    //项目检索列表
    @RequestMapping("/getItemList")
    @ResponseBody
    public Map<String, Object> getItemList(String input, int pageNumber, int pageSize) {
        List<ErpItem> items = new ArrayList<ErpItem>();
        Map<String, Object> params = new LinkedHashMap<String, Object>();
        params.put("input", "%" + input + "%");                          //当sql的条件有模糊匹配时，参数需前后带上%
        params.put("start", (pageNumber - 1) * pageSize);
        params.put("pagesize", pageSize);
        items = erpItemService.findErpItemListBy(params);
        Integer total = erpItemService.getErpItemBybrevitycodeCount(params);
        Map<String, Object> jsonMap = new HashMap<String, Object>();
        jsonMap.put("rows", items);
        jsonMap.put("total", total);
        return jsonMap;
    }

    /*
    删除已保存明细记录
     */
    @RequestMapping("Delete/{id}")
    @ResponseBody
    public String deleteDetail(@PathVariable("id") String id) {
        erpRecService.deleteDetail(id);
        return "success";
    }

    // **********************************查询页签**********************************
    @RequiresPermissions("rec:erpRec:Query")
    @RequestMapping(value = "erpRecQuery")
    public String erpRecQuery(ErpRec erpRec, Model model,
                              HttpServletRequest request, HttpServletResponse response) throws BadHanyuPinyinOutputFormatCombination {
        ErpVendor erpVendor = new ErpVendor();
        List<ErpVendor> erpVendorlist = erpVendorService.findList(erpVendor);
        model.addAttribute("erpVendorlist", erpVendorlist);
        ErpDepartments erpDepartments = new ErpDepartments();
        List<ErpDepartments> erpDepartmentslist = erpDepartmentsSerivce
                .findList(erpDepartments);
        model.addAttribute("erpDepartmentslist", erpDepartmentslist);
        return "modules/rec/erpRecQuery";

    }

    // 入库列表查询
    @RequiresPermissions("rec:erpRec:view")
    @RequestMapping(value = "list")
    public String list(ErpRec erpRec, HttpServletRequest request,
                       HttpServletResponse response, Model model) {
        Page<ErpRec> page = erpRecService.findPage(new Page<ErpRec>(
                request, response), erpRec);
        model.addAttribute("page", page);
        return "modules/rec/erpRecList";
    }

    // 入库删除
    @RequiresPermissions("rec:erpRec:edit")
    @RequestMapping(value = "delete")
    public String delete(ErpRec erpRec,RedirectAttributes redirectAttributes,HttpServletRequest request,
                         HttpServletResponse response, Model model) {
        erpRecService.delete(erpRec);
        addMessage(redirectAttributes, "删除入库成功");
        Page<ErpRec> page = erpRecService.findPage(new Page<ErpRec>(
                request, response), erpRec);
        model.addAttribute("page", page);
        return "modules/rec/erpRecList"; //"redirect:" + Global.getAdminPath() + "/rec/erpRec/?repage";
    }

    // 入库审核
    @RequiresPermissions("rec:erpRec:Audit")
    @RequestMapping(value = "erpRecAudit")
    @ResponseBody
    public Map<String, Object> erpRecAudit(String id, RedirectAttributes redirectAttributes) {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        Map<String, Object> m = new HashMap<String, Object>();
        m.put("rid", id);
        m.put("audituser", "1");
        m.put("msg", "-1");
        erpRecService.AuditRecById(m);
        resultMap.put("result", m.get("msg"));
        addMessage(redirectAttributes, m.get("msg").toString());
        return resultMap;
    }

    // 查询入库主信息 加载主信息
    @RequestMapping("getrecMainList")
    @ResponseBody
    public Map<String, Object> getrecMainList(String no, String depid, String vendorid, HttpServletRequest request,
                                              int page, int rows, HttpServletResponse response) throws UnsupportedEncodingException {
        int start = (page - 1) * rows;
        Map<String, Object> params = new LinkedHashMap<String, Object>();
        params.put("no", no);       //当sql的条件有模糊匹配时，参数需前后带上%
        params.put("depid", depid);
        params.put("vendorid", vendorid);
        params.put("start", start);
        params.put("pagesize", rows);
        List<ErpRec> list = erpRecQueryService.findErpMainByfilter(params);
        Integer total = erpRecQueryService.findErpMainByfilterCount(params);
        Map<String, Object> jsonMap = new HashMap<String, Object>();
        jsonMap.put("rows", list);
        jsonMap.put("total", total);
        return jsonMap;
    }

    /**
     * 导出入库主记录信息
     */
    @RequiresPermissions("rec:erpRec:edit")
    @RequestMapping(value = "export", method = RequestMethod.POST)
    public String exportFile(ErpRec erpRec, HttpServletRequest request,
                             HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String fileName = "入库数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
            Page<ErpRec> page = erpRecService.findPage(new Page<ErpRec>(request, response, -1), erpRec);
            new ExportExcel("入库数据", ErpRec.class).setDataList(page.getList()).write(response, fileName).dispose();
            return null;
        } catch (Exception e) {
            addMessage(redirectAttributes, "导出入库信息失败！失败信息：" + e.getMessage());
        }
        return "redirect:" + adminPath + "/rec/erpRec/?repage";
    }

    // 加载 明细信息
    @RequestMapping("getListjqGridDetail")
    @ResponseBody
    public Map<String, Object> getListjqGridDetail(@RequestParam("ids") String ids) {
        List<ErpRecDetail> list = new ArrayList<ErpRecDetail>(); // 数据库 获取数据
        list = erpRecQueryService.finderpRecDetail(ids);
        Map<String, Object> jsonMap = new HashMap<String, Object>();
        jsonMap.put("rows", list);
        jsonMap.put("total", list.size());
        return jsonMap;
    }


    // **********************************入库报表页签**********************************
    @RequiresPermissions("rec:erpRec:Report")
    @RequestMapping(value = "erpRecReport")
    public String erpRecReport(ErpRec erpRec, Model model,
                               HttpServletRequest request, HttpServletResponse response) {
        return "modules/rec/erpRecReport";
    }
}