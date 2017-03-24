package dazhimen.bg.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dazhimen.bg.bean.*;
import dazhimen.bg.exception.BgException;
import dazhimen.bg.service.UserService;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import dazhimen.bg.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

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
    @RequestMapping("/fwdAddProductPage")
    public String forwardAddProductPage(){
        return "/product/addProduct";
    }
    @RequestMapping("/fwdSelectMasterPage")
    public String forwardSelectMasterPage(){
        return "product/selectMaster";
    }
    @RequestMapping("/getSelectMasterData")
    public void getSelectMasterData(HttpServletResponse resp){
        ProductService productService = new ProductService();
        List<UserBean> users = productService.queryAllMasters();
        Gson gson = new Gson();
        String usersJson = gson.toJson(users);
        resp.setCharacterEncoding("utf-8");
        try {
            resp.getWriter().write(usersJson);
        } catch (IOException e) {
            e.printStackTrace();
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
        ProductService productService = new ProductService();
        ViewProductBean productBean = productService.getProductInforById(pid);
        productBean = dealListImgUrlPrefix(resq.getContextPath() , productBean);
        Gson gson = new Gson();
        String productJson = gson.toJson(productBean);
        resp.setCharacterEncoding("utf-8");
        try {
            resp.getWriter().write(productJson);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    @RequestMapping("/getMainImagesInforById")
    public void getMainImagesInforById(@RequestParam("pid") String pid, HttpServletRequest resq,
                                       HttpServletResponse resp){
        ProductService productService = new ProductService();
        List<ViewMainImageBean> mainImageBeans = productService.getProductMainImages(pid);
        mainImageBeans = dealMainImageUrlPrefix(resq.getContextPath(), mainImageBeans);
        Gson gson = new Gson();
        String mainImagesJson = gson.toJson(mainImageBeans);
        resp.setCharacterEncoding("utf-8");
        try {
            resp.getWriter().write(mainImagesJson);
        } catch (IOException e) {
            e.printStackTrace();
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
        ProductService productService = new ProductService();
        UserBean userBean = productService.getMasterDataByUid(uid);
        Gson gson = new Gson();
        String mainImagesJson = gson.toJson(userBean);
        resp.setCharacterEncoding("utf-8");
        try {
            resp.getWriter().write(mainImagesJson);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    @RequestMapping("/fwdManageProductPage")
    public String fwdManageProductPage(){
        return "/product/manageProduct";
    }
    @RequestMapping("/queryAllProducts")
    public void queryAllProducts(HttpServletResponse resp){
        ProductService productService = new ProductService();
        List<ListViewProductBean> productBeans = productService.queryAllProducts();
        resp.setCharacterEncoding("utf-8");
        try {
            resp.getWriter().write(new Gson().toJson(productBeans));
        } catch (IOException e) {
            e.printStackTrace();
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
        String pid = resq.getParameter("pid");
        String status = resq.getParameter("status");
        ProductService productService = new ProductService();
        productService.saveModifyProductStatus(pid, status);
        resp.setCharacterEncoding("utf-8");
        try {
            resp.getWriter().write("修改成功");
        } catch (IOException e) {
            e.printStackTrace();
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
//        for (ViewMainImageBean mainImage: mainImageBeans
//                ) {
//            System.out.println(mainImage);
//        }
        return mainImageBeans;
    }
    private UploadProductBean getUploadProductBean(HttpServletRequest resq){
        UploadProductBean productBean = new UploadProductBean();
        String pname = resq.getParameter("pname");
        productBean.setPname(pname);
        String type = resq.getParameter("type");
        productBean.setType(type);
        Double price = Double.parseDouble(resq.getParameter("price"));
        productBean.setPrice(price);
        Double derateProportion = Double.parseDouble(resq.getParameter("derateProportion"));
        productBean.setDerateProportion(derateProportion);
        String introduction = resq.getParameter("introduction");
        productBean.setIntroduction(introduction);
        String indexSort = resq.getParameter("indexosrt");
        productBean.setIndexSort(indexSort);
        String indexPlay = resq.getParameter("indexplay");
        if(indexPlay == null){
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
