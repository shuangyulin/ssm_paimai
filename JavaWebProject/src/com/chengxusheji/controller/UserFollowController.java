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
import com.chengxusheji.service.UserFollowService;
import com.chengxusheji.po.UserFollow;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//UserFollow管理控制层
@Controller
@RequestMapping("/UserFollow")
public class UserFollowController extends BaseController {

    /*业务层对象*/
    @Resource UserFollowService userFollowService;

    @Resource UserInfoService userInfoService;
	@InitBinder("userObj1")
	public void initBinderuserObj1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj1.");
	}
	@InitBinder("userObj2")
	public void initBinderuserObj2(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj2.");
	}
	@InitBinder("userFollow")
	public void initBinderUserFollow(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userFollow.");
	}
	/*跳转到添加UserFollow视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new UserFollow());
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "UserFollow_add";
	}

	/*客户端ajax方式提交添加用户关注信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated UserFollow userFollow, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        userFollowService.addUserFollow(userFollow);
        message = "用户关注添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询用户关注信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("userObj1") UserInfo userObj1,@ModelAttribute("userObj2") UserInfo userObj2,String followTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (followTime == null) followTime = "";
		if(rows != 0)userFollowService.setRows(rows);
		List<UserFollow> userFollowList = userFollowService.queryUserFollow(userObj1, userObj2, followTime, page);
	    /*计算总的页数和总的记录数*/
	    userFollowService.queryTotalPageAndRecordNumber(userObj1, userObj2, followTime);
	    /*获取到总的页码数目*/
	    int totalPage = userFollowService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = userFollowService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(UserFollow userFollow:userFollowList) {
			JSONObject jsonUserFollow = userFollow.getJsonObject();
			jsonArray.put(jsonUserFollow);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询用户关注信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<UserFollow> userFollowList = userFollowService.queryAllUserFollow();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(UserFollow userFollow:userFollowList) {
			JSONObject jsonUserFollow = new JSONObject();
			jsonUserFollow.accumulate("followId", userFollow.getFollowId());
			jsonArray.put(jsonUserFollow);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询用户关注信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("userObj1") UserInfo userObj1,@ModelAttribute("userObj2") UserInfo userObj2,String followTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (followTime == null) followTime = "";
		List<UserFollow> userFollowList = userFollowService.queryUserFollow(userObj1, userObj2, followTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    userFollowService.queryTotalPageAndRecordNumber(userObj1, userObj2, followTime);
	    /*获取到总的页码数目*/
	    int totalPage = userFollowService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = userFollowService.getRecordNumber();
	    request.setAttribute("userFollowList",  userFollowList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("userObj1", userObj1);
	    request.setAttribute("userObj2", userObj2);
	    request.setAttribute("followTime", followTime);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "UserFollow/userFollow_frontquery_result"; 
	}

     /*前台查询UserFollow信息*/
	@RequestMapping(value="/{followId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer followId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键followId获取UserFollow对象*/
        UserFollow userFollow = userFollowService.getUserFollow(followId);

        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("userFollow",  userFollow);
        return "UserFollow/userFollow_frontshow";
	}

	/*ajax方式显示用户关注修改jsp视图页*/
	@RequestMapping(value="/{followId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer followId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键followId获取UserFollow对象*/
        UserFollow userFollow = userFollowService.getUserFollow(followId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonUserFollow = userFollow.getJsonObject();
		out.println(jsonUserFollow.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新用户关注信息*/
	@RequestMapping(value = "/{followId}/update", method = RequestMethod.POST)
	public void update(@Validated UserFollow userFollow, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			userFollowService.updateUserFollow(userFollow);
			message = "用户关注更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "用户关注更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除用户关注信息*/
	@RequestMapping(value="/{followId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer followId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  userFollowService.deleteUserFollow(followId);
	            request.setAttribute("message", "用户关注删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "用户关注删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条用户关注记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String followIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = userFollowService.deleteUserFollows(followIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出用户关注信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("userObj1") UserInfo userObj1,@ModelAttribute("userObj2") UserInfo userObj2,String followTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(followTime == null) followTime = "";
        List<UserFollow> userFollowList = userFollowService.queryUserFollow(userObj1,userObj2,followTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "UserFollow信息记录"; 
        String[] headers = { "记录id","被关注人","关注人","关注时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<userFollowList.size();i++) {
        	UserFollow userFollow = userFollowList.get(i); 
        	dataset.add(new String[]{userFollow.getFollowId() + "",userFollow.getUserObj1().getName(),userFollow.getUserObj2().getName(),userFollow.getFollowTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"UserFollow.xls");//filename是下载的xls的名，建议最好用英文 
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
