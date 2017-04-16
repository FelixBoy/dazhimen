package dazhimen.bg.controller;

import com.google.gson.Gson;
import dazhimen.bg.bean.IndexPlayBean;
import dazhimen.bg.bean.indexsort.NewsIndexSortBean;
import dazhimen.bg.bean.indexsort.ProductIndexSortBean;
import dazhimen.bg.exception.BgException;
import dazhimen.bg.service.PlaySortService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import util.Constant;
import util.web.ResponseUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Created by Administrator on 2017/4/1.
 */
@Controller
@RequestMapping("/playsort")
public class PlaySortController {

    @RequestMapping("/forwardAddSkillPackIndexSortPage")
    public String forwardAddProductIndexSortPage(){
        return "/playsort/addSkillPackIndexSort";
    }
    @RequestMapping("/getAddSkillPackIndexSortData")
    public void getAddSkillPackIndexSortData(HttpServletResponse resp){
        PlaySortService playSortService = new PlaySortService();
        try {
            List<ProductIndexSortBean> productBeans = playSortService.getAddSkillPackIndexSortData();
            ResponseUtil.writeMsg(resp, new Gson().toJson(productBeans));
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp ,"出现异常，查询新增技能包首页排序数据出错");
        }
    }

    @RequestMapping("/saveAddSkillPackIndexSort")
    public void saveAddSkillPackIndexSort(@RequestParam("pid") String pid,HttpServletResponse resp){
        PlaySortService playSortService = new PlaySortService();
        try{
            boolean result = playSortService.saveAddSkillPackIndexSort(pid);
            if(result){
                ResponseUtil.writeMsg(resp,"新增技能包首页排序成功");
            }else{
                ResponseUtil.writeFailMsgToBrowse(resp, "新增技能包首页排序失败");
            }
        }catch (Exception e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，新增技能包首页排序出错");
        }
    }
    @RequestMapping("/clearSkillPackIndexSort")
    public void clearSkillPackIndexSort(HttpServletResponse resp){
        PlaySortService playSortService = new PlaySortService();
        try {
            playSortService.clearSkillPackIndexSort();
            ResponseUtil.writeMsg(resp, "清空技能包首页排序成功");
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }
    }
    @RequestMapping("/queryAllSkillPackIndexSort")
    public void queryAllSkillPackIndexSort(HttpServletResponse resp){
        PlaySortService playSortService = new PlaySortService();
        try {
            List<ProductIndexSortBean> productBeans = playSortService.queryAllSkillPackIndexSort();
            ResponseUtil.writeMsg(resp, new Gson().toJson(productBeans));
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，查询技能包首页排序信息失败");
        }
    }

    @RequestMapping("/queryAllExperiencePackIndexSort")
    public void queryAllExperiencePackIndexSort(HttpServletResponse resp){
        PlaySortService playSortService = new PlaySortService();
        try {
            List<ProductIndexSortBean> productBeans = playSortService.queryAllExperiencePackIndexSort();
            ResponseUtil.writeMsg(resp, new Gson().toJson(productBeans));
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，查询经验包首页排序信息失败");
        }
    }
    @RequestMapping("/forwardAddExperiencePackIndexSortPage")
    public String forwardAddExperiencePackIndexSortPage(){
        return "/playsort/addExperiencePackIndexSort";
    }

    @RequestMapping("/getAddExperiencePackIndexSortData")
    public void getAddExperiencePackIndexSortData(HttpServletResponse resp){
        PlaySortService playSortService = new PlaySortService();
        try {
            List<ProductIndexSortBean> productBeans = playSortService.getAddExperiencePackIndexSortData();
            ResponseUtil.writeMsg(resp, new Gson().toJson(productBeans));
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp ,"出现异常，查询新增经验包首页排序数据出错");
        }
    }
    @RequestMapping("/saveAddExperiencePackIndexSort")
    public void saveAddExperiencePackIndexSort(@RequestParam("pid") String pid,HttpServletResponse resp){
        PlaySortService playSortService = new PlaySortService();
        try{
            boolean result = playSortService.saveAddExperiencePackIndexSort(pid);
            if(result){
                ResponseUtil.writeMsg(resp,"新增经验包首页排序成功");
            }else{
                ResponseUtil.writeFailMsgToBrowse(resp, "新增经验包首页排序失败");
            }
        }catch (Exception e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，新增经验包首页排序出错");
        }
    }
    @RequestMapping("/clearExperiencePackIndexSort")
    public void clearExperiencePackIndexSort(HttpServletResponse resp){
        PlaySortService playSortService = new PlaySortService();
        try {
            playSortService.clearExperiencePackIndexSort();
            ResponseUtil.writeMsg(resp, "清空经验包首页排序成功");
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }
    }

    @RequestMapping("/queryAllNewsIndexSort")
    public void queryAllNewsIndexSort(HttpServletResponse resp){
        PlaySortService playSortService = new PlaySortService();
        try {
            List<NewsIndexSortBean> newsBeans = playSortService.queryAllNewsIndexSort();
            ResponseUtil.writeMsg(resp, new Gson().toJson(newsBeans));
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，查询新闻首页排序信息失败");
        }
    }

    @RequestMapping("/forwardAddNewsIndexSortPage")
    public String forwardAddNewsIndexSortPage(){
        return "/playsort/addNewsIndexSort";
    }
    @RequestMapping("/getAddNewsIndexSortData")
    public void getAddNewsIndexSortData(HttpServletResponse resp){
        PlaySortService playSortService = new PlaySortService();
        try {
            List<NewsIndexSortBean> newsBeans = playSortService.getAddNewsIndexSortData();
            ResponseUtil.writeMsg(resp, new Gson().toJson(newsBeans));
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp ,"出现异常，查询新增新闻首页排序数据出错");
        }
    }

    @RequestMapping("/saveAddNewsIndexSort")
    public void saveAddNewsIndexSort(@RequestParam("nid") String nid,HttpServletResponse resp){
        PlaySortService playSortService = new PlaySortService();
        try{
            boolean result = playSortService.saveAddNewsIndexSort(nid);
            if(result){
                ResponseUtil.writeMsg(resp,"新增新闻首页排序成功");
            }else{
                ResponseUtil.writeFailMsgToBrowse(resp, "新增新闻首页排序失败");
            }
        }catch (Exception e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，新增新闻首页排序出错");
        }
    }

    @RequestMapping("/clearNewsIndexSort")
    public void clearNewsIndexSort(HttpServletResponse resp){
        PlaySortService playSortService = new PlaySortService();
        try {
            playSortService.clearNewsIndexSort();
            ResponseUtil.writeMsg(resp, "清空新闻首页排序成功");
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }
    }
    @RequestMapping("/fwdIndexPlayManagePage")
    public String fwdIndexPlayManagePage(){
        return "/playsort/manageIndexPlay";
    }
    @RequestMapping("/queryAllIndexPlay")
    public void queryAllIndexPlay(HttpServletResponse resp){
        PlaySortService playSortService = new PlaySortService();
        try {
            List<IndexPlayBean> indexPlayBeans = playSortService.queryAllIndexPlay();
            ResponseUtil.writeMsg(resp, new Gson().toJson(indexPlayBeans));
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，查询首页轮播信息失败");
        }
    }
    @RequestMapping("/fwdAddIndexPlayPage")
    public String fwdAddIndexPlayPage(){
        return "/playsort/addIndexPlay";
    }

    @RequestMapping("/getAddIndexPlayData")
    public void getAddIndexPlayData(HttpServletResponse resp){
        PlaySortService playSortService = new PlaySortService();
        try {
            List<IndexPlayBean> indexPlayBeans = playSortService.getAddIndexPlayData();
            ResponseUtil.writeMsg(resp, new Gson().toJson(indexPlayBeans));
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，查询新增轮播数据出错");
        }
    }
    @RequestMapping("/saveAddIndexPlay")
    public void saveAddIndexPlay(@RequestParam("pid") String pid,HttpServletResponse resp){
        PlaySortService playSortService = new PlaySortService();
        try{
            boolean result = playSortService.saveAddIndexPlay(pid);
            if(result){
                ResponseUtil.writeMsg(resp, "新增轮播成功");
            }else{
                ResponseUtil.writeFailMsgToBrowse(resp, "新增轮播失败");
            }
        }catch (Exception e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，新增轮播数据出错");
        }
    }
    @RequestMapping("/saveDeleteIndexPlay")
    public void saveDeleteIndexPlay(@RequestParam("pid") String pid,HttpServletResponse resp){
        PlaySortService playSortService = new PlaySortService();
        try{
            boolean result = playSortService.saveDeleteIndexPlay(pid);
            if(result){
                ResponseUtil.writeMsg(resp, "取消轮播成功");
            }else{
                ResponseUtil.writeFailMsgToBrowse(resp, "取消轮播失败");
            }
        }catch (Exception e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，取消轮播数据出错");
        }
    }
    @RequestMapping("/fwdIndexSortManagePage")
    public String fwdIndexSortManagePage(){
        return "/playsort/manageIndexSort";
    }
}
