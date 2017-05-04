package dazhimen.bg.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dazhimen.bg.bean.login.LoginUserBean;
import dazhimen.bg.bean.product.*;
import dazhimen.bg.bean.user.UserBean;
import dazhimen.bg.exception.BgException;
import net.sf.json.JSON;
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
import util.web.ResponseUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by Administrator on 2017/3/17.
 */
@Controller
@RequestMapping("/product")
public class ProductController {
    /**
     * 转向修改产品主图页面
     * @param pid 产品id
     * @return
     */
    @RequestMapping("/fwdModifyProductMainImgPage.do")
    public ModelAndView fwdModifyProductMainImgPage(@RequestParam("pid") String pid){
        ModelAndView mav = new ModelAndView("/product/modifyProductMainImg");
        mav.addObject("pid", pid);
        return mav;
    }
    /**
     * 转向修改产品列表图片页面
     * @param pid 产品id
     * @return
     */
    @RequestMapping("/fwdModifyProductListImgPage.do")
    public ModelAndView fwdModifyProductListImgPage(@RequestParam("pid") String pid){
        ModelAndView mav = new ModelAndView("/product/modifyProductListImg");
        mav.addObject("pid", pid);
        return mav;
    }
    /**
     * 转向修改产品信息页面
     * @param pid 产品id
     * @return
     */
    @RequestMapping("/fwdModifyProductPage.do")
    public ModelAndView fwdModifyProductPage(@RequestParam("pid") String pid){
        ModelAndView mav = new ModelAndView("/product/modifyProduct");
        mav.addObject("pid", pid);
        return mav;
    }
    /**
     * 转向新增（上传）产品页面
     * @return
     */
    @RequestMapping("/fwdAddProductPage.do")
    public String forwardAddProductPage(){
        return "/product/addProduct";
    }

    /**
     * 掌门身份登录时的新增产品页面
     * @return
     */
    @RequestMapping("/fwdAddProductByMasterPage.do")
    public String fwdAddProductByMasterPage(){
        return "/product/addProductByMaster";
    }

    /**
     * 转向上传产品时，选择掌门页面
     * @return
     */
    @RequestMapping("/fwdSelectMasterPage.do")
    public String forwardSelectMasterPage(){
        return "product/selectMaster";
    }

    /**
     * 转向上传产品时，获取掌门页面数据
     * @param resq
     * @param resp
     */
    @RequestMapping("/getSelectMasterData.do")
    public void getSelectMasterData(HttpServletRequest resq, HttpServletResponse resp){
        try {
            ProductService productService = new ProductService();
            String page = resq.getParameter("page");
            String rows = resq.getParameter("rows");
            String result = null;
            String queryByParamFlag = resq.getParameter("queryByParamFlag");
            if(queryByParamFlag == null || queryByParamFlag.equals("")){
                result = productService.queryAllMasters(page, rows);
            }else{
                QueryMasterParamBean paramBean = new QueryMasterParamBean();
                String searchCondition = resq.getParameter("searchCondition");
                paramBean.setSearchCondition(searchCondition);
                result = productService.queryAllMastersByParams(page, rows, paramBean);
            }

            ResponseUtil.writeMsg(resp, result);
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，查询所有掌门信息失败");
        }
    }

    /**
     * 保存新增产品
     * @param resq
     * @param resp
     * @return
     */
    @RequestMapping("/saveAddProduct.do")
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

    /**
     * 转向查看产品页面
     * @param pid
     * @return
     */
    @RequestMapping("/fwdProductInfoPage.do")
    public ModelAndView fwdProductInfoPage(@RequestParam("pid") String pid){
        ModelAndView mav = new ModelAndView("product/viewProductInfor");
        mav.addObject("pid", pid);
        return mav;
    }

