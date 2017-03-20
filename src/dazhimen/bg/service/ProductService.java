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
import java.util.Date;
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
        //1 生成pid
        String pid = IdUtils.getPid();
        //2 计算产品主目录路径
        //工程所在路径+ proPrefixPath + pid_pname
        String productMainFolderPath = productBean.getBasePath() + Constant.proPrefixPath  + pid + "\\";
        FileManageService fileService = new FileManageService();
        try {
            try {
                fileService.createFolder(productMainFolderPath);
            } catch (CreateFolderException e) {
                e.printStackTrace();
                System.out.println(e.getMessage());
            }
            CommonsMultipartFile listImageFile = productBean.getListImgFile();
            //获得文件的原始名称
            String lisgImageOrginalName = listImageFile.getOriginalFilename();
            //获得原始文件的后缀
            String listImageSuffixName = lisgImageOrginalName.substring(lisgImageOrginalName.lastIndexOf("."));
            //新文件名
            String listImageFileNewName = pid + "_listimg" + listImageSuffixName;

            //通过产品主目录+pid+_listimg+原始文件后缀名，计算出文件转移的路径
            String listImageTransferFilename = productMainFolderPath + listImageFileNewName;

            try {
                productBean.getListImgFile().transferTo(new File(listImageTransferFilename));
            } catch (IOException e) {
                e.printStackTrace();
                System.out.println(e.getMessage());
            }
            //计算列表图片在工程中的相对路径，用于记录到数据库
            String listImageFileRelPath = Constant.uploadDbPrefixPath + pid + "/" + listImageFileNewName;

            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            conn = DBConnUtil.getDataSource().getConnection();
            conn.setAutoCommit(false);
            runner.update(conn,"insert into product(pid,pname,type,price,derateProportion," +
                    "introduction,indexplay,indexsort,uid,createdatetime,listimage) " +
                    "                       values(?,    ?,   ?,    ?,       ?,   " +
                    "  ?,             ?,         ?,    ?,       ?,          ?) ",
                    pid,productBean.getPname(),productBean.getType(),productBean.getPrice(),productBean.getDerateProportion(),
                    productBean.getIntroduction(),productBean.getIndexPlay(),productBean.getIndexSort(),productBean.getUid(),new Date(),
                    listImageFileRelPath);
            List<MultipartFile> mainImgFiles = productBean.getMainImgFiles();

            //处理产品主图
            for(int i = 1; i <= mainImgFiles.size(); i++){
                MultipartFile mainImgFile = mainImgFiles.get(i-1);
                String mainImageOrginalName = mainImgFile.getOriginalFilename();
                String mainImageSuffixName = mainImageOrginalName.substring(mainImageOrginalName.lastIndexOf("."));
                //重新编号之后的 新文件名
                String mainImageFileNewName = pid + "_mainimg_"+ i + mainImageSuffixName;
                //存储到数据库中的相对路径+新文件名
                String mainImageFileRelPath = Constant.uploadDbPrefixPath +  pid +  "/" + mainImageFileNewName;

                String mainImageTransferFilename = productMainFolderPath + mainImageFileNewName;
                try {
                    mainImgFile.transferTo(new File(mainImageTransferFilename));
                } catch (IOException e) {
                    e.printStackTrace();
                    System.out.println(e.getMessage());
                }
                runner.update(conn,"insert into product_image(imageid,path,pid) "+
                                "                           values(?,    ?,   ?) ",
                              pid + "_" + i, mainImageFileRelPath, pid);

            }
            conn.commit();
            conn.setAutoCommit(true);
        } catch (SQLException e) {
            try {
                conn.rollback();
                fileService.deleteFolder(productMainFolderPath);
            } catch (SQLException e1) {
                e1.printStackTrace();
            }

            e.printStackTrace();
        }
        return true;
    }
}
