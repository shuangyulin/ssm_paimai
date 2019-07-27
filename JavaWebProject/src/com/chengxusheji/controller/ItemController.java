package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.ItemService;
import com.chengxusheji.po.Item;
import com.chengxusheji.service.ItemClassService;
import com.chengxusheji.po.ItemClass;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//Item管理控制层
@Controller
@RequestMapping("/Item")
public class ItemController extends BaseController {

    /*业务层对象*/
    @Resource ItemService itemService;

    @Resource ItemClassService itemClassService;
    @Resource UserInfoService userInfoService;
	@InitBinder("itemClassObj")
	public void initBinderitemClassObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("itemClassObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("item")
	public void initBinderItem(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("item.");
	}
	/*跳转到添加Item视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Item());
		/*查询所有的ItemClass信息*/
		List<ItemClass> itemClassList = itemClassService.queryAllItemClass();
		request.setAttribute("itemClassList", itemClassList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "Item_add";
	}

	/*客户端ajax方式提交添加商品信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Item item, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			item.setItemPhoto(this.handlePhotoUpload(request, "itemPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        itemService.addItem(item);
        message = "商品添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询商品信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("itemClassObj") ItemClass itemClassObj,String pTitle,@ModelAttribute("userObj") UserInfo userObj,String startTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (pTitle == null) pTitle = "";
		if (startTime == null) startTime = "";
		if(rows != 0)itemService.setRows(rows);
		List<Item> itemList = itemService.queryItem(itemClassObj, pTitle, userObj, startTime, page);
	    /*计算总的页数和总的记录数*/
	    itemService.queryTotalPageAndRecordNumber(itemClassObj, pTitle, userObj, startTime);
	    /*获取到总的页码数目*/
	    int totalPage = itemService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = itemService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Item item:itemList) {
			JSONObject jsonItem = item.getJsonObject();
			jsonArray.put(jsonItem);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询商品信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Item> itemList = itemService.queryAllItem();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Item item:itemList) {
			JSONObject jsonItem = new JSONObject();
			jsonItem.accumulate("itemId", item.getItemId());
			jsonItem.accumulate("pTitle", item.getPTitle());
			jsonArray.put(jsonItem);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询商品信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("itemClassObj") ItemClass itemClassObj,String pTitle,@ModelAttribute("userObj") UserInfo userObj,String startTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (pTitle == null) pTitle = "";
		if (startTime == null) startTime = "";
		List<Item> itemList = itemService.queryItem(itemClassObj, pTitle, userObj, startTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    itemService.queryTotalPageAndRecordNumber(itemClassObj, pTitle, userObj, startTime);
	    /*获取到总的页码数目*/
	    int totalPage = itemService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = itemService.getRecordNumber();
	    request.setAttribute("itemList",  itemList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("itemClassObj", itemClassObj);
	    request.setAttribute("pTitle", pTitle);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("startTime", startTime);
	    List<ItemClass> itemClassList = itemClassService.queryAllItemClass();
	    request.setAttribute("itemClassList", itemClassList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Item/item_frontquery_result"; 
	}

     /*前台查询Item信息*/
	@RequestMapping(value="/{itemId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer itemId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键itemId获取Item对象*/
        Item item = itemService.getItem(itemId);

        List<ItemClass> itemClassList = itemClassService.queryAllItemClass();
        request.setAttribute("itemClassList", itemClassList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("item",  item);
        return "Item/item_frontshow";
	}

	/*ajax方式显示商品修改jsp视图页*/
	@RequestMapping(value="/{itemId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer itemId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键itemId获取Item对象*/
        Item item = itemService.getItem(itemId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonItem = item.getJsonObject();
		out.println(jsonItem.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新商品信息*/
	@RequestMapping(value = "/{itemId}/update", method = RequestMethod.POST)
	public void update(@Validated Item item, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String itemPhotoFileName = this.handlePhotoUpload(request, "itemPhotoFile");
		if(!itemPhotoFileName.equals("upload/NoImage.jpg"))item.setItemPhoto(itemPhotoFileName); 


		try {
			itemService.updateItem(item);
			message = "商品更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "商品更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除商品信息*/
	@RequestMapping(value="/{itemId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer itemId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  itemService.deleteItem(itemId);
	            request.setAttribute("message", "商品删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "商品删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条商品记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String itemIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = itemService.deleteItems(itemIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出商品信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("itemClassObj") ItemClass itemClassObj,String pTitle,@ModelAttribute("userObj") UserInfo userObj,String startTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(pTitle == null) pTitle = "";
        if(startTime == null) startTime = "";
        List<Item> itemList = itemService.queryItem(itemClassObj,pTitle,userObj,startTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Item信息记录"; 
        String[] headers = { "商品分类","商品标题","商品图片","发布人","起拍价","起拍时间","结束时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<itemList.size();i++) {
        	Item item = itemList.get(i); 
        	dataset.add(new String[]{item.getItemClassObj().getClassName(),item.getPTitle(),item.getItemPhoto(),item.getUserObj().getName(),item.getStartPrice() + "",item.getStartTime(),item.getEndTime()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Item.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
