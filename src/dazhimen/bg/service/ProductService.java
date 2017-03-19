package dazhimen.bg.service;

import com.alibaba.druid.pool.DruidPooledConnection;
import dazhimen.bg.bean.UploadProductBean;
import dazhimen.bg.bean.UserBean;
import dazhimen.bg.exception.CreateFolderException;
import db.DBConnUtil;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import util.Constant;
import util.IdUtils;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Created by Administrator on 2017/3/17.
 */
public class ProductService {
    /**
     * 查询所有掌门的信息
     * @return 包含所有掌门信息的 list
     */
    public List<UserBean> queryAllMasters(){
        List<UserBean> userBeans = null;
        try {
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            userBeans = runner.query("select uid,name,mphone,gender,loginname,remarks" +
                            " from user where type = '1' and isdel = '0' ",
                    new BeanListHandler<UserBean>(UserBean.class));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userBeans;
    }

    public boolean saveAddProduct(UploadProductBean productBean){
        DruidPooledConnection conn = null;
        try {
            //1 生成pid
            String pid = IdUtils.getPid();
            //2 计算产品主目录路径
            //C:\Users\Administrator\IdeaProjects\dazhimen\out\artifacts\dazhimen_war_exploded\web\upload\product\
            String productMainFolderPath = productBean.getBasePath() + Constant.proPrefixPath + "\\" + pid + "_" + productBean.getPname() + "\\";
            FileManageService fileService = new FileManageService();
            try {
                fileService.createFolder(productMainFolderPath);
            } catch (CreateFolderException e) {
                e.printStackTrace();
                System.out.println(e.getMessage());
            }
            productBean.getListImgFile().transferTo(new File(productMainFolderPath + pid+"_listimg."));;

            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            conn = DBConnUtil.getDataSource().getConnection();
            conn.setAutoCommit(false);
            runner.update("insert into product(pid,pname,type,price,derateProportion," +
                    "introduction,indexplay,indexsort,uid,createdatetime) ");

        } catch (SQLException e) {
            e.printStackTrace();
        }
//        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) resq;
//        CommonsMultipartFile listImg = (CommonsMultipartFile) multipartRequest.getFile("listimg");
//        System.out.println(listImg.getName());
//        System.out.println(listImg.getOriginalFilename());
//        System.out.println(listImg.getSize());
//        System.out.println(listImg.getStorageDescription());
//        System.out.println(listImg.isEmpty());
//        try {
//            listImg.transferTo(new File("e://1.png"));
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//        int i = 2;
//        List<MultipartFile> mainImgs = multipartRequest.getFiles("mainimg");
//        for (MultipartFile mainImg:mainImgs) {
//            CommonsMultipartFile mainImgCommons = (CommonsMultipartFile)mainImg;
//            System.out.println(mainImgCommons.getName());
//            System.out.println(mainImgCommons.getOriginalFilename());
//            System.out.println(mainImgCommons.getSize());
//            System.out.println(mainImgCommons.getStorageDescription());
//            System.out.println(mainImgCommons.isEmpty());
//            try {
//                mainImg.transferTo(new File("e://"+(i++)+".png"));
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//        }
        return false;
    }
}