    /**
     * 通过产品id获取产品信息
     * @param pid
     * @param resq
     * @param resp
     */
    @RequestMapping("/getProductInforById.do")
    public void getProductInforById(@RequestParam("pid") String pid, HttpServletRequest resq, HttpServletResponse resp){
        try{
            ProductService productService = new ProductService();
            ViewProductBean productBean = productService.getProductInforById(pid);
            productBean = dealListImgUrlPrefix(resq.getContextPath() , productBean);
            Gson gson = new Gson();
            String productJson = gson.toJson(productBean);
            ResponseUtil.writeMsg(resp, productJson);
        }catch (Exception e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，查询指定产品信息失败");
        }

    }
    /**
     * 通过产品id获取修改产品时的初始信息
     * @param pid
     * @param resq
     * @param resp
     */
    @RequestMapping("/getModifyProductInforById.do")
    public void getModifyProductInforById(@RequestParam("pid") String pid, HttpServletRequest resq, HttpServletResponse resp){
        try{
            ProductService productService = new ProductService();
            ViewProductBean productBean = productService.getModifyProductInforById(pid);
            productBean = dealListImgUrlPrefix(resq.getContextPath() , productBean);
            Gson gson = new Gson();
            String productJson = gson.toJson(productBean);
            ResponseUtil.writeMsg(resp, productJson);
        }catch (Exception e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，查询指定产品信息失败");
        }
    }

    /**
     * 保存修改产品基本信息
     * @param resq
     * @param resp
     */
    @RequestMapping(value="/saveModifyProductBasicInfo.do",method = RequestMethod.POST)
    public void saveModifyProductBasicInfo(HttpServletRequest resq, HttpServletResponse resp){
        ModifyProductBasicInfoBean productBean = getSaveModifyProductionBasicInfoBean(resq);
        ProductService productService = new ProductService();
        try {
           boolean result = productService.saveModifyProductBasicInfo(productBean);
           if(result){
               ResponseUtil.writeMsg(resp, "修改产品基本信息成功");
           }else{
               ResponseUtil.writeMsg(resp, "修改产品基本信息失败");
           }

        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，修改产品基本信息失败");
        }
    }

    /**
     * 保存修改 产品列表图片
     * @param resq
     * @param resp
     * @return
     */
    @RequestMapping("/saveModifyProductListImg.do")
    public ModelAndView saveModifyProductListImg(HttpServletRequest resq, HttpServletResponse resp){
        ProductService productService = new ProductService();
        ModelAndView mav = new ModelAndView("fileUploadAfterAction");
        try {
            String pid = resq.getParameter("pid");
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) resq;
            CommonsMultipartFile listImgFile = (CommonsMultipartFile) multipartRequest.getFile("listimgmodify");
            String basePath = resq.getSession().getServletContext().getRealPath("/");
            productService.saveModifyProductListImg(pid,listImgFile,basePath);
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
        jsonObj.addProperty("msg","修改产品列表图片成功");
        mav.addObject("parameters", jsonObj.toString());
        return mav;
    }

    /**
     * 保存修改产品主图
     * @param resq
     * @param resp
     * @return
     */
    @RequestMapping("/saveModifyProductMainImg.do")
    public ModelAndView saveModifyProductMainImg(HttpServletRequest resq, HttpServletResponse resp){
        ProductService productService = new ProductService();
        ModelAndView mav = new ModelAndView("fileUploadAfterAction");
        try {
            String pid = resq.getParameter("pid");
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) resq;
            CommonsMultipartFile mainImgFile = (CommonsMultipartFile) multipartRequest.getFile("mainimgmodify");
            String basePath = resq.getSession().getServletContext().getRealPath("/");
            productService.saveModifyProductMainImg(pid,mainImgFile,basePath);
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
        jsonObj.addProperty("msg","修改产品主图成功");
        mav.addObject("parameters", jsonObj.toString());
        return mav;
    }

