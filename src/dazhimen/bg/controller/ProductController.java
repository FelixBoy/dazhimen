package dazhimen.bg.controller;

import com.google.gson.Gson;
import dazhimen.bg.bean.UploadProductBean;
import dazhimen.bg.bean.UserBean;
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
        productService.saveAddProduct(productBean);
//        resp.setCharacterEncoding("utf-8");
        ModelAndView mav = new ModelAndView("fileUploadAfterAction");
        mav.addObject("message", "testmessage");
        mav.addObject("parameters", "上传成功");
        return mav;
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
