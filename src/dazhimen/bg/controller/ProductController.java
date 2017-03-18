package dazhimen.bg.controller;

import com.google.gson.Gson;
import dazhimen.bg.bean.UserBean;
import dazhimen.bg.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
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
}
