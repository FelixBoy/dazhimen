package dazhimen.bg.service;

import dazhimen.bg.bean.*;
import dazhimen.bg.exception.BgException;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import util.Constant;
import util.IdUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * Created by Administrator on 2017/3/17.
 */
public class ProductService {
    public UploadCourseBean getCourseInforByCourseid(String courseid) throws BgException {
        UploadCourseBean courseBean = null;
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            courseBean = sqlSession.selectOne("dazhimen.bg.bean.Product.getCourseInforByCourseid", courseid);
        } catch (Exception e) {
            e.printStackTrace();
            throw new BgException("出现异常，查询指定课程信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return courseBean;
    }
    public List<ListViewCourseBean> queryAllCourseByPid(String pid) throws BgException {
        List<ListViewCourseBean> courseBeans = null;
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            courseBeans = sqlSession.selectList("dazhimen.bg.bean.Product.queryAllCourseByPid", pid);
        } catch (Exception e) {
            e.printStackTrace();
            throw new BgException("出现异常，查询产品的课程失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return courseBeans;
    }
    /**
     * 通过uid获取 制定掌门的信息
     * @param uid 要获取信息的掌门ID
     * @return 返回要获取的掌门信息
     */
    public UserBean getMasterDataByUid(String uid) throws BgException {
        UserBean user = null;
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            user = sqlSession.selectOne("dazhimen.bg.bean.Product.getMasterDataByUid", uid);
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询指定掌门信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return user;
    }
    /**
     * 查询所有掌门的信息
     * @return 包含所有掌门信息的 list
     */
    public List<UserBean> queryAllMasters() throws BgException {
        List<UserBean> userBeans = null;
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            userBeans = sqlSession.selectList("dazhimen.bg.bean.Product.listAllMasters");
        } catch (Exception e) {
            e.printStackTrace();
            throw new BgException("出现异常，查询所有掌门信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return userBeans;
    }
    public void saveCourseDel(String courseid,String pid, HttpServletRequest resq) throws BgException {
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            sqlSession.delete("dazhimen.bg.bean.Product.saveCourseDel", courseid);
            String audioFolderPath = resq.getSession().getServletContext().getRealPath("/") + Constant.productPrefixPath  + pid + "\\course\\";
            String audioFileName = audioFolderPath + courseid+ ".mp3";
            FileManageService fileService = new FileManageService();
            fileService.deleteFile(audioFileName);
            sqlSession.commit();
        } catch (Exception e) {
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException("出现异常，删除课程信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
    public String saveModifyCourse(UploadCourseBean courseBean) throws BgException{
        if(courseBean.getIstry() == null || courseBean.getIstry().equals("")){
            courseBean.setIstry("0");
        }
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            sqlSession.update("dazhimen.bg.bean.Product.saveModifyCourse", courseBean);
            CommonsMultipartFile audioFile = courseBean.getAudio();
            if(audioFile != null && !audioFile.isEmpty()){
                String cousreMainFolderPath = courseBean.getBasePath() + Constant.productPrefixPath  + courseBean.getPid() + "\\course\\";
                //获得文件的原始名称
                String audioOrginalName = audioFile.getOriginalFilename();
                //获得原始文件的后缀
                String audioSuffixName = audioOrginalName.substring(audioOrginalName.lastIndexOf("."));
                //新文件名
                String audioFileNewName = courseBean.getCourseid() + audioSuffixName;
                //通过课程主目录+pid+_listimg+原始文件后缀名，计算出文件转移的路径
                String audioFileTransferFilename = cousreMainFolderPath + audioFileNewName;
                try {
                    audioFile.transferTo(new File(audioFileTransferFilename));
                } catch (IOException e) {
                    e.printStackTrace();
                    throw new BgException("出现异常，保存课程音频失败");
                }
            }
            sqlSession.commit();
        } catch (Exception e) {
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException("出现异常，修改课程信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return courseBean.getPid();
    }
    public String saveAddCourse(UploadCourseBean courseBean) throws BgException {
        //1 生成courseid
        String courseid = new IdUtils().getCourseid();
        //2 获得课程所属的pid
        String pid = courseBean.getPid();
        //2 计算课程主目录路径
        //工程所在路径+ proPrefixPath + pid + course
        String cousreMainFolderPath = courseBean.getBasePath() + Constant.productPrefixPath  + pid + "\\course\\";
        FileManageService fileService = new FileManageService();
        try {
            fileService.createFolder(cousreMainFolderPath);
        } catch (BgException e) {
            e.printStackTrace();
            throw new BgException("保存课程信息出错");
        }
            CommonsMultipartFile audioFile = courseBean.getAudio();
            //获得文件的原始名称
            String audioOrginalName = audioFile.getOriginalFilename();
            //获得原始文件的后缀
            String audioSuffixName = audioOrginalName.substring(audioOrginalName.lastIndexOf("."));
            //新文件名
            String audioFileNewName = courseid + audioSuffixName;
            //通过课程主目录+pid+_listimg+原始文件后缀名，计算出文件转移的路径
            String audioFileTransferFilename = cousreMainFolderPath + audioFileNewName;

            try {
                audioFile.transferTo(new File(audioFileTransferFilename));
            } catch (IOException e) {
                e.printStackTrace();
                throw new BgException("出现异常，保存课程音频失败");
            }
            //计算列表图片在工程中的相对路径，用于记录到数据库
            String audioFileRelPath = Constant.uploadProductDbPrefixPath + pid + "/course/" + audioFileNewName;
            SqlSession sqlSession = null;
            try {
                sqlSession = MyBatisUtil.createSession();
                courseBean.setAudiopath(audioFileRelPath);
                courseBean.setCourseid(courseid);
                sqlSession.insert("dazhimen.bg.bean.Product.saveAddCourse", courseBean);
                sqlSession.commit();
            } catch (Exception e) {
                e.printStackTrace();
                sqlSession.rollback();
                fileService.deleteFile(audioFileTransferFilename);
                throw new BgException("出现异常，保存课程信息出错");
            }finally {
                MyBatisUtil.closeSession(sqlSession);
            }
        return pid;
    }
    public String saveAddProduct(UploadProductBean productBean) throws BgException{
        //1 生成pid
        String pid = new IdUtils().getPid();
        //2 计算产品主目录路径
        //工程所在路径+ proPrefixPath + pid_pname
        String productMainFolderPath = productBean.getBasePath() + Constant.productPrefixPath  + pid + "\\";
        FileManageService fileService = new FileManageService();
        try{
            fileService.createFolder(productMainFolderPath);
        }catch (BgException e){
            e.printStackTrace();
            throw new BgException("出现异常,创建产品主目录失败");
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
                throw new BgException("出现异常,保存产品列表图片失败");
            }
            //计算列表图片在工程中的相对路径，用于记录到数据库
            String listImageFileRelPath = Constant.uploadProductDbPrefixPath + pid + "/" + listImageFileNewName;

            SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            productBean.setListimage(listImageFileRelPath);
            productBean.setPid(pid);
            sqlSession.insert("dazhimen.bg.bean.Product.saveAddProduct", productBean);

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
                String mainImageFileRelPath = Constant.uploadProductDbPrefixPath +  pid +  "/" + mainImageFileNewName;

                String mainImageTransferFilename = productMainFolderPath + mainImageFileNewName;
                try {
                    mainImgFile.transferTo(new File(mainImageTransferFilename));
                } catch (IOException e) {
                    e.printStackTrace();
                    sqlSession.rollback();
                    fileService.deleteFolder(productMainFolderPath);
                    throw new BgException("出现异常,保存产品主图-" + i + "失败");
                }
                AddProductImageBean productImageBean = new AddProductImageBean();
                productImageBean.setImageid(pid + "_" + i);
                productImageBean.setPid(pid);
                productImageBean.setPath(mainImageFileRelPath);
               sqlSession.insert("dazhimen.bg.bean.Product.saveAddProductImage", productImageBean);

            }
            sqlSession.commit();
        } catch (Exception e) {
                sqlSession.rollback();
                fileService.deleteFolder(productMainFolderPath);
                e.printStackTrace();
            throw new BgException("出现异常,保存产品信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return pid;
    }

    public ViewProductBean getProductInforById(String pid) throws BgException {
        ViewProductBean productBean = null;
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            productBean = sqlSession.selectOne("dazhimen.bg.bean.Product.getProductInforById", pid);
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询指定产品信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return productBean;
    }

    public List<ViewMainImageBean> getProductMainImages(String pid) throws BgException {
        List<ViewMainImageBean> mainImageBeans = null;
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            mainImageBeans = sqlSession.selectList("dazhimen.bg.bean.Product.getProductMainImages", pid);
        } catch (Exception e) {
            e.printStackTrace();
            throw new BgException("出现异常，查询产品主图信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return mainImageBeans;
    }

    public List<ListViewProductBean> queryAllProducts() throws BgException {
        List<ListViewProductBean> productBeans = null;
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            productBeans = sqlSession.selectList("dazhimen.bg.bean.Product.listAllProduct");
        } catch (Exception e) {
            e.printStackTrace();
            throw new BgException("出现异常，查询所有产品信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return productBeans;
    }
    public void saveModifyProductStatus(String pid, String status) throws BgException {
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            ModifyProductStatusBean productStatusBean = new ModifyProductStatusBean();
            productStatusBean.setPid(pid);
            productStatusBean.setStatus(status);
            sqlSession.update("dazhimen.bg.bean.Product.saveModifyProductStatus",productStatusBean);
            sqlSession.commit();
        } catch (Exception e) {
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException("出现异常，修改产品状态失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
    public void saveProductDel(String pid, HttpServletRequest resq) throws BgException {
        SqlSession sqlSession = null;
        try {
            //检查产品状态，前台也要检查，上架和预告状态的产品，不允许删除。
            //检查产品的 已购状态
            //检查产品的 收藏状态
            //检查产品下的 课程情况
            sqlSession = MyBatisUtil.createSession();
            sqlSession.delete("dazhimen.bg.bean.Product.saveProductImageDel", pid);
            sqlSession.delete("dazhimen.bg.bean.Product.saveCourseDelByPid", pid);
            sqlSession.update("dazhimen.bg.bean.Product.saveProductDel", pid);
            String productMainFolderPath = resq.getSession().getServletContext().getRealPath("/") + Constant.productPrefixPath  + pid + "\\";
            FileManageService fileService = new FileManageService();
            fileService.deleteFolder(productMainFolderPath);
            sqlSession.commit();
        } catch (Exception e) {
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException("出现异常，删除产品失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
}