    /**
     * 获取产品主图信息
     * @param pid 要获取主图信息的产品id
     * @param resq
     * @param resp
     */
    @RequestMapping("/getMainImagesInforById.do")
    public void getMainImagesInforById(@RequestParam("pid") String pid, HttpServletRequest resq,
                                       HttpServletResponse resp){
        try {
            ProductService productService = new ProductService();
            List<ViewMainImageBean> mainImageBeans = productService.getProductMainImages(pid);
            mainImageBeans = dealMainImageUrlPrefix(resq.getContextPath(), mainImageBeans);
            Gson gson = new Gson();
            String mainImagesJson = gson.toJson(mainImageBeans);
            ResponseUtil.writeMsg(resp, mainImagesJson);
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，查询产品主图信息失败");
        }
    }
    @RequestMapping("/fwdViewMasterInforPage.do")
    public String fwdViewMasterInforPage(@RequestParam("uid") String uid, HttpServletRequest resq,
                                       HttpServletResponse resp){
        resq.setAttribute("uid", uid);
        return "/product/viewMasterInfor";
    }
    @RequestMapping("/getMasterInfor.do")
    public void getMasterInfor(@RequestParam("uid") String uid, HttpServletRequest resq,
                                       HttpServletResponse resp){
        try {
            ProductService productService = new ProductService();
            UserBean userBean = productService.getMasterDataByUid(uid);
            Gson gson = new Gson();
            String mainImagesJson = gson.toJson(userBean);
            ResponseUtil.writeMsg(resp, mainImagesJson);
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，查询指定掌门信息失败");
        }
    }
    @RequestMapping("/fwdManageProductPage.do")
    public String fwdManageProductPage(){
        return "/product/manageProduct";
    }
    @RequestMapping("/queryAllProducts.do")
    public void queryAllProducts(HttpServletRequest resq, HttpServletResponse resp){
        try{
            ProductService productService = new ProductService();
            String page = resq.getParameter("page");
            String rows = resq.getParameter("rows");
            String queryByParamFlag = resq.getParameter("queryByParamFlag");
            String result = null;
            HttpSession sessionObj = resq.getSession(false);
            LoginUserBean userBean = (LoginUserBean)sessionObj.getAttribute(Constant.LoginUserKey);
            if(queryByParamFlag == null || queryByParamFlag.equals("")){
                if(userBean.getUtype().equals(Constant.userType_Master)){
                    result = productService.queryAllProductsByMaster(page, rows, userBean.getUid());
                }else{
                    result = productService.queryAllProducts(page, rows);
                }
            }else{
                String pidCondition = resq.getParameter("pidCondition");
                String pnameCondition = resq.getParameter("pnameCondition");
                String typeCondition = resq.getParameter("typeCondition");
                String starttimeCondition = resq.getParameter("starttimeCondition");
                String endtimeCondition = resq.getParameter("endtimeCondition");
                String statusCondition = resq.getParameter("statusCondition");
                QueryProductParamBean paramBean = new QueryProductParamBean();
                paramBean.setPidCondition(pidCondition);
                paramBean.setPnameCondition(pnameCondition);
                paramBean.setTypeCondition(typeCondition);
                paramBean.setStatusCondition(statusCondition);
                paramBean.setStarttimeCondition(starttimeCondition);
                paramBean.setEndtimeCondition(endtimeCondition);
                if(userBean.getUtype().equals(Constant.userType_Master)){
                    paramBean.setUid(userBean.getUid());
                    result = productService.queryAllProductsByParamsAndMaster(page, rows, paramBean);
                }else{
                    result = productService.queryAllProductsByParams(page, rows, paramBean);
                }
            }
            ResponseUtil.writeMsg(resp, result);
        }catch (Exception e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，查询所有产品信息失败");
        }

    }
    @RequestMapping("/fwdModifyProductStatusPage.do")
    public ModelAndView fwdModifyProductStatusPage(@RequestParam("pid") String pid, @RequestParam("status") String status){
        ModelAndView mav = new ModelAndView("/product/modifyProductStatus");
        mav.addObject("pid", pid);
        mav.addObject("status" , status);
        return mav;
    }
    @RequestMapping("/saveModifyProductStatus.do")
    public void saveModifyProductStatus(HttpServletRequest resq,HttpServletResponse resp){
        try {
            String pid = resq.getParameter("pid");
            String status = resq.getParameter("status");
            ProductService productService = new ProductService();
            productService.saveModifyProductStatus(pid, status);
            ResponseUtil.writeMsg(resp, "修改成功");
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，修改产品状态失败");
        }
    }
    @RequestMapping("/saveProductDel.do")
    public void saveProductDel(HttpServletRequest resq,HttpServletResponse resp){
        try {
            String pid = resq.getParameter("pid");
            ProductService productService = new ProductService();
            productService.saveProductDel(pid, resq);
            ResponseUtil.writeMsg(resp, "删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，删除产品失败");
        }
    }
    @RequestMapping("/fwdManageCoursePage.do")
    public String fwdManageCoursePage(HttpServletRequest resq,HttpServletResponse resp){
        resq.setAttribute("pid", resq.getParameter("pid"));
        return "/product/manageCourse";
    }
    @RequestMapping("/queryAllCourseByPid.do")
    public void queryAllCourseByPid(HttpServletRequest resq,HttpServletResponse resp){
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
            ResponseUtil.writeMsg(resp, jsonObject.toString());
        }catch (Exception e){
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，查询产品的课程失败");
        }
    }
    @RequestMapping("/fwdAddCoursePage.do")
    public String fwdAddCoursePage(HttpServletRequest resq,HttpServletResponse resp){
        return "/product/addCourse";
    }

    @RequestMapping("/saveAddCourse.do")
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
    @RequestMapping("/getCourseSortData.do")
    public void getCourseSortData(HttpServletRequest resq, HttpServletResponse resp){
        String pid = resq.getParameter("pid");
        ProductService productService = new ProductService();
        try {
            String sortData = productService.getCourseSortData(pid);
            ResponseUtil.writeMsg(resp, sortData);
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }
    }
    @RequestMapping("/getCourseSortDataInModify.do")
    public void getCourseSortDataInModify(HttpServletRequest resq, HttpServletResponse resp){
        String pid = resq.getParameter("pid");
        String courseid = resq.getParameter("courseid");
        ProductService productService = new ProductService();
        try {
            UploadCourseBean uploadCourseBean = productService.getCourseInforByCourseid(courseid);
            String sortData = productService.getCourseSortData(pid);
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("pid", uploadCourseBean.getPid());
            jsonObject.put("courseid", uploadCourseBean.getCourseid());
            jsonObject.put("coursename", uploadCourseBean.getCoursename());
            jsonObject.put("istry", uploadCourseBean.getIstry());
            jsonObject.put("sort", uploadCourseBean.getSort());
            jsonObject.put("sortsdata", sortData);
            jsonObject.put("filename", uploadCourseBean.getFilename());
            jsonObject.put("filesizestr", uploadCourseBean.getFilesizestr());
            ResponseUtil.writeMsg(resp, jsonObject.toString());
        } catch (BgException e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, e.getMessage());
        }
    }

    @RequestMapping("/fwdModifyCoursePage.do")
    public String fwdModifyCoursePage(HttpServletRequest resq,HttpServletResponse resp){
        String courseid = resq.getParameter("courseid");
        resq.setAttribute("courseid", courseid);
        return "/product/modifyCourse";
    }
    @RequestMapping("/getCourseInforByCourseid.do")
    public void getCourseInforByCourseid(HttpServletRequest resq,HttpServletResponse resp){
        try {
            String courseid = resq.getParameter("courseid");
            ProductService productService = new ProductService();
            UploadCourseBean courseBean = productService.getCourseInforByCourseid(courseid);
            ResponseUtil.writeMsg(resp, new Gson().toJson(courseBean));
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，查询指定课程信息失败");
        }
    }
    @RequestMapping("/saveModifyCourse.do")
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

    @RequestMapping("/saveCourseDel.do")
    public void saveCourseDel(HttpServletRequest resq,HttpServletResponse resp){
        try{
            String courseid = resq.getParameter("courseid");
            String pid = resq.getParameter("pid");
            ProductService productService = new ProductService();
            productService.saveCourseDel(courseid,pid, resq);
            ResponseUtil.writeMsg(resp, "删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            ResponseUtil.writeFailMsgToBrowse(resp, "出现异常，删除课程信息失败");
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
        String coursename = resq.getParameter("coursename").trim();
        courseBean.setCoursename(coursename);
        String sort = resq.getParameter("sort");
        courseBean.setSort(sort);
        String istry = resq.getParameter("istry");
        if(istry == null || istry.equals("")){
            courseBean.setIstry("0");
        }else{
            courseBean.setIstry(istry);
        }

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) resq;
        CommonsMultipartFile audioFile = (CommonsMultipartFile) multipartRequest.getFile("audio");
        courseBean.setAudio(audioFile);
        String basePath = resq.getSession().getServletContext().getRealPath("/");
        courseBean.setBasePath(basePath);
        return courseBean;
    }
    private ModifyProductBasicInfoBean getSaveModifyProductionBasicInfoBean(HttpServletRequest resq){
        ModifyProductBasicInfoBean productBean = new ModifyProductBasicInfoBean();
        String pid = resq.getParameter("pid").trim();
        productBean.setPid(pid);
        String pname = resq.getParameter("pname").trim();
        productBean.setPname(pname);
        Double price = Double.parseDouble(resq.getParameter("price").trim());
        productBean.setPrice(price);
        String derateProportionStr = resq.getParameter("derateProportion").trim();
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
        String pname = resq.getParameter("pname").trim();
        productBean.setPname(pname);
        String type = resq.getParameter("type");
        productBean.setType(type);
        Double price = Double.parseDouble(resq.getParameter("price").trim());
        productBean.setPrice(price);
        String derateProportionStr = resq.getParameter("derateProportion").trim();
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
