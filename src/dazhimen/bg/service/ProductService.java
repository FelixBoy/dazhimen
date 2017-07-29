package dazhimen.bg.service;

import dazhimen.bg.bean.news.*;
import dazhimen.bg.bean.product.CourseSortDataBean;
import dazhimen.bg.bean.*;
import dazhimen.bg.bean.product.*;
import dazhimen.bg.bean.user.UserBean;
import dazhimen.bg.exception.BgException;
import db.MyBatisUtil;
import net.sf.json.JSONObject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import util.*;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2017/3/17.
 */
public class ProductService {
    public void saveModifyViewCount(String courseid, String viewcount) throws BgException {
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            UpdateViewCountBean viewCountBean = new UpdateViewCountBean();
            viewCountBean.setCourseid(courseid);
            viewCountBean.setViewcount(viewcount);
            sqlSession.update("dazhimen.bg.bean.Product.saveModifyViewCount", viewCountBean);
            sqlSession.commit();
        }catch (Exception e){
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException("出现异常，修改已读人数失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }

    public void saveModifyBuyCount(String pid, String buycount) throws BgException{
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            UpdateBuyCountBean buyCountBean = new UpdateBuyCountBean();
            buyCountBean.setPid(pid);
            buyCountBean.setBuycount(buycount);
            sqlSession.update("dazhimen.bg.bean.Product.saveModifyBuyCount", buyCountBean);
            sqlSession.commit();
        }catch (Exception e){
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException("出现异常，修改已购人数失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }

    }
    /**
     * 保存新增新闻信息
     * @param basePath
     * @throws BgException
     */
    public void saveAddCI(String pid, String courseid, List<NewsContentBean> newsContentBeans, String basePath) throws BgException {
        IdUtils idUtils = new IdUtils();
        //2 计算新闻主目录路径
        String cousreMainFolderPath = basePath + Constant.productPrefixPath  + pid + "\\course\\";
        FileManageService fileService = new FileManageService();
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            for(int i = 0; i < newsContentBeans.size(); i++){
                NewsContentBean contentBean = newsContentBeans.get(i);
                String contentId = idUtils.getCourseIntroductionId();
                String contenteType = contentBean.getContenttype();

               if(contenteType.equals("2")){
                    CommonsMultipartFile contentFile = contentBean.getContentfile();
                    //获得列表图片文件的原始名称
                    String contentFileOrginalName = contentFile.getOriginalFilename();
                    //获得原始文件的后缀
                    String contentFileSuffixName = contentFileOrginalName.substring(contentFileOrginalName.lastIndexOf("."));
                    //新文件名
                    String contentFileNewName = courseid + "_" + contentId + "_contentimg" + contentFileSuffixName.toLowerCase();

                    //通过产品主目录+pid+_listimg+原始文件后缀名，计算出文件转移的路径
                    String contentFileTransferFilename = cousreMainFolderPath + contentFileNewName;

                    try {
                        contentFile.transferTo(new File(contentFileTransferFilename));
                    } catch (IOException e) {
                        e.printStackTrace();
                        throw new BgException("出现异常,保存新闻内容图片失败");
                    }
                    //计算列表图片在工程中的相对路径，用于记录到数据库
                    String contentFileRelPath = Constant.uploadProductDbPrefixPath + pid + "/course/" + contentFileNewName;
                    contentBean.setContentvalue(contentFileRelPath);
                }else{
                    contentBean.setContentvalue(contentBean.getContenttext());
                }
                contentBean.setContentid(contentId);
                contentBean.setNid(courseid);
                sqlSession.insert("dazhimen.bg.bean.Product.saveAddCI", contentBean);
            }
            sqlSession.commit();
        }catch (Exception e){
            sqlSession.rollback();
            throw new BgException("出现异常，添加新闻失败");
        } finally{
            MyBatisUtil.closeSession(sqlSession);
        }
    }
    public void modifyNewsContentText(String courseid, String contentid, String text, String basePath) throws BgException {
        if(courseid == null || courseid.equals("")){
            throw new BgException("传入的courseid为空，修改内容文本失败");
        }
        if(contentid == null || contentid.equals("")){
            throw new BgException("传入的contentid为空，修改内容文本失败");
        }
        if(text == null || text.equals("")){
            throw new BgException("传入的text为空，修改内容文本失败");
        }
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            ModifyNewsSubtitleBean newsSubtitleBean = new ModifyNewsSubtitleBean();
            newsSubtitleBean.setContentid(contentid);
            newsSubtitleBean.setContentvalue(text);
            sqlSession.update("dazhimen.bg.bean.Product.modifyCIText", newsSubtitleBean);
            sqlSession.commit();
        }catch(Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，修改内容文本失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
    public void deleteCIText(String courseid, String contentid, String basePath) throws BgException {
        if(courseid == null || courseid.equals("")){
            throw new BgException("传入的courseid为空，删除文本失败");
        }
        if(contentid == null || contentid.equals("")){
            throw new BgException("传入的contentid为空，删除文本失败");
        }
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            String contentSort = sqlSession.selectOne("dazhimen.bg.bean.Product.getContentSortById" ,contentid);
            if(contentSort == null || contentSort.equals("")){
                throw new BgException("获取内容的排序信息异常");
            }
            sqlSession.delete("dazhimen.bg.bean.Product.deleleContent", contentid);
            DealNewsContentSortBean dealNewsContentSortBean = new DealNewsContentSortBean();
            dealNewsContentSortBean.setNid(courseid);
            dealNewsContentSortBean.setSort(contentSort);
            sqlSession.update("dazhimen.bg.bean.Product.dealContentSort", dealNewsContentSortBean);
            sqlSession.commit();
        }catch(BgException e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException(e.getMessage());
        } catch(Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，删除文本失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
    public void saveModifyCIImg(String pid, String courseid, String contentid, CommonsMultipartFile contentImgFile, String bashPath) throws BgException {
        SqlSession sqlSession = null;
        if(pid == null || pid.equals("")){
            throw new BgException("传入的pid为空，修改图片失败");
        }
        if(courseid == null || courseid.equals("")){
            throw new BgException("传入的courseid为空，修改图片失败");
        }
        if(contentid == null || contentid.equals("")){
            throw new BgException("传入的nid为空，修改图片失败");
        }
        if(contentImgFile == null || contentImgFile.isEmpty()){
            throw new BgException("传入的contentImgFile为空，修改图片失败");
        }
        try {
            if(contentImgFile != null && !contentImgFile.isEmpty()) {
                sqlSession = MyBatisUtil.createSession();
                String contentImgPath = sqlSession.selectOne("dazhimen.bg.bean.Product.getCIImgPath", contentid);
                if (contentImgPath == null || contentImgPath.equals("")) {
                    throw new BgException("出现异常，查询原内容图片路径时出错");
                }
                String contentImgFileOldName = contentImgPath.substring(contentImgPath.lastIndexOf("/") + 1);
                String courseMainFolderPath = bashPath + Constant.productPrefixPath  + pid + "\\course\\";
                //获得文件的原始名称
                String contentImgFileOrginalName = contentImgFile.getOriginalFilename();
                //获得原始文件的后缀
                String contentImgFileSuffixName = contentImgFileOrginalName.substring(contentImgFileOrginalName.lastIndexOf("."));
                //新文件名
                String contentImageFileNewName = courseid + "_" + contentid + "_contentimg" + contentImgFileSuffixName.toLowerCase();
                //通过产品主目录+pid+_listimg+原始文件后缀名，计算出文件转移的路径
                String contentImageTransferFilename = courseMainFolderPath + contentImageFileNewName;
                try {
                    contentImgFile.transferTo(new File(contentImageTransferFilename));
                } catch (IOException e) {
                    e.printStackTrace();
                    throw new BgException("出现异常，修改内容图片失败");
                }
                if(!contentImgFileOldName.equals(contentImageFileNewName)){
                    FileManageService fileManageService = new FileManageService();
                    fileManageService.deleteFile(courseMainFolderPath + contentImgFileOldName);
                    //计算新闻主图图片在工程中的相对路径，用于记录到数据库
                    String contentImageNewFileRelPath = Constant.uploadProductDbPrefixPath + pid + "/course/" + contentImageFileNewName;
                    ModifyNewsSubtitleBean modifyNewsContentBean = new ModifyNewsSubtitleBean();
                    modifyNewsContentBean.setContentid(contentid);
                    modifyNewsContentBean.setContentvalue(contentImageNewFileRelPath);
                    sqlSession.update("dazhimen.bg.bean.Product.updateContentImgPath",modifyNewsContentBean);
                }
                sqlSession.commit();
            }
        }catch(BgException e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException(e.getMessage());
        } catch(Exception e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，修改新闻文本失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
    public void deleteCIImg(String pid, String courseid, String contentid, String basePath) throws BgException {
        if(pid == null || pid.equals("")){
            throw new BgException("传入的pid为空，删除图片失败");
        }
        if(courseid == null || courseid.equals("")){
            throw new BgException("传入的courseid为空，删除图片失败");
        }
        if(contentid == null || contentid.equals("")){
            throw new BgException("传入的contentid为空，删除图片失败");
        }
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            String contentSort = sqlSession.selectOne("dazhimen.bg.bean.Product.getContentSortById" ,contentid);
            if(contentSort == null || contentSort.equals("")){
                throw new BgException("获取内容的排序信息异常");
            }
            String contentImgPath = sqlSession.selectOne("dazhimen.bg.bean.Product.getCIImgPath", contentid);
            if (contentImgPath == null || contentImgPath.equals("")) {
                throw new BgException("出现异常，查询原内容图片路径时出错");
            }
            String contentImgFileName = contentImgPath.substring(contentImgPath.lastIndexOf("/") + 1);

            sqlSession.delete("dazhimen.bg.bean.Product.deleleContent", contentid);
            DealNewsContentSortBean dealNewsContentSortBean = new DealNewsContentSortBean();
            dealNewsContentSortBean.setNid(courseid);
            dealNewsContentSortBean.setSort(contentSort);
            sqlSession.update("dazhimen.bg.bean.Product.dealContentSort", dealNewsContentSortBean);

            String courseMainFolderPath = basePath + Constant.productPrefixPath  + pid + "\\course\\";
            FileManageService fileManageService = new FileManageService();
            fileManageService.deleteFile(courseMainFolderPath + contentImgFileName);
            sqlSession.commit();
        }catch(BgException e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException(e.getMessage());
        } catch(Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，删除图片失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
    public String getCourseSortData(String pid) throws BgException {
        SqlSession sqlSession = null;
        List<CourseSortDataBean> courseSortDataBeans = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            courseSortDataBeans = sqlSession.selectList("dazhimen.bg.bean.Product.getCourseSortData",pid);
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，获取课程排序信息出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return getCourseSortString(courseSortDataBeans);
    }
    private String getCourseSortString(List<CourseSortDataBean> sortDataBeans){
        if(sortDataBeans == null || sortDataBeans.size() == 0){
            return "1,2,3,4,5";
        }
        if(sortDataBeans.size() >= 5){
            return "";
        }
        ArrayList<String> arrayList = new ArrayList<String>();
        for(int i = 0; i < sortDataBeans.size(); i++){
            arrayList.add(sortDataBeans.get(i).getSort());
        }
        StringBuffer sortBF = new StringBuffer();
        for(int i = 1; i < 6; i++){
            if(!arrayList.contains(i+"")){
                sortBF.append(i + ",");
            }
        }
        if(sortBF.length() <= 1){
            return "";
        }else{
            return sortBF.deleteCharAt(sortBF.length() - 1).toString();
        }
    }
    public List<ViewNewsContentBean> getCourseIntroductionData(String courseid) throws BgException {
        List<ViewNewsContentBean> newsContentBeans = null;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            newsContentBeans = sqlSession.selectList("dazhimen.bg.bean.Product.getCourseIntroductionData", courseid);
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，获取课程介绍出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return newsContentBeans;
    }
    public UploadCourseBean getViewCourseInforByCourseid(String courseid) throws BgException {
        UploadCourseBean courseBean = null;
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            courseBean = sqlSession.selectOne("dazhimen.bg.bean.Product.getViewCourseInforByCourseid", courseid);
            List<GenNewsContentBean> contentBeans = sqlSession.selectList("dazhimen.bg.bean.Product.getCourseIntroductionById", courseid);
            String courseIntroductionHtml = GenNewsHtmlUtil.genBrowseCourseIntroductionHtml(courseBean.getCoursename(), contentBeans);
            courseBean.setCourseIntroductionHtml(courseIntroductionHtml);
        } catch (Exception e) {
            e.printStackTrace();
            throw new BgException("出现异常，查询指定课程信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return courseBean;
    }
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
    public Integer getAllCourseCountByPid(String pid) throws BgException {
        SqlSession sqlSession = null;
        Integer totalCount = 0;
        try {
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean allCourseCountValue = sqlSession.selectOne("dazhimen.bg.bean.Product.getAllCourseCountByPid", pid);
            if(allCourseCountValue == null || allCourseCountValue.getValueInfo() == null){
                throw new BgException("获取课程数据总条数出错");
            }
            totalCount = Integer.parseInt(allCourseCountValue.getValueInfo());
        } catch (Exception e) {
            e.printStackTrace();
            throw new BgException("出现异常，获取课程数据总条数失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return totalCount;
    }
    public List<ListViewCourseBean> queryAllCourseByPid(String pid, String page, String rows) throws BgException {
        List<ListViewCourseBean> courseBeans = null;
        SqlSession sqlSession = null;
        Integer totalCount = 0;
        try {
            sqlSession = MyBatisUtil.createSession();
            PaginationParamBean paramBean = PaginationUtil.getPaginationParamBean(page,rows);
            paramBean.setPid(pid);
            courseBeans = sqlSession.selectList("dazhimen.bg.bean.Product.queryAllCourseByPid", paramBean);
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

    public List<UserBean> queryAllMastersByParams(QueryMasterParamBean paramBean) throws BgException {
        List<UserBean> userBeans = null;
        SqlSession sqlSession = null;
        Integer totalCount = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            paramBean.setGetrows(10000000);
            paramBean.setStartnum(0);
            userBeans = sqlSession.selectList("dazhimen.bg.bean.Product.listAllMastersByParams", paramBean);
        } catch (Exception e) {
            e.printStackTrace();
            throw new BgException("出现异常，查询所有掌门信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return userBeans;
    }
    /**
     * 查询所有掌门的信息
     * @return 包含所有掌门信息的 list
     */
    public List<UserBean> queryAllMasters() throws BgException {
        List<UserBean> userBeans = null;
        SqlSession sqlSession = null;
        Integer totalCount = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            PaginationParamBean paramBean = new PaginationParamBean();
            paramBean.setStartnum(0);
            paramBean.setGetrows(10000000);
            userBeans = sqlSession.selectList("dazhimen.bg.bean.Product.listAllMasters", paramBean);
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
            List<QueryCIImgPathBean> ciImgPathBeans = sqlSession.selectList("dazhimen.bg.bean.Product.getCourseIntroductionImg", courseid);
            sqlSession.delete("dazhimen.bg.bean.Product.saveCourseIntroductionDel", courseid);
            String audioFolderPath = resq.getSession().getServletContext().getRealPath("/") + Constant.productPrefixPath  + pid + "\\course\\";
            String audioFileName = audioFolderPath + courseid+ ".mp3";
            FileManageService fileService = new FileManageService();
            fileService.deleteFile(audioFileName);
            for(int i = 0 ; i < ciImgPathBeans.size(); i++){
                String contentImgPath = ciImgPathBeans.get(i).getPath();
                String contentImgFileName = contentImgPath.substring(contentImgPath.lastIndexOf("/") + 1);
                fileService.deleteFile(audioFolderPath + contentImgFileName);
            }
            sqlSession.commit();
            dealProductIstry(pid);
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
            CommonsMultipartFile audioFile = courseBean.getAudio();
            if(audioFile != null && !audioFile.isEmpty()){
                String cousreMainFolderPath = courseBean.getBasePath() + Constant.productPrefixPath  + courseBean.getPid() + "\\course\\";

                long fileSizeByte = audioFile.getSize();
                Double filesize = GlobalUtils.bytes2kb(fileSizeByte);
                //获得文件的原始名称
                String audioOrginalName = audioFile.getOriginalFilename();
                courseBean.setFilename(audioOrginalName);
                courseBean.setFilesize(filesize);
                //获得原始文件的后缀
                String audioSuffixName = audioOrginalName.substring(audioOrginalName.lastIndexOf("."));
                //新文件名
                String audioFileNewName = courseBean.getCourseid() + audioSuffixName.toLowerCase();
                //通过课程主目录+pid+_listimg+原始文件后缀名，计算出文件转移的路径
                String audioFileTransferFilename = cousreMainFolderPath + audioFileNewName;
                try {
                    audioFile.transferTo(new File(audioFileTransferFilename));
                } catch (IOException e) {
                    e.printStackTrace();
                    throw new BgException("出现异常，保存课程音频失败");
                }
            }
            sqlSession.update("dazhimen.bg.bean.Product.saveModifyCourse", courseBean);
            sqlSession.commit();
            dealProductIstry(courseBean.getPid());
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
        IdUtils idUtils = new IdUtils();
        String courseid = idUtils.getCourseid();
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
            long fileSizeByte = audioFile.getSize();
            Double fileSizeMB = GlobalUtils.bytes2kb(fileSizeByte);
            //获得文件的原始名称
            String audioOrginalName = audioFile.getOriginalFilename();
            //获得原始文件的后缀
            String audioSuffixName = audioOrginalName.substring(audioOrginalName.lastIndexOf("."));
            //新文件名
            String audioFileNewName = courseid + audioSuffixName.toLowerCase();
            //通过课程主目录+pid+_listimg+原始文件后缀名，计算出文件转移的路径
            String audioFileTransferFilename = cousreMainFolderPath + audioFileNewName;

            try {
                audioFile.transferTo(new File(audioFileTransferFilename));
            } catch (IOException e) {
                e.printStackTrace();
                throw new BgException("出现异常，保存课程音频失败");
            }
            String audioFileRelPath = Constant.uploadProductDbPrefixPath + pid + "/course/" + audioFileNewName;
            SqlSession sqlSession = null;
            try {
                sqlSession = MyBatisUtil.createSession();
                courseBean.setAudiopath(audioFileRelPath);
                courseBean.setCourseid(courseid);
                courseBean.setFilesize(fileSizeMB);
                courseBean.setFilename(audioOrginalName);
                sqlSession.insert("dazhimen.bg.bean.Product.saveAddCourse", courseBean);

                List<NewsContentBean> newsContentBeans = courseBean.getContentBeans();
                for(int i = 0; i < newsContentBeans.size(); i++){
                    NewsContentBean contentBean = newsContentBeans.get(i);
                    String contentId = idUtils.getCourseIntroductionId();
                    String contenteType = contentBean.getContenttype();
                    if(contenteType.equals("2")){
                        CommonsMultipartFile contentFile = contentBean.getContentfile();
                        String contentFileOrginalName = contentFile.getOriginalFilename();
                        String contentFileSuffixName = contentFileOrginalName.substring(contentFileOrginalName.lastIndexOf("."));
                        String contentFileNewName = courseid + "_" + contentId + "_contentimg" + contentFileSuffixName.toLowerCase();
                        String contentFileTransferFilename = cousreMainFolderPath + contentFileNewName;

                        try {
                            contentFile.transferTo(new File(contentFileTransferFilename));
                        } catch (IOException e) {
                            e.printStackTrace();
                            throw new BgException("出现异常,保存内容图片失败");
                        }
                        //计算列表图片在工程中的相对路径，用于记录到数据库
                        String contentFileRelPath = Constant.uploadProductDbPrefixPath + pid + "/course/" + contentFileNewName;
                        contentBean.setContentvalue(contentFileRelPath);
                    }else{
                        contentBean.setContentvalue(contentBean.getContenttext());
                    }
                    contentBean.setContentid(contentId);
                    contentBean.setNid(courseid);
                    sqlSession.insert("dazhimen.bg.bean.Product.saveAddCourseIntroduction", contentBean);
                }
                sqlSession.commit();
                dealProductIstry(pid);
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
            String listImageOrginalName = listImageFile.getOriginalFilename();
            //获得原始文件的后缀
            String listImageSuffixName = listImageOrginalName.substring(listImageOrginalName.lastIndexOf("."));
            //新文件名
            String listImageFileNewName = pid + "_listimg" + listImageSuffixName.toLowerCase();

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
                String mainImageFileNewName = pid + "_mainimg_"+ i + mainImageSuffixName.toLowerCase();
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

    public ViewProductBean getModifyProductInforById(String pid) throws BgException {
        ViewProductBean productBean = null;
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            productBean = sqlSession.selectOne("dazhimen.bg.bean.Product.getModifyProductInforById", pid);
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询指定产品信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return productBean;
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
    public String queryAllProductsByParamsAndMaster(String page, String rows, QueryProductParamBean paramBean) throws BgException {
        List<ListViewProductBean> productBeans = null;
        SqlSession sqlSession = null;
        Integer totalCount = 0;
        try {
            sqlSession = MyBatisUtil.createSession();

            SingleValueBean allProductCountValue = sqlSession.selectOne("dazhimen.bg.bean.Product.getAllProductCountByParamAndMaster", paramBean);
            if(allProductCountValue == null || allProductCountValue.getValueInfo() == null){
                throw new BgException("获取产品数据总条数出错");
            }
            totalCount = Integer.parseInt(allProductCountValue.getValueInfo());
            PaginationParamBean paginationParamBean = PaginationUtil.getPaginationParamBean(page,rows);
            paramBean.setStartnum(paginationParamBean.getStartnum());
            paramBean.setGetrows(paginationParamBean.getGetrows());
            productBeans = sqlSession.selectList("dazhimen.bg.bean.Product.listAllProductByParamAndMaster", paramBean);
        } catch (Exception e) {
            e.printStackTrace();
            throw new BgException("出现异常，查询所有产品信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", totalCount);
        jsonObject.put("rows", productBeans);
        return jsonObject.toString();
    }
    public String queryAllProductsByParams(String page, String rows, QueryProductParamBean paramBean) throws BgException {
        List<ListViewProductBean> productBeans = null;
        SqlSession sqlSession = null;
        Integer totalCount = 0;
        try {
            sqlSession = MyBatisUtil.createSession();

            SingleValueBean allProductCountValue = sqlSession.selectOne("dazhimen.bg.bean.Product.getAllProductCountByParam", paramBean);
            if(allProductCountValue == null || allProductCountValue.getValueInfo() == null){
                throw new BgException("获取产品数据总条数出错");
            }
            totalCount = Integer.parseInt(allProductCountValue.getValueInfo());
            PaginationParamBean paginationParamBean = PaginationUtil.getPaginationParamBean(page,rows);
            paramBean.setStartnum(paginationParamBean.getStartnum());
            paramBean.setGetrows(paginationParamBean.getGetrows());
            productBeans = sqlSession.selectList("dazhimen.bg.bean.Product.listAllProductByParam", paramBean);
        } catch (Exception e) {
            e.printStackTrace();
            throw new BgException("出现异常，查询所有产品信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", totalCount);
        jsonObject.put("rows", productBeans);
        return jsonObject.toString();
    }
    public String queryAllProductsByMaster(String page,String rows, String userid) throws BgException {
        List<ListViewProductBean> productBeans = null;
        SqlSession sqlSession = null;
        Integer totalCount = 0;
        try {
            sqlSession = MyBatisUtil.createSession();

            SingleValueBean allProductCountValue = sqlSession.selectOne("dazhimen.bg.bean.Product.getAllProductCountByMaster", userid);
            if(allProductCountValue == null || allProductCountValue.getValueInfo() == null){
                throw new BgException("获取产品数据总条数出错");
            }
            totalCount = Integer.parseInt(allProductCountValue.getValueInfo());
            MasterPaginationParamBean paramBean = PaginationUtil.getMasterPaginationParamBean(page,rows, userid);
            productBeans = sqlSession.selectList("dazhimen.bg.bean.Product.listAllProductByMaster", paramBean);
        } catch (Exception e) {
            e.printStackTrace();
            throw new BgException("出现异常，查询所有产品信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", totalCount);
        jsonObject.put("rows", productBeans);
        return jsonObject.toString();
    }
    public String queryAllProducts(String page, String rows) throws BgException {
        List<ListViewProductBean> productBeans = null;
        SqlSession sqlSession = null;
        Integer totalCount = 0;
        try {
            sqlSession = MyBatisUtil.createSession();

            SingleValueBean allProductCountValue = sqlSession.selectOne("dazhimen.bg.bean.Product.getAllProductCount");
            if(allProductCountValue == null || allProductCountValue.getValueInfo() == null){
                throw new BgException("获取产品数据总条数出错");
            }
            totalCount = Integer.parseInt(allProductCountValue.getValueInfo());
            PaginationParamBean paramBean = PaginationUtil.getPaginationParamBean(page,rows);
            productBeans = sqlSession.selectList("dazhimen.bg.bean.Product.listAllProduct", paramBean);
        } catch (Exception e) {
            e.printStackTrace();
            throw new BgException("出现异常，查询所有产品信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", totalCount);
        jsonObject.put("rows", productBeans);
        return jsonObject.toString();
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
    public boolean saveModifyProductBasicInfo(ModifyProductBasicInfoBean productBean) throws BgException {
        SqlSession sqlSession = null;
        int result = 0;
        try{
            sqlSession = MyBatisUtil.createSession();
            result = sqlSession.update("dazhimen.bg.bean.Product.saveModifyProductBasicInfo", productBean);
            sqlSession.commit();
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，修改产品基本信息出错!");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }
    public void saveProductDel(String pid, HttpServletRequest resq) throws BgException {
        SqlSession sqlSession = null;
        try {
            //检查产品状态，前台也要检查，上架和预告状态的产品，不允许删除。
            //检查产品的 已购状态
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
    public void saveModifyProductListImg(String pid, CommonsMultipartFile listImgFile, String bashPath) throws BgException {
        SqlSession sqlSession = null;
        try {
            if(listImgFile != null && !listImgFile.isEmpty()){
                sqlSession = MyBatisUtil.createSession();
                String listImgPath = sqlSession.selectOne("dazhimen.bg.bean.Product.getListImgPath", pid);
                if(listImgPath == null || listImgPath.equals("")){
                    throw new BgException("出现异常，查询原产品列表图片路径时出错");
                }
                String listImgFileOldName = listImgPath.substring(listImgPath.lastIndexOf("/") + 1);
                String productMainFolderPath = bashPath + Constant.productPrefixPath  + pid + "\\";
                //获得文件的原始名称
                String listImgFileOrginalName = listImgFile.getOriginalFilename();
                //获得原始文件的后缀
                String listImgFileSuffixName = listImgFileOrginalName.substring(listImgFileOrginalName.lastIndexOf("."));
                //新文件名
                //通过课程主目录+pid+_listimg+原始文件后缀名，计算出文件转移的路径
                String listImageFileNewName = pid + "_listimg" + listImgFileSuffixName.toLowerCase();
                //通过产品主目录+pid+_listimg+原始文件后缀名，计算出文件转移的路径
                String listImageTransferFilename = productMainFolderPath + listImageFileNewName;
                try {
                    listImgFile.transferTo(new File(listImageTransferFilename));
                } catch (IOException e) {
                    e.printStackTrace();
                    throw new BgException("出现异常，修改产品列表图片失败");
                }
                if(!listImgFileOldName.equals(listImageFileNewName)){
                    FileManageService fileManageService = new FileManageService();
                    fileManageService.deleteFile(productMainFolderPath+listImgFileOldName);

                    //计算列表图片在工程中的相对路径，用于记录到数据库
                    String listImageNewFileRelPath = Constant.uploadProductDbPrefixPath + pid + "/" + listImageFileNewName;
                    UpdateListImgFilePathBean filePathBean = new UpdateListImgFilePathBean();
                    filePathBean.setPid(pid);
                    filePathBean.setListimage(listImageNewFileRelPath);
                    sqlSession.update("dazhimen.bg.bean.Product.updateListImgPath",filePathBean);
                    sqlSession.commit();
                }
            }
        } catch (BgException e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException(e.getMessage());
        } catch(Exception e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，修改产品列表图片失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }

    public void saveModifyProductMainImg(String pid, CommonsMultipartFile mainImgFile, String bashPath) throws BgException {
        SqlSession sqlSession = null;
        try {
            if(mainImgFile != null && !mainImgFile.isEmpty()){
                sqlSession = MyBatisUtil.createSession();
                String mainImgPath = sqlSession.selectOne("dazhimen.bg.bean.Product.getMainImgPath", pid);
                if(mainImgPath == null || mainImgPath.equals("")){
                    throw new BgException("出现异常，查询原产品主图路径时出错");
                }
                String mainImgFileOldName = mainImgPath.substring(mainImgPath.lastIndexOf("/") + 1);
                String productMainFolderPath = bashPath + Constant.productPrefixPath  + pid + "\\";
                //获得文件的原始名称
                String mainImgFileOrginalName = mainImgFile.getOriginalFilename();
                //获得原始文件的后缀
                String mainImgFileSuffixName = mainImgFileOrginalName.substring(mainImgFileOrginalName.lastIndexOf("."));
                //新文件名
                //通过课程主目录+pid+_listimg+原始文件后缀名，计算出文件转移的路径
                String mainImageFileNewName = pid + "_mainimg_1" + mainImgFileSuffixName.toLowerCase();
                //通过产品主目录+pid+_listimg+原始文件后缀名，计算出文件转移的路径
                String mainImageTransferFilename = productMainFolderPath + mainImageFileNewName;
                try {
                    mainImgFile.transferTo(new File(mainImageTransferFilename));
                } catch (IOException e) {
                    e.printStackTrace();
                    throw new BgException("出现异常，修改产品主图失败");
                }
                if(!mainImgFileOldName.equals(mainImageFileNewName)){
                    FileManageService fileManageService = new FileManageService();
                    fileManageService.deleteFile(productMainFolderPath+mainImgFileOldName);
                    String mainImageNewFileRelPath = Constant.uploadProductDbPrefixPath + pid + "/" + mainImageFileNewName;
                    UpdateMainImgFilePathBean filePathBean = new UpdateMainImgFilePathBean();
                    filePathBean.setPid(pid);
                    filePathBean.setMainimage(mainImageNewFileRelPath);
                    sqlSession.update("dazhimen.bg.bean.Product.updateMainImgPath",filePathBean);
                    sqlSession.commit();
                }
            }
        } catch (BgException e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException(e.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，修改产品主图失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
    private void dealProductIstry(String pid){
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            sqlSession.update("dazhimen.bg.bean.Product.dealProductIstry", pid);
            sqlSession.commit();
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
}
