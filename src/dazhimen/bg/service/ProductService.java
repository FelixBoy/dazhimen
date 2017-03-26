package dazhimen.bg.service;

import com.alibaba.druid.pool.DruidPooledConnection;
import dazhimen.bg.bean.*;
import dazhimen.bg.exception.BgException;
import db.DBConnUtil;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import util.Constant;
import util.IdUtils;

import javax.servlet.http.HttpServletRequest;
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
     * 通过uid获取 制定掌门的信息
     * @param uid 要获取信息的掌门ID
     * @return 返回要获取的掌门信息
     */
    public UserBean getMasterDataByUid(String uid){
        UserBean user = null;
        try {
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            StringBuffer sqlBF = new StringBuffer();
            sqlBF.append("select uid,name,mphone,gender,loginname,date_format(createdate,'%Y-%m-%d %H:%i:%s') as createDatestr,remarks ");
            sqlBF.append("  from user ");
            sqlBF.append(" where uid = ? ");
            user = runner.query(sqlBF.toString(), new BeanHandler<UserBean>(UserBean.class),uid);
        }catch (SQLException e){
            e.printStackTrace();
        }

        return user;
    }
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

    public String saveAddProduct(UploadProductBean productBean) throws BgException{
        DruidPooledConnection conn = null;
        //1 生成pid
        String pid = IdUtils.getPid();
        //2 计算产品主目录路径
        //工程所在路径+ proPrefixPath + pid_pname
        String productMainFolderPath = productBean.getBasePath() + Constant.proPrefixPath  + pid + "\\";
        FileManageService fileService = new FileManageService();
        fileService.createFolder(productMainFolderPath);
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
                throw new BgException("保存产品列表图片失败");
            }
            //计算列表图片在工程中的相对路径，用于记录到数据库
            String listImageFileRelPath = Constant.uploadDbPrefixPath + pid + "/" + listImageFileNewName;
        try {
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            conn = DBConnUtil.getDataSource().getConnection();

             conn.setAutoCommit(false);
             runner.update(conn,"insert into product(pid,pname,type,price,derateProportion," +
                    "introduction,indexplay,indexsort,uid,createdatetime,listimage,updatedatetime) " +
                    "                       values(?,    ?,   ?,    ?,       ?,   " +
                    "  ?,             ?,         ?,    ?,       ?,          ?,   ?) ",
                    pid,productBean.getPname(),productBean.getType(),productBean.getPrice(),productBean.getDerateProportion(),
                    productBean.getIntroduction(),productBean.getIndexPlay(),productBean.getIndexSort(),productBean.getUid(),new Date(),
                    listImageFileRelPath,new Date());
            List<MultipartFile> mainImgFiles = productBean.getMainImgFiles();

            //处理产品主图
            for(int i = 1; i <= mainImgFiles.size(); i++){
                MultipartFile mainImgFile = mainImgFiles.get(i-1);
                if(mainImgFile.isEmpty()){
                    continue;
                }
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
                    throw new BgException("保存产品主图-" + i + "失败");
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
                throw new BgException("事务回滚出错");
            }
            e.printStackTrace();
            throw new BgException("保存商品信息出错");
        }
        return pid;
    }

    public ViewProductBean getProductInforById(String pid){
        ViewProductBean productBean = null;
        try {
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            StringBuffer sqlBF = new StringBuffer();
            sqlBF.append("select pid,pname,getcodetxt('producttype',a.type) as type,price,derateProportion," +
                    "a.introduction,getcodetxt('indexsort',indexsort) as indexsort,getcodetxt('rightorwrong',indexplay) as indexplay," +
                    "listimage,b.uid,b.name as uname,b.mphone,b.loginname,getcodetxt('gender',b.gender) as gender ");
            sqlBF.append("  from product a, ");
            sqlBF.append("       user b ");
            sqlBF.append(" where pid = ? and a.isdel = '0' ");
            sqlBF.append("   and a.uid = b.uid ");
            productBean = runner.query(sqlBF.toString(), new BeanHandler<ViewProductBean>(ViewProductBean.class),pid);
        }catch (SQLException e){
            e.printStackTrace();
        }
        return productBean;
    }

    public List<ViewMainImageBean> getProductMainImages(String pid){
        List<ViewMainImageBean> mainImageBeans = null;
        try {
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            mainImageBeans = runner.query("select imageid,path as mainimage " +
                            " from product_image where pid = ? ",
                    new BeanListHandler<ViewMainImageBean>(ViewMainImageBean.class), pid);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return mainImageBeans;
    }

    public List<ListViewProductBean> queryAllProducts(){
        List<ListViewProductBean> productBeans = null;
        try {
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            productBeans = runner.query(" select pid,pname,getcodetxt('producttype',a.type) type," +
                            " getcodetxt('productstatus',a.status) status,a.status statusnum," +
                            " date_format(a.createdatetime,'%Y-%m-%d %H:%i:%s') createtime," +
                            " b.name uname " +
                            " from product a, user b " +
                            " where a.uid = b.uid and a.isdel = '0' " +
                            " order by indexsort,createdatetime desc ",
                    new BeanListHandler<ListViewProductBean>(ListViewProductBean.class));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productBeans;
    }
    public void saveModifyProductStatus(String pid, String status){
        try {
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            runner.update("update product set status = ? where pid = ? ", status, pid);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void saveProductDel(String pid, HttpServletRequest resq){
        try {
            QueryRunner runner = new QueryRunner(DBConnUtil.getDataSource());
            runner.update(" delete from product_image where pid = ? ", pid);
            runner.update(" update product set isdel = '1' where pid = ? ", pid);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        String productMainFolderPath = resq.getSession().getServletContext().getRealPath("/") + Constant.proPrefixPath  + pid + "\\";

        FileManageService fileService = new FileManageService();
        fileService.deleteFolder(productMainFolderPath);
    }
}
