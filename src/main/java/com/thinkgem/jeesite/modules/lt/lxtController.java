package com.thinkgem.jeesite.modules.lt;

import java.io.File;
import java.util.*;

import com.thinkgem.jeesite.modules.sys.entity.User;
import org.apache.commons.collections.MultiMap;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.erpuom.entity.ErpUom;
import com.thinkgem.jeesite.modules.erpuom.service.ErpUomService;
import com.thinkgem.jeesite.modules.item.entity.ErpItem;
import com.thinkgem.jeesite.modules.item.service.ErpItemService;
import com.thinkgem.jeesite.modules.rec.service.ErpRecService;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


/**
 * 入库Controller
 * @author lxt
 * @version 2018-07-26
 */
@Controller
@RequestMapping(value = "${adminPath}/lxt/test")
public class lxtController extends BaseController {

	@Autowired
	private ErpItemService erpItemService;
	
	@Autowired
	private ErpUomService erpUomService;
	
	@RequiresPermissions("lxt:test:view")
	@RequestMapping(value = {"list", ""})
	public String list(Model model) {
		return "modules/lxt/test";
	}

	@RequiresPermissions("lxt:test:edit")
	@RequestMapping(value = "form")
	public String form(Model model) {
		return "modules/lxt/test";
	}
	
	// 测试数据
	@RequestMapping("/getListnew")
	@ResponseBody
	public Map<String, Object> getListnew() {	
        List<ErpItem> items = new ArrayList<ErpItem>();
        ErpItem item = new ErpItem();
        items=erpItemService.findErpItemList(item);
        Map<String,Object> jsonMap = new HashMap<String,Object>(); 
        jsonMap.put("rows",items);
        jsonMap.put("total",items.size());
        return jsonMap;
	}

	//使用CookValue绑定请求的cookie值
	@RequestMapping(value="/requiredCookie")
	@ResponseBody
	public String handlerRequiredCookie(@CookieValue(value = "jeesite.session.id",required = false) String sessionId,
										@RequestHeader(value="Accept-Encoding",required = false)String AcceptEncoding ){
		System.out.println(sessionId);
		System.out.println(AcceptEncoding);

		return "success";
	}
	//
	@RequestMapping(value="/session")
	@ResponseBody
	public String Session(HttpSession session, WebRequest webRequest){
		session.setAttribute("name","lxt");
		System.out.println(session.getAttribute("name"));
		System.out.println(webRequest.getParameter("uername"));
		return "success";
	}


	@RequestMapping(value="/photoUpload",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> test(MultipartFile photo, HttpServletRequest request){
		Map<String, String> ret = new HashMap<String, String>();
		if (photo == null) {
			ret.put("type", "error");
			ret.put("msg", "选择要上传的文件！");
			return ret;
		}
		if (photo.getSize() > 1024 * 1024 * 10) {
			ret.put("type", "error");
			ret.put("msg", "文件大小不能超过10M！");
			return ret;
		}
		//获取文件后缀
		String suffix = photo.getOriginalFilename().substring(photo.getOriginalFilename().lastIndexOf(".") + 1, photo.getOriginalFilename().length());
		if (!"jpg,jpeg,gif,png".toUpperCase().contains(suffix.toUpperCase())) {
			ret.put("type", "error");
			ret.put("msg", "请选择jpg,jpeg,gif,png格式的图片！");
			return ret;
		}
		//获取项目根目录加上图片目录 webapp/static/imgages/upload/
		String savePath = request.getSession().getServletContext().getRealPath("/") + "\\static\\images\\";
		File savePathFile = new File(savePath);
		if (!savePathFile.exists()) {
			//若不存在该目录，则创建目录
			savePathFile.mkdir();
		}
		String filename = new Date().getTime() + "." + suffix;
		try {
			//将文件保存指定目录
			photo.transferTo(new File(savePath + filename));
		} catch (Exception e) {
			ret.put("type", "error");
			ret.put("msg", "保存文件异常！");
			e.printStackTrace();
			return ret;
		}
		System.out.println("图片上传。。。");
		ret.put("type", "success");
		ret.put("msg", "falil");
		ret.put("filepath", request.getSession().getServletContext().getContextPath() + "/static/images/");
		ret.put("filename", filename);
		return ret;
	}


}
