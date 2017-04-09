package dazhimen.bg.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dazhimen.bg.bean.*;
import dazhimen.bg.exception.BgException;
import dazhimen.bg.service.UserService;
import net.sf.json.JSONObject;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import dazhimen.bg.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import util.Constant;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * Created by Administrator on 2017/3/17.
 */
@Controller
@RequestMapping("/product")
public class ProductController {
    @RequestMapping("/fwdModifyProductListImgPage")
    public ModelAndView fwdModifyProductListImgPage(@RequestParam("pid") String pid){
        ModelAndView mav = new ModelAndView("/product/modifyProductListImg");
        mav.addObject("pid", pid);
        return mav;
    }
    @RequestMapping("/fwdModifyProductPage")
    public ModelAndView fwdModifyProductPage(@RequestParam("pid") String pid){
        ModelAndView mav = new ModelAndView("/product/modifyProduct");
        mav.addObject("pid", pid);
        return mav;
    }
    @RequestMapping("/fwdAddProductPage")
    public String forwardAddProductPage(){
        return "/product/addProduct";
    }
    @RequestMapping("/fwdSelectMasterPage")
    public String forwardSelectMasterPage(){
        return "product/selectMaster";
    }
    @RequestMapping("/getSelectMasterData")
    public void getSelectMasterData(HttpServletRequest resq, HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        try {
            ProductService productService = new ProductService();
            String page = resq.getParameter("page");
            String rows = resq.getParameter("rows");
            String result = productService.queryAllMasters(page, rows);
            resp.getWriter().write(result);
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，查询所有掌门信息失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }

    @RequestMapping("/saveAddProduct")
    public ModelAndView saveAddProduct(HttpServletRequest resq, HttpServletResponse resp){
        UploadProductBean productBean = getUploadProductBean(resq);
        ProductService productService = new ProductService();
        ModelAndView mav = new ModelAndView("fileUploadAfterAction");
        String pid = null;
        try {
            pid = productService.saveAddProduct(productBean);
        } catch (BgException e) {
            e.printStackTrace();
            JsonObject jsonObj = new JsonObject();
            jsonObj.addProperty("code", "400");
            jsonObj.addProperty("msg",e.getMessage());
            mav.addObject("parameters", jsonObj.toString());
            return mav;
        }

        JsonObject jsonObj = new JsonObject();
        jsonObj.addProperty("code", "200");
        jsonObj.addProperty("msg","商品上传成功");
        jsonObj.addProperty("pid", pid);
        mav.addObject("parameters", jsonObj.toString());
        return mav;
    }
    @RequestMapping("/fwdProductInfoPage")
    public ModelAndView fwdProductInfoPage(@RequestParam("pid") String pid, HttpServletResponse resp){
        ModelAndView mav = new ModelAndView("product/viewProductInfor");
        mav.addObject("pid", pid);
        return mav;
    }
    @RequestMapping("/getProductInforById")
    public void getProductInforById(@RequestParam("pid") String pid, HttpServletRequest resq,
                                    HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        try{
            ProductService productService = new ProductService();
            ViewProductBean productBean = productService.getProductInforById(pid);
            productBean = dealListImgUrlPrefix(resq.getContextPath() , productBean);
            Gson gson = new Gson();
            String productJson = gson.toJson(productBean);
            resp.getWriter().write(productJson);
        }catch (Exception e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，查询指定产品信息失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }

    }
    @RequestMapping("/getModifyProductInforById")
    public void getModifyProductInforById(@RequestParam("pid") String pid, HttpServletRequest resq,
                                    HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        try{
            ProductService productService = new ProductService();
            ViewProductBean productBean = productService.getModifyProductInforById(pid);
            productBean = dealListImgUrlPrefix(resq.getContextPath() , productBean);
            Gson gson = new Gson();
            String productJson = gson.toJson(productBean);
            resp.getWriter().write(productJson);
        }catch (Exception e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，查询指定产品信息失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }

    }

    @RequestMapping(value="/saveModifyProductBasicInfo",method = RequestMethod.POST)
    public void saveModifyProductBasicInfo(HttpServletRequest resq,
                                       HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        ModifyProductBasicInfoBean productBean = getSaveModifyProductionBasicInfoBean(resq);
        ProductService productService = new ProductService();
        try {
           boolean result = productService.saveModifyProductBasicInfo(productBean);
           if(result){
               resp.getWriter().write("修改产品基本信息成功");
           }else{
               resp.getWriter().write("修改产品基本信息失败");
           }

        } catch (BgException e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write(e.getMessage());
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }catch (Exception e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，修改产品基本信息失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    @RequestMapping("/saveModifyProductListImg")
    public ModelAndView saveModifyProductListImg(HttpServletRequest resq, HttpServletResponse resp){
        ProductService productService = new ProductService();
        ModelAndView mav = new ModelAndView("fileUploadAfterAction");
        try {
            String pid = resq.getParameter("pid");
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) resq;
            CommonsMultipartFile listImgFile = (CommonsMultipartFile) multipartRequest.getFile("listimgmodify");
//            productService.saveModifyProductListImg(pid,listImgFile);
        } catch (Exception e) {
            e.printStackTrace();
            JsonObject jsonObj = new JsonObject();
            jsonObj.addProperty("code", "400");
            jsonObj.addProperty("msg",e.getMessage());
            mav.addObject("parameters", jsonObj.toString());
            return mav;
        }

        JsonObject jsonObj = new JsonObject();
        jsonObj.addProperty("code", "200");
        jsonObj.addProperty("msg","修改课程信息成功");
        mav.addObject("parameters", jsonObj.toString());
        return mav;
    }
    @RequestMapping("/getMainImagesInforById")
    public void getMainImagesInforById(@RequestParam("pid") String pid, HttpServletRequest resq,
                                       HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        try {
            ProductService productService = new ProductService();
            List<ViewMainImageBean> mainImageBeans = productService.getProductMainImages(pid);
            mainImageBeans = dealMainImageUrlPrefix(resq.getContextPath(), mainImageBeans);
            Gson gson = new Gson();
            String mainImagesJson = gson.toJson(mainImageBeans);
            resp.getWriter().write(mainImagesJson);
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，查询产品主图信息失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    @RequestMapping("/fwdViewMasterInforPage")
    public String fwdViewMasterInforPage(@RequestParam("uid") String uid, HttpServletRequest resq,
                                       HttpServletResponse resp){
        resq.setAttribute("uid", uid);
        return "/product/viewMasterInfor";
    }
    @RequestMapping("/getMasterInfor")
    public void getMasterInfor(@RequestParam("uid") String uid, HttpServletRequest resq,
                                       HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        try {
            ProductService productService = new ProductService();
            UserBean userBean = productService.getMasterDataByUid(uid);
            Gson gson = new Gson();
            String mainImagesJson = gson.toJson(userBean);
            resp.getWriter().write(mainImagesJson);
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，查询指定掌门信息失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    @RequestMapping("/fwdManageProductPage")
    public String fwdManageProductPage(){
        return "/product/manageProduct";
    }
    @RequestMapping("/queryAllProducts")
    public void queryAllProducts(HttpServletRequest resq, HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        try{
            ProductService productService = new ProductService();
            String page = resq.getParameter("page");
            String rows = resq.getParameter("rows");
            String result = productService.queryAllProducts(page, rows);
            resp.getWriter().write(result);
        }catch (Exception e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，查询所有产品信息失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }

    }
    @RequestMapping("/fwdModifyProductStatusPage")
    public String fwdModifyProductStatusPage(HttpServletRequest resq){
        resq.setAttribute("pid", resq.getParameter("pid"));
        resq.setAttribute("status" ,resq.getParameter("status"));
        return "/product/modifyProductStatus";
    }
    @RequestMapping("/saveModifyProductStatus")
    public void saveModifyProductStatus(HttpServletRequest resq,HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        try {
            String pid = resq.getParameter("pid");
            String status = resq.getParameter("status");
            ProductService productService = new ProductService();
            productService.saveModifyProductStatus(pid, status);
            resp.getWriter().write("修改成功");
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，修改产品状态失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    @RequestMapping("/saveProductDel")
    public void saveProductDel(HttpServletRequest resq,HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        try {
            String pid = resq.getParameter("pid");
            ProductService productService = new ProductService();
            productService.saveProductDel(pid, resq);
            resp.getWriter().write("删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，删除产品失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    @RequestMapping("/fwdManageCoursePage")
    public String fwdManageCoursePage(HttpServletRequest resq,HttpServletResponse resp){
        resq.setAttribute("pid", resq.getParameter("pid"));
        return "/product/manageCourse";
    }
    @RequestMapping("/queryAllCourseByPid")
    public void queryAllCourseByPid(HttpServletRequest resq,HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        try{
            String pid = resq.getParameter("pid");
            ProductService productService = new ProductService();
            String page = resq.getParameter("page");
            String rows = resq.getParameter("rows");
            Integer totalCount = productService.getAllCourseCountByPid(pid);
            List<ListViewCourseBean> courseBeans = productService.queryAllCourseByPid(pid, page, rows);
            String localIp = resq.getLocalAddr();//获取本地ip
            if(Constant.isDeployInAliyun){
                localIp = Constant.AliyunIP;
            }
            int localPort = resq.getLocalPort();//获取本地的端口
            String appName = resq.getContextPath();
            if(courseBeans != null){
                for(int i = 0; i < courseBeans.size(); i++){
                    ListViewCourseBean courseBean = courseBeans.get(i);
                    String audioUrl = "http://" + localIp + ":" + localPort + appName + "/" + courseBean.getAudiourl();
                    courseBean.setAudiourl(audioUrl);
                }
            }
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("total", totalCount);
            jsonObject.put("rows", courseBeans);
            resp.getWriter().write(jsonObject.toString());
        }catch (Exception e){
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，查询产品的课程失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    @RequestMapping("/fwdAddCoursePage")
    public String fwdAddCoursePage(HttpServletRequest resq,HttpServletResponse resp){
        return "/product/addCourse";
    }

    @RequestMapping("/saveAddCourse")
    public ModelAndView saveAddCourse(HttpServletRequest resq, HttpServletResponse resp){
        UploadCourseBean courseBean = getUploadCourseBean(resq);
        ProductService productService = new ProductService();
        ModelAndView mav = new ModelAndView("fileUploadAfterAction");
        String pid = null;
        try {
            pid = productService.saveAddCourse(courseBean);
        } catch (BgException e) {
            e.printStackTrace();
            JsonObject jsonObj = new JsonObject();
            jsonObj.addProperty("code", "400");
            jsonObj.addProperty("msg",e.getMessage());
            mav.addObject("parameters", jsonObj.toString());
            return mav;
        }

        JsonObject jsonObj = new JsonObject();
        jsonObj.addProperty("code", "200");
        jsonObj.addProperty("msg","课程新增成功");
        jsonObj.addProperty("pid", pid);
        mav.addObject("parameters", jsonObj.toString());
        return mav;
    }

    @RequestMapping("/fwdModifyCoursePage")
    public String fwdModifyCoursePage(HttpServletRequest resq,HttpServletResponse resp){
        String courseid = resq.getParameter("courseid");
        resq.setAttribute("courseid", courseid);
        return "/product/modifyCourse";
    }
    @RequestMapping("/getCourseInforByCourseid")
    public void getCourseInforByCourseid(HttpServletRequest resq,HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        try {
            String courseid = resq.getParameter("courseid");
            ProductService productService = new ProductService();
            UploadCourseBean courseBean = productService.getCourseInforByCourseid(courseid);
            resp.getWriter().write(new Gson().toJson(courseBean));
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，查询指定课程信息失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    @RequestMapping("/saveModifyCourse")
    public ModelAndView saveModifyCourse(HttpServletRequest resq,HttpServletResponse resp){
        UploadCourseBean courseBean = getUploadCourseBean(resq);
        ProductService productService = new ProductService();
        ModelAndView mav = new ModelAndView("fileUploadAfterAction");
        String pid = null;
        try {
            pid = productService.saveModifyCourse(courseBean);
        } catch (BgException e) {
            e.printStackTrace();
            JsonObject jsonObj = new JsonObject();
            jsonObj.addProperty("code", "400");
            jsonObj.addProperty("msg",e.getMessage());
            mav.addObject("parameters", jsonObj.toString());
            return mav;
        }

        JsonObject jsonObj = new JsonObject();
        jsonObj.addProperty("code", "200");
        jsonObj.addProperty("msg","修改课程信息成功");
        jsonObj.addProperty("pid", pid);
        mav.addObject("parameters", jsonObj.toString());
        return mav;
    }

    @RequestMapping("/saveCourseDel")
    public void saveCourseDel(HttpServletRequest resq,HttpServletResponse resp){
        resp.setCharacterEncoding(Constant.CharSet);
        try{
            String courseid = resq.getParameter("courseid");
            String pid = resq.getParameter("pid");
            ProductService productService = new ProductService();
            productService.saveCourseDel(courseid,pid, resq);
            resp.getWriter().write("删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                resp.getWriter().write("出现异常，删除课程信息失败");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }
    private ViewProductBean dealListImgUrlPrefix(String prefix, ViewProductBean productBean){
        productBean.setListImage(prefix + "/" + productBean.getListImage());
        return productBean;
    }
    private List<ViewMainImageBean> dealMainImageUrlPrefix(String prefix, List<ViewMainImageBean> mainImageBeans){
        for(int i = 0; i < mainImageBeans.size(); i++){
            ViewMainImageBean mainImage = mainImageBeans.get(i);
            mainImage.setMainImage(prefix + "/" + mainImage.getMainImage());
        }
        return mainImageBeans;
    }
    private UploadCourseBean getUploadCourseBean(HttpServletRequest resq){
        UploadCourseBean courseBean = new UploadCourseBean();
        String pid = resq.getParameter("pid");
        courseBean.setPid(pid);
        String courseid = resq.getParameter("courseid");
        courseBean.setCourseid(courseid);
        String coursename = resq.getParameter("coursename");
        courseBean.setCoursename(coursename);
        String sort = resq.getParameter("sort");
        courseBean.setSort(sort);
        String istry = resq.getParameter("istry");
        courseBean.setIstry(istry);
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) resq;
        CommonsMultipartFile audioFile = (CommonsMultipartFile) multipartRequest.getFile("audio");
        courseBean.setAudio(audioFile);
        String basePath = resq.getSession().getServletContext().getRealPath("/");
        courseBean.setBasePath(basePath);
        return courseBean;
    }
    private ModifyProductBasicInfoBean getSaveModifyProductionBasicInfoBean(HttpServletRequest resq){
        ModifyProductBasicInfoBean productBean = new ModifyProductBasicInfoBean();
        String pid = resq.getParameter("pid");
        productBean.setPid(pid);
        String pname = resq.getParameter("pname");
        productBean.setPname(pname);
        Double price = Double.parseDouble(resq.getParameter("price"));
        productBean.setPrice(price);
        String derateProportionStr = resq.getParameter("derateProportion");
        if(derateProportionStr == null || derateProportionStr.equals("")){
            productBean.setDerateProportion(0);
        }else{
            Integer derateProportion = Integer.parseInt(derateProportionStr);
            productBean.setDerateProportion(derateProportion);
        }
        String introduction = resq.getParameter("introduction");
        productBean.setIntroduction(introduction);

        return productBean;
    }
    private UploadProductBean getUploadProductBean(HttpServletRequest resq){
        UploadProductBean productBean = new UploadProductBean();
        String pname = resq.getParameter("pname");
        productBean.setPname(pname);
        String type = resq.getParameter("type");
        productBean.setType(type);
        Double price = Double.parseDouble(resq.getParameter("price"));
        productBean.setPrice(price);
        String derateProportionStr = resq.getParameter("derateProportion");
        if(derateProportionStr == null || derateProportionStr.equals("")){
            productBean.setDerateProportion(0);
        }else{
            Integer derateProportion = Integer.parseInt(derateProportionStr);
            productBean.setDerateProportion(derateProportion);
        }
        String introduction = resq.getParameter("introduction");
        productBean.setIntroduction(introduction);
        String indexSort = resq.getParameter("indexsort");
        if(indexSort == null || indexSort.equals("")){
            productBean.setIndexSort("99");
        }else{
            productBean.setIndexSort(indexSort);
        }

        String indexPlay = resq.getParameter("indexplay");
        if(indexPlay == null || indexPlay.equals("")){
            productBean.setIndexPlay("0");
        }else{
            productBean.setIndexPlay(indexPlay);
        }

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) resq;
        CommonsMultipartFile listImgFile = (CommonsMultipartFile) multipartRequest.getFile("listimg");
        productBean.setListImgFile(listImgFile);
        List<MultipartFile> mainImgFiles = multipartRequest.getFiles("mainimg");
        productBean.setMainImgFiles(mainImgFiles);

        String uid = resq.getParameter("uid");
        productBean.setUid(uid);

        String basePath = resq.getSession().getServletContext().getRealPath("/");
        productBean.setBasePath(basePath);
        return productBean;
    }
}
