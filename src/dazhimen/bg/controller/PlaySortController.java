package dazhimen.bg.controller;

import com.google.gson.Gson;
import dazhimen.bg.bean.playsort.IndexPlayBean;
import dazhimen.bg.bean.playsort.MasterIndexSortBean;
import dazhimen.bg.bean.playsort.NewsIndexSortBean;
import dazhimen.bg.bean.playsort.ProductIndexSortBean;
import dazhimen.bg.exception.BgException;
import dazhimen.bg.service.PlaySortService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import util.web.ResponseUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by Administrator on 2017/4/1.
 */
@Controller
@RequestMapping("/playsort")
public class PlaySortController {

    @RequestMapping("/forwardAddSkillPackIndexSortPage.do")
    public String forwardAddProductIndexSortPage(){
        return "/playsort/addSkillPackIndexSort";
    }
    @RequestMapping("/getAddSkillPackIndexSortData.do")
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

    @RequestMapping("/saveAddSkillPackIndexSort.do")
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
    @RequestMapping("/clearSkillPackIndexSort.do")
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
    @RequestMapping("/queryAllSkillPackIndexSort.do")
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

    @RequestMapping("/queryAllExperiencePackIndexSort.do")
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
    @RequestMapping("/forwardAddExperiencePackIndexSortPage.do")
    public String forwardAddExperiencePackIndexSortPage(){
        return "/playsort/addExperiencePackIndexSort";
    }

    @RequestMapping("/getAddExperiencePackIndexSortData.do")
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
    @RequestMapping("/saveAddExperiencePackIndexSort.do")
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
    @RequestMapping("/clearExperiencePackIndexSort.do")
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

    @RequestMapping("/queryAllNewsIndexSort.do")
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

    @RequestMapping("/forwardAddNewsIndexSortPage.do")
    public String forwardAddNewsIndexSortPage(){
        return "/playsort/addNewsIndexSort";
    }
    @RequestMapping("/getAddNewsIndexSortData.do")
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

    @RequestMapping("/saveAddNewsIndexSort.do")
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

    @RequestMapping("/clearNewsIndexSort.do")
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

    @RequestMapping("/queryAllMasterIndexSort.do")
    public void queryAllMasterIndexSort(HttpServletResponse resp){
        PlaySortService playSortService = new PlaySortService();
        try {
            List<MasterIndexSortBean> masterBeans = playSortService.queryAllMasterIndexSort();
            ResponseUtil.writeMsg(resp, new Gson().toJson(masterBeans));
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，查询新闻首页排序信息失败");
        }
    }
    @RequestMapping("/forwardAddMasterIndexSortPage.do")
    public String forwardAddMasterIndexSortPage(){
        return "/playsort/addMasterIndexSort";
    }

    @RequestMapping("/getAddMasterIndexSortData.do")
    public void getAddMasterIndexSortData(HttpServletResponse resp){
        PlaySortService playSortService = new PlaySortService();
        try {
            List<MasterIndexSortBean> masterBeans = playSortService.getAddMasterIndexSortData();
            ResponseUtil.writeMsg(resp, new Gson().toJson(masterBeans));
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp ,"出现异常，查询新增新闻首页排序数据出错");
        }
    }

    @RequestMapping("/saveAddMasterIndexSort.do")
    public void saveAddMasterIndexSort(@RequestParam("uid") String uid,HttpServletResponse resp){
        PlaySortService playSortService = new PlaySortService();
        try{
            boolean result = playSortService.saveAddMasterIndexSort(uid);
            if(result){
                ResponseUtil.writeMsg(resp,"新增掌门首页排序成功");
            }else{
                ResponseUtil.writeFailMsgToBrowse(resp, "新增掌门首页排序失败");
            }
        }catch (Exception e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，新增掌门首页排序出错");
        }
    }
    @RequestMapping("/clearMasterIndexSort.do")
    public void clearMasterIndexSort(HttpServletResponse resp){
        PlaySortService playSortService = new PlaySortService();
        try {
            playSortService.clearMasterIndexSort();
            ResponseUtil.writeMsg(resp, "清空掌门首页排序成功");
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }
    }
    @RequestMapping("/fwdIndexPlayManagePage.do")
    public String fwdIndexPlayManagePage(){
        return "/playsort/manageIndexPlay";
    }
    @RequestMapping("/queryAllIndexPlay.do")
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
    @RequestMapping("/fwdAddIndexPlayPage.do")
    public String fwdAddIndexPlayPage(){
        return "/playsort/addIndexPlay";
    }

    @RequestMapping("/getAddIndexPlayData.do")
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
    @RequestMapping("/saveAddIndexPlay.do")
    public void saveAddIndexPlay(@RequestParam("id") String id,@RequestParam("type") String type,HttpServletResponse resp){
        PlaySortService playSortService = new PlaySortService();
        try{
            boolean result = playSortService.saveAddIndexPlay(id, type);
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
    @RequestMapping("/saveDeleteIndexPlay.do")
    public void saveDeleteIndexPlay(@RequestParam("id") String id, @RequestParam("type") String type, HttpServletResponse resp){
        PlaySortService playSortService = new PlaySortService();
        try{
            boolean result = playSortService.saveDeleteIndexPlay(id, type);
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
    @RequestMapping("/fwdIndexSortManagePage.do")
    public String fwdIndexSortManagePage(){
        return "/playsort/manageIndexSort";
    }
}
