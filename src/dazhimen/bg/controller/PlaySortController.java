package dazhimen.bg.controller;

import com.google.gson.Gson;
import dazhimen.bg.bean.IndexPlayBean;
import dazhimen.bg.bean.indexsort.ProductIndexSortBean;
import dazhimen.bg.exception.BgException;
import dazhimen.bg.service.PlaySortService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import util.Constant;

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
        resp.setCharacterEncoding(Constant.CharSet);
        PlaySortService playSortService = new PlaySortService();
        try {
            List<ProductIndexSortBean> productBeans = playSortService.getAddSkillPackIndexSortData();
            resp.getWriter().write(new Gson().toJson(productBeans));
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，查询新增轮播数据出错");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }

    @RequestMapping("/saveAddSkillPackIndexSort")
    public void saveAddSkillPackIndexSort(@RequestParam("pid") String pid,HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        PlaySortService playSortService = new PlaySortService();
        try{
            boolean result = playSortService.saveAddSkillPackIndexSort(pid);
            if(result){
                resp.getWriter().write("新增技能包首页排序成功");
            }else{
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.getWriter().write("新增技能包首页排序失败");
            }
        }catch (Exception e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，新增技能包首页排序出错");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    @RequestMapping("/queryAllSkillPackIndexSort")
    public void queryAllSkillPackIndexSort(HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        PlaySortService playSortService = new PlaySortService();
        try {
            List<ProductIndexSortBean> productBeans = playSortService.queryAllSkillPackIndexSort();
            resp.getWriter().write(new Gson().toJson(productBeans));
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，查询技能包首页排序信息失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    @RequestMapping("/fwdIndexPlayManagePage")
    public String fwdIndexPlayManagePage(){
        return "/playsort/manageIndexPlay";
    }
    @RequestMapping("/queryAllIndexPlay")
    public void queryAllIndexPlay(HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        PlaySortService playSortService = new PlaySortService();
        try {
            List<IndexPlayBean> indexPlayBeans = playSortService.queryAllIndexPlay();
            resp.getWriter().write(new Gson().toJson(indexPlayBeans));
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，查询首页轮播信息失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    @RequestMapping("/fwdAddIndexPlayPage")
    public String fwdAddIndexPlayPage(){
        return "/playsort/addIndexPlay";
    }

    @RequestMapping("/getAddIndexPlayData")
    public void getAddIndexPlayData(HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        PlaySortService playSortService = new PlaySortService();
        try {
            List<IndexPlayBean> indexPlayBeans = playSortService.getAddIndexPlayData();
            resp.getWriter().write(new Gson().toJson(indexPlayBeans));
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，查询新增轮播数据出错");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    @RequestMapping("/saveAddIndexPlay")
    public void saveAddIndexPlay(@RequestParam("pid") String pid,HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        PlaySortService playSortService = new PlaySortService();
        try{
            boolean result = playSortService.saveAddIndexPlay(pid);
            if(result){
                resp.getWriter().write("新增轮播成功");
            }else{
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.getWriter().write("新增轮播失败");
            }
        }catch (Exception e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，新增轮播数据出错");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    @RequestMapping("/saveDeleteIndexPlay")
    public void saveDeleteIndexPlay(@RequestParam("pid") String pid,HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        PlaySortService playSortService = new PlaySortService();
        try{
            boolean result = playSortService.saveDeleteIndexPlay(pid);
            if(result){
                resp.getWriter().write("取消轮播成功");
            }else{
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.getWriter().write("取消轮播失败");
            }
        }catch (Exception e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，取消轮播数据出错");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    @RequestMapping("/fwdIndexSortManagePage")
    public String fwdIndexSortManagePage(){
        return "/playsort/manageIndexSort";
    }
}
