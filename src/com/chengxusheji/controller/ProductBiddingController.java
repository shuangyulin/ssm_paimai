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
import com.chengxusheji.service.ProductBiddingService;
import com.chengxusheji.po.ProductBidding;
import com.chengxusheji.service.ItemService;
import com.chengxusheji.po.Item;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//ProductBidding管理控制层
@Controller
@RequestMapping("/ProductBidding")
public class ProductBiddingController extends BaseController {

    /*业务层对象*/
    @Resource ProductBiddingService productBiddingService;

    @Resource ItemService itemService;
    @Resource UserInfoService userInfoService;
	@InitBinder("itemObj")
	public void initBinderitemObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("itemObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("productBidding")
	public void initBinderProductBidding(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("productBidding.");
	}
	/*跳转到添加ProductBidding视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new ProductBidding());
		/*查询所有的Item信息*/
		List<Item> itemList = itemService.queryAllItem();
		request.setAttribute("itemList", itemList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "ProductBidding_add";
	}

	/*客户端ajax方式提交添加竞拍订单信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated ProductBidding productBidding, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        productBiddingService.addProductBidding(productBidding);
        message = "竞拍订单添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询竞拍订单信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("itemObj") Item itemObj,@ModelAttribute("userObj") UserInfo userObj,String biddingTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (biddingTime == null) biddingTime = "";
		if(rows != 0)productBiddingService.setRows(rows);
		List<ProductBidding> productBiddingList = productBiddingService.queryProductBidding(itemObj, userObj, biddingTime, page);
	    /*计算总的页数和总的记录数*/
	    productBiddingService.queryTotalPageAndRecordNumber(itemObj, userObj, biddingTime);
	    /*获取到总的页码数目*/
	    int totalPage = productBiddingService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = productBiddingService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(ProductBidding productBidding:productBiddingList) {
			JSONObject jsonProductBidding = productBidding.getJsonObject();
			jsonArray.put(jsonProductBidding);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询竞拍订单信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<ProductBidding> productBiddingList = productBiddingService.queryAllProductBidding();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(ProductBidding productBidding:productBiddingList) {
			JSONObject jsonProductBidding = new JSONObject();
			jsonProductBidding.accumulate("biddingId", productBidding.getBiddingId());
			jsonArray.put(jsonProductBidding);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询竞拍订单信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("itemObj") Item itemObj,@ModelAttribute("userObj") UserInfo userObj,String biddingTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (biddingTime == null) biddingTime = "";
		List<ProductBidding> productBiddingList = productBiddingService.queryProductBidding(itemObj, userObj, biddingTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    productBiddingService.queryTotalPageAndRecordNumber(itemObj, userObj, biddingTime);
	    /*获取到总的页码数目*/
	    int totalPage = productBiddingService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = productBiddingService.getRecordNumber();
	    request.setAttribute("productBiddingList",  productBiddingList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("itemObj", itemObj);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("biddingTime", biddingTime);
	    List<Item> itemList = itemService.queryAllItem();
	    request.setAttribute("itemList", itemList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "ProductBidding/productBidding_frontquery_result"; 
	}

     /*前台查询ProductBidding信息*/
	@RequestMapping(value="/{biddingId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer biddingId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键biddingId获取ProductBidding对象*/
        ProductBidding productBidding = productBiddingService.getProductBidding(biddingId);

        List<Item> itemList = itemService.queryAllItem();
        request.setAttribute("itemList", itemList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("productBidding",  productBidding);
        return "ProductBidding/productBidding_frontshow";
	}

	/*ajax方式显示竞拍订单修改jsp视图页*/
	@RequestMapping(value="/{biddingId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer biddingId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键biddingId获取ProductBidding对象*/
        ProductBidding productBidding = productBiddingService.getProductBidding(biddingId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonProductBidding = productBidding.getJsonObject();
		out.println(jsonProductBidding.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新竞拍订单信息*/
	@RequestMapping(value = "/{biddingId}/update", method = RequestMethod.POST)
	public void update(@Validated ProductBidding productBidding, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			productBiddingService.updateProductBidding(productBidding);
			message = "竞拍订单更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "竞拍订单更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除竞拍订单信息*/
	@RequestMapping(value="/{biddingId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer biddingId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  productBiddingService.deleteProductBidding(biddingId);
	            request.setAttribute("message", "竞拍订单删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "竞拍订单删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条竞拍订单记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String biddingIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = productBiddingService.deleteProductBiddings(biddingIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出竞拍订单信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("itemObj") Item itemObj,@ModelAttribute("userObj") UserInfo userObj,String biddingTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(biddingTime == null) biddingTime = "";
        List<ProductBidding> productBiddingList = productBiddingService.queryProductBidding(itemObj,userObj,biddingTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "ProductBidding信息记录"; 
        String[] headers = { "订单编号","竞拍商品","竞拍用户","竞拍时间","竞拍出价"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<productBiddingList.size();i++) {
        	ProductBidding productBidding = productBiddingList.get(i); 
        	dataset.add(new String[]{productBidding.getBiddingId() + "",productBidding.getItemObj().getPTitle(),productBidding.getUserObj().getName(),productBidding.getBiddingTime(),productBidding.getBiddingPrice() + ""});
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
			response.setHeader("Content-disposition","attachment; filename="+"ProductBidding.xls");//filename是下载的xls的名，建议最好用英文 
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
