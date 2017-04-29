package dazhimen.bg.service;

import dazhimen.bg.bean.PaginationParamBean;
import dazhimen.bg.bean.SingleValueBean;
import dazhimen.bg.bean.news.*;
import dazhimen.bg.exception.BgException;
import db.MyBatisUtil;
import net.sf.json.JSONObject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import util.Constant;
import util.GenNewsHtmlUtil;
import util.IdUtils;
import util.PaginationUtil;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/**
 * Created by Administrator on 2017/4/12.
 */
public class NewsService {

    /**
     * 保存新增新闻信息
     * @param basePath
     * @throws BgException
     */
    public void saveAddNewsContent(String nid, List<NewsContentBean> newsContentBeans, String basePath) throws BgException {
        IdUtils idUtils = new IdUtils();
        //2 计算新闻主目录路径
        String newsMainFolderPath = basePath + Constant.newsPrefixPath  + nid + "\\";
        FileManageService fileService = new FileManageService();
        SqlSession sqlSession = null;
        FileOutputStream fileOutputStream = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            for(int i = 0; i < newsContentBeans.size(); i++){
                NewsContentBean contentBean = newsContentBeans.get(i);
                String contentId = idUtils.getNesContentId();
                String contenteType = contentBean.getContenttype();

                GenNewsContentBean genNewsContentBean = new GenNewsContentBean();
                genNewsContentBean.setContenttype(contenteType);
                genNewsContentBean.setContentSort(contentBean.getContentsort());
                if(contenteType.equals("1")){
                    contentBean.setContentvalue(contentBean.getContentsubtitle());
                    genNewsContentBean.setContentvalue(contentBean.getContentsubtitle());
                }else if(contenteType.equals("2")){
                    CommonsMultipartFile contentFile = contentBean.getContentfile();
                    //获得列表图片文件的原始名称
                    String contentFileOrginalName = contentFile.getOriginalFilename();
                    //获得原始文件的后缀
                    String contentFileSuffixName = contentFileOrginalName.substring(contentFileOrginalName.lastIndexOf("."));
                    //新文件名
                    String contentFileNewName = contentId + "_contentimg" + contentFileSuffixName;

                    //通过产品主目录+pid+_listimg+原始文件后缀名，计算出文件转移的路径
                    String contentFileTransferFilename = newsMainFolderPath + contentFileNewName;

                    try {
                        contentFile.transferTo(new File(contentFileTransferFilename));
                    } catch (IOException e) {
                        e.printStackTrace();
                        throw new BgException("出现异常,保存新闻内容图片失败");
                    }
                    //计算列表图片在工程中的相对路径，用于记录到数据库
                    String contentFileRelPath = Constant.uploadNewsDbPrefixPath + nid + "/" + contentFileNewName;
                    contentBean.setContentvalue(contentFileRelPath);
                    genNewsContentBean.setContentvalue(contentFileNewName);
                }else{
                    contentBean.setContentvalue(contentBean.getContenttext());
                    genNewsContentBean.setContentvalue(contentBean.getContenttext());
                }
                contentBean.setContentid(contentId);
                contentBean.setNid(nid);
                sqlSession.insert("dazhimen.bg.bean.News.saveAddNewContents", contentBean);
            }
            ModifyNewsDataBean newsBean = sqlSession.selectOne("dazhimen.bg.bean.News.getModifyNewsTitleData" ,nid);
            if(newsBean == null){
                throw new BgException("获取新闻信息异常");
            }

            List<GenNewsContentBean> contentBeans = sqlSession.selectList("dazhimen.bg.bean.News.getNewsContentById", nid);
            if(contentBeans == null || contentBeans.size() == 0){
                throw new BgException("获取新闻内容异常");
            }
            String newsContentFileName = nid + "_newscontent.html";
            String newsContentFilePath = newsMainFolderPath + newsContentFileName;
            File newContentFile = new File(newsContentFilePath);

            fileOutputStream = new FileOutputStream(newContentFile);
            String newsHtml = GenNewsHtmlUtil.genMobileNewsHtml(newsBean.getTitle(), contentBeans);
            fileOutputStream.write(newsHtml.getBytes("UTF-8"));
            sqlSession.commit();
        }catch (BgException e){
            e.printStackTrace();
            sqlSession.rollback();
            fileService.deleteFolder(newsMainFolderPath);
            throw new BgException(e.getMessage());
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            sqlSession.rollback();
            fileService.deleteFolder(newsMainFolderPath);
            throw new BgException("生成新闻html文件时，字符集编码不支持");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            sqlSession.rollback();
            fileService.deleteFolder(newsMainFolderPath);
            throw new BgException("找不到新闻html文件");
        } catch (IOException e) {
            e.printStackTrace();
            sqlSession.rollback();
            fileService.deleteFolder(newsMainFolderPath);
            throw new BgException("生成新闻html文件时，出现读写错误");
        } catch (Exception e){
            sqlSession.rollback();
            fileService.deleteFolder(newsMainFolderPath);
            throw new BgException("出现异常，添加新闻失败");
        } finally{
            MyBatisUtil.closeSession(sqlSession);
            try {
                fileOutputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    public void deleteNewsContentImg(String nid, String contentid, String basePath) throws BgException {
        if(nid == null || nid.equals("")){
            throw new BgException("传入的nid为空，删除图片失败");
        }
        if(contentid == null || contentid.equals("")){
            throw new BgException("传入的contentid为空，删除图片失败");
        }
        SqlSession sqlSession = null;
        FileOutputStream fileOutputStream = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            String contentSort = sqlSession.selectOne("dazhimen.bg.bean.News.getContentSortById" ,contentid);
            if(contentSort == null || contentSort.equals("")){
                throw new BgException("获取新闻内容的排序信息异常");
            }
            String contentImgPath = sqlSession.selectOne("dazhimen.bg.bean.News.getCotentImgPath", contentid);
            if (contentImgPath == null || contentImgPath.equals("")) {
                throw new BgException("出现异常，查询原新闻内容图片路径时出错");
            }
            String contentImgFileName = contentImgPath.substring(contentImgPath.lastIndexOf("/") + 1);

            sqlSession.delete("dazhimen.bg.bean.News.deleleNewsContent", contentid);
            DealNewsContentSortBean dealNewsContentSortBean = new DealNewsContentSortBean();
            dealNewsContentSortBean.setNid(nid);
            dealNewsContentSortBean.setSort(contentSort);
            sqlSession.update("dazhimen.bg.bean.News.dealNewsContentSort", dealNewsContentSortBean);

            ModifyNewsDataBean newsBean = sqlSession.selectOne("dazhimen.bg.bean.News.getModifyNewsTitleData" ,nid);
            if(newsBean == null){
                throw new BgException("获取新闻信息异常");
            }

            List<GenNewsContentBean> contentBeans = sqlSession.selectList("dazhimen.bg.bean.News.getNewsContentById", nid);
            if(contentBeans == null || contentBeans.size() == 0){
                throw new BgException("获取新闻内容异常");
            }
            String newsContentFileName = nid + "_newscontent.html";
            String newsMainFolderPath = basePath + Constant.newsPrefixPath  + nid + "\\";
            String newsContentFilePath = newsMainFolderPath + newsContentFileName;
            File newContentFile = new File(newsContentFilePath);

            fileOutputStream = new FileOutputStream(newContentFile);
            String newsHtml = GenNewsHtmlUtil.genMobileNewsHtml(newsBean.getTitle(), contentBeans);
            fileOutputStream.write(newsHtml.getBytes("UTF-8"));
            //新文件名
            FileManageService fileManageService = new FileManageService();
            fileManageService.deleteFile(newsMainFolderPath + contentImgFileName);
            sqlSession.commit();
        }catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("生成新闻html文件时，字符集编码不支持");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("找不到新闻html文件");
        } catch (IOException e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("生成新闻html文件时，出现读写错误");
        } catch(BgException e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException(e.getMessage());
        } catch(Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，删除图片失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
            try {
                fileOutputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    public void deleteNewsContentSubtitle(String nid, String contentid, String basePath) throws BgException {
        if(nid == null || nid.equals("")){
            throw new BgException("传入的nid为空，删除副标题失败");
        }
        if(contentid == null || contentid.equals("")){
            throw new BgException("传入的contentid为空，删除副标题失败");
        }
        SqlSession sqlSession = null;
        FileOutputStream fileOutputStream = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            String contentSort = sqlSession.selectOne("dazhimen.bg.bean.News.getContentSortById" ,contentid);
            if(contentSort == null || contentSort.equals("")){
                throw new BgException("获取新闻内容的排序信息异常");
            }
            sqlSession.delete("dazhimen.bg.bean.News.deleleNewsContent", contentid);
            DealNewsContentSortBean dealNewsContentSortBean = new DealNewsContentSortBean();
            dealNewsContentSortBean.setNid(nid);
            dealNewsContentSortBean.setSort(contentSort);
            sqlSession.update("dazhimen.bg.bean.News.dealNewsContentSort", dealNewsContentSortBean);

            ModifyNewsDataBean newsBean = sqlSession.selectOne("dazhimen.bg.bean.News.getModifyNewsTitleData" ,nid);
            if(newsBean == null){
                throw new BgException("获取新闻信息异常");
            }

            List<GenNewsContentBean> contentBeans = sqlSession.selectList("dazhimen.bg.bean.News.getNewsContentById", nid);
            if(contentBeans == null || contentBeans.size() == 0){
                throw new BgException("获取新闻内容异常");
            }
            String newsContentFileName = nid + "_newscontent.html";
            String newsMainFolderPath = basePath + Constant.newsPrefixPath  + nid + "\\";
            String newsContentFilePath = newsMainFolderPath + newsContentFileName;
            File newContentFile = new File(newsContentFilePath);

            fileOutputStream = new FileOutputStream(newContentFile);
            String newsHtml = GenNewsHtmlUtil.genMobileNewsHtml(newsBean.getTitle(), contentBeans);
            fileOutputStream.write(newsHtml.getBytes("UTF-8"));
            sqlSession.commit();
        }catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("生成新闻html文件时，字符集编码不支持");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("找不到新闻html文件");
        } catch (IOException e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("生成新闻html文件时，出现读写错误");
        } catch(BgException e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException(e.getMessage());
        } catch(Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，删除副标题失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
            try {
                fileOutputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    public void deleteNewsContentText(String nid, String contentid, String basePath) throws BgException {
        if(nid == null || nid.equals("")){
            throw new BgException("传入的nid为空，删除文本失败");
        }
        if(contentid == null || contentid.equals("")){
            throw new BgException("传入的contentid为空，删除文本失败");
        }
        SqlSession sqlSession = null;
        FileOutputStream fileOutputStream = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            String contentSort = sqlSession.selectOne("dazhimen.bg.bean.News.getContentSortById" ,contentid);
            if(contentSort == null || contentSort.equals("")){
                throw new BgException("获取新闻内容的排序信息异常");
            }
            sqlSession.delete("dazhimen.bg.bean.News.deleleNewsContent", contentid);
            DealNewsContentSortBean dealNewsContentSortBean = new DealNewsContentSortBean();
            dealNewsContentSortBean.setNid(nid);
            dealNewsContentSortBean.setSort(contentSort);
            sqlSession.update("dazhimen.bg.bean.News.dealNewsContentSort", dealNewsContentSortBean);

            ModifyNewsDataBean newsBean = sqlSession.selectOne("dazhimen.bg.bean.News.getModifyNewsTitleData" ,nid);
            if(newsBean == null){
                throw new BgException("获取新闻信息异常");
            }

            List<GenNewsContentBean> contentBeans = sqlSession.selectList("dazhimen.bg.bean.News.getNewsContentById", nid);
            if(contentBeans == null || contentBeans.size() == 0){
                throw new BgException("获取新闻内容异常");
            }
            String newsContentFileName = nid + "_newscontent.html";
            String newsMainFolderPath = basePath + Constant.newsPrefixPath  + nid + "\\";
            String newsContentFilePath = newsMainFolderPath + newsContentFileName;
            File newContentFile = new File(newsContentFilePath);

            fileOutputStream = new FileOutputStream(newContentFile);
            String newsHtml = GenNewsHtmlUtil.genMobileNewsHtml(newsBean.getTitle(), contentBeans);
            fileOutputStream.write(newsHtml.getBytes("UTF-8"));
            sqlSession.commit();
        }catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("生成新闻html文件时，字符集编码不支持");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("找不到新闻html文件");
        } catch (IOException e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("生成新闻html文件时，出现读写错误");
        } catch(BgException e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException(e.getMessage());
        } catch(Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，删除文本失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
            try {
                fileOutputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 保存修改新闻内容图片
     * @param nid
     * @param contentImgFile
     * @param bashPath
     * @throws BgException
     */
    public void saveModifyNewsContentImg(String nid, String contentid, CommonsMultipartFile contentImgFile, String bashPath) throws BgException {
        SqlSession sqlSession = null;
        FileOutputStream fileOutputStream = null;
        if(nid == null || nid.equals("")){
            throw new BgException("传入的nid为空，修改文本失败");
        }
        if(contentid == null || contentid.equals("")){
            throw new BgException("传入的nid为空，修改文本失败");
        }
        if(contentImgFile == null || contentImgFile.isEmpty()){
            throw new BgException("传入的contentImgFile为空，修改文本失败");
        }
        try {
            if(contentImgFile != null && !contentImgFile.isEmpty()) {
                sqlSession = MyBatisUtil.createSession();
                String contentImgPath = sqlSession.selectOne("dazhimen.bg.bean.News.getCotentImgPath", contentid);
                if (contentImgPath == null || contentImgPath.equals("")) {
                    throw new BgException("出现异常，查询原新闻内容图片路径时出错");
                }
                String contentImgFileOldName = contentImgPath.substring(contentImgPath.lastIndexOf("/") + 1);
                String newsMainFolderPath = bashPath + Constant.newsPrefixPath  + nid + "\\";
                //获得文件的原始名称
                String contentImgFileOrginalName = contentImgFile.getOriginalFilename();
                //获得原始文件的后缀
                String contentImgFileSuffixName = contentImgFileOrginalName.substring(contentImgFileOrginalName.lastIndexOf("."));
                //新文件名
                String contentImageFileNewName = contentid + "_contentimg" + contentImgFileSuffixName;
                //通过产品主目录+pid+_listimg+原始文件后缀名，计算出文件转移的路径
                String contentImageTransferFilename = newsMainFolderPath + contentImageFileNewName;
                try {
                    contentImgFile.transferTo(new File(contentImageTransferFilename));
                } catch (IOException e) {
                    e.printStackTrace();
                    throw new BgException("出现异常，修改新闻内容失败");
                }
                if(!contentImgFileOldName.equals(contentImageFileNewName)){
                    FileManageService fileManageService = new FileManageService();
                    fileManageService.deleteFile(newsMainFolderPath + contentImgFileOldName);

                    //计算新闻主图图片在工程中的相对路径，用于记录到数据库
                    String contentImageNewFileRelPath = Constant.uploadNewsDbPrefixPath + nid + "/" + contentImageFileNewName;
                    ModifyNewsSubtitleBean modifyNewsContentBean = new ModifyNewsSubtitleBean();
                    modifyNewsContentBean.setContentid(contentid);
                    modifyNewsContentBean.setContentvalue(contentImageNewFileRelPath);
                    modifyNewsContentBean.setNid(nid);
                    sqlSession.update("dazhimen.bg.bean.News.updateContentImgPath",modifyNewsContentBean);
                }
                ModifyNewsDataBean newsBean = sqlSession.selectOne("dazhimen.bg.bean.News.getModifyNewsTitleData" ,nid);
                if(newsBean == null){
                    throw new BgException("获取新闻信息异常");
                }

                List<GenNewsContentBean> contentBeans = sqlSession.selectList("dazhimen.bg.bean.News.getNewsContentById", nid);
                if(contentBeans == null || contentBeans.size() == 0){
                    throw new BgException("获取新闻内容异常");
                }
                String newsContentFileName = nid + "_newscontent.html";
                String newsContentFilePath = newsMainFolderPath + newsContentFileName;
                File newContentFile = new File(newsContentFilePath);

                fileOutputStream = new FileOutputStream(newContentFile);
                String newsHtml = GenNewsHtmlUtil.genMobileNewsHtml(newsBean.getTitle(), contentBeans);
                fileOutputStream.write(newsHtml.getBytes("UTF-8"));
                sqlSession.commit();
            }
        }catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("生成新闻html文件时，字符集编码不支持");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("找不到新闻html文件");
        } catch (IOException e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("生成新闻html文件时，出现读写错误");
        } catch(BgException e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException(e.getMessage());
        } catch(Exception e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，修改新闻文本失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
            try {
                fileOutputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    /**
     * 保存修改新闻内容文本
     * @param nid
     * @param contentid
     * @param text
     * @param basePath
     * @throws BgException
     */
    public void modifyNewsContentText(String nid, String contentid, String text, String basePath) throws BgException {
        if(nid == null || nid.equals("")){
            throw new BgException("传入的nid为空，修改内容文本失败");
        }
        if(contentid == null || contentid.equals("")){
            throw new BgException("传入的nid为空，修改内容文本失败");
        }
        if(text == null || text.equals("")){
            throw new BgException("传入的text为空，修改内容文本失败");
        }
        SqlSession sqlSession = null;
        FileOutputStream fileOutputStream = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            ModifyNewsSubtitleBean newsSubtitleBean = new ModifyNewsSubtitleBean();
            newsSubtitleBean.setContentid(nid);
            newsSubtitleBean.setContentid(contentid);
            newsSubtitleBean.setContentvalue(text);
            sqlSession.update("dazhimen.bg.bean.News.modifyNewsContentText", newsSubtitleBean);

            ModifyNewsDataBean newsBean = sqlSession.selectOne("dazhimen.bg.bean.News.getModifyNewsTitleData" ,nid);
            if(newsBean == null){
                throw new BgException("获取新闻信息异常");
            }

            List<GenNewsContentBean> contentBeans = sqlSession.selectList("dazhimen.bg.bean.News.getNewsContentById", nid);
            if(contentBeans == null || contentBeans.size() == 0){
                throw new BgException("获取新闻内容异常");
            }
            String newsContentFileName = nid + "_newscontent.html";
            String newsMainFolderPath = basePath + Constant.newsPrefixPath  + nid + "\\";
            String newsContentFilePath = newsMainFolderPath + newsContentFileName;
            File newContentFile = new File(newsContentFilePath);

            fileOutputStream = new FileOutputStream(newContentFile);
            String newsHtml = GenNewsHtmlUtil.genMobileNewsHtml(newsBean.getTitle(), contentBeans);
            fileOutputStream.write(newsHtml.getBytes("UTF-8"));
            sqlSession.commit();
        }catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("生成新闻html文件时，字符集编码不支持");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("找不到新闻html文件");
        } catch (IOException e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("生成新闻html文件时，出现读写错误");
        } catch(BgException e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException(e.getMessage());
        } catch(Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，修改内容文本失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
            try {
                fileOutputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    /**
     * 保存修改新闻内容副标题
     * @param nid
     * @param contentid
     * @param subtitle
     * @param basePath
     * @throws BgException
     */
    public void modifyNewsContentSubtitle(String nid, String contentid, String subtitle, String basePath) throws BgException {
        if(nid == null || nid.equals("")){
            throw new BgException("传入的nid为空，修改副标题失败");
        }
        if(contentid == null || contentid.equals("")){
            throw new BgException("传入的nid为空，修改副标题失败");
        }
        if(subtitle == null || subtitle.equals("")){
            throw new BgException("传入的subtitle为空，修改副标题失败");
        }
        SqlSession sqlSession = null;
        FileOutputStream fileOutputStream = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            ModifyNewsSubtitleBean newsSubtitleBean = new ModifyNewsSubtitleBean();
            newsSubtitleBean.setContentid(nid);
            newsSubtitleBean.setContentid(contentid);
            newsSubtitleBean.setContentvalue(subtitle);
            sqlSession.update("dazhimen.bg.bean.News.modifyNewsContentSubtitle", newsSubtitleBean);

            ModifyNewsDataBean newsBean = sqlSession.selectOne("dazhimen.bg.bean.News.getModifyNewsTitleData" ,nid);
            if(newsBean == null){
                throw new BgException("获取新闻信息异常");
            }

            List<GenNewsContentBean> contentBeans = sqlSession.selectList("dazhimen.bg.bean.News.getNewsContentById", nid);
            if(contentBeans == null || contentBeans.size() == 0){
                throw new BgException("获取新闻内容异常");
            }
            String newsContentFileName = nid + "_newscontent.html";
            String newsMainFolderPath = basePath + Constant.newsPrefixPath  + nid + "\\";
            String newsContentFilePath = newsMainFolderPath + newsContentFileName;
            File newContentFile = new File(newsContentFilePath);

            fileOutputStream = new FileOutputStream(newContentFile);
            String newsHtml = GenNewsHtmlUtil.genMobileNewsHtml(newsBean.getTitle(), contentBeans);
            fileOutputStream.write(newsHtml.getBytes("UTF-8"));
            sqlSession.commit();
        }catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("生成新闻html文件时，字符集编码不支持");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("找不到新闻html文件");
        } catch (IOException e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("生成新闻html文件时，出现读写错误");
        } catch(BgException e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException(e.getMessage());
        } catch(Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，修改副标题失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
            try {
                fileOutputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    public List<ViewNewsContentBean> getModifyNewsContentData(String nid) throws BgException {
        List<ViewNewsContentBean> newsContentBeans = null;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            newsContentBeans = sqlSession.selectList("dazhimen.bg.bean.News.getModifyNewsContentData", nid);
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，获取新闻内容出错");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return newsContentBeans;
    }
    /**
     * 保存修改新闻标题
     * @param nid
     * @param newstitle
     * @throws BgException
     */
    public void saveModifyNewsTitle(String nid, String newstitle, String basePath) throws BgException {
        if(nid == null || nid.equals("")){
            throw new BgException("传入的nid为空，修改标题失败");
        }
        if(newstitle == null || newstitle.equals("")){
            throw new BgException("传入的newstitle为空，修改标题失败");
        }
        SqlSession sqlSession = null;
        FileOutputStream fileOutputStream = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            ModifyNewsTitleBean newsTitleBean = new ModifyNewsTitleBean();
            newsTitleBean.setNid(nid);
            newsTitleBean.setNewstitle(newstitle);
            sqlSession.update("dazhimen.bg.bean.News.saveModifyNewsTitle", newsTitleBean);

            List<GenNewsContentBean> contentBeans = sqlSession.selectList("dazhimen.bg.bean.News.getNewsContentById", nid);
            String newsContentFileName = nid + "_newscontent.html";
            String newsMainFolderPath = basePath + Constant.newsPrefixPath  + nid + "\\";
            String newsContentFilePath = newsMainFolderPath + newsContentFileName;
            File newContentFile = new File(newsContentFilePath);

            fileOutputStream = new FileOutputStream(newContentFile);
            String newsHtml = GenNewsHtmlUtil.genMobileNewsHtml(newstitle, contentBeans);
            fileOutputStream.write(newsHtml.getBytes("UTF-8"));
            sqlSession.commit();
        }catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("生成新闻html文件时，字符集编码不支持");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("找不到新闻html文件");
        } catch (IOException e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("生成新闻html文件时，出现读写错误");
        } catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，修改标题失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
            try {
                fileOutputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    /**
     * 保存修改新闻主图
     * @param nid
     * @param mainImgFile
     * @param bashPath
     * @throws BgException
     */
    public void saveModifyNewsMainImg(String nid, CommonsMultipartFile mainImgFile, String bashPath) throws BgException {
        SqlSession sqlSession = null;
        try {
            if(mainImgFile != null && !mainImgFile.isEmpty()) {
                sqlSession = MyBatisUtil.createSession();
                String mainImgPath = sqlSession.selectOne("dazhimen.bg.bean.News.getMainImgPath", nid);
                if (mainImgPath == null || mainImgPath.equals("")) {
                    throw new BgException("出现异常，查询原新闻主图路径时出错");
                }
                String mainImgFileOldName = mainImgPath.substring(mainImgPath.lastIndexOf("/") + 1);
                String newsMainFolderPath = bashPath + Constant.newsPrefixPath  + nid + "\\";
                //获得文件的原始名称
                String mainImgFileOrginalName = mainImgFile.getOriginalFilename();
                //获得原始文件的后缀
                String mainImgFileSuffixName = mainImgFileOrginalName.substring(mainImgFileOrginalName.lastIndexOf("."));
                //新文件名
                //通过新闻主目录+nid+_mainimg+原始文件后缀名，计算出文件转移的路径
                String mainImageFileNewName = nid + "_mainimg" + mainImgFileSuffixName;
                //通过产品主目录+pid+_listimg+原始文件后缀名，计算出文件转移的路径
                String mainImageTransferFilename = newsMainFolderPath + mainImageFileNewName;
                try {
                    mainImgFile.transferTo(new File(mainImageTransferFilename));
                } catch (IOException e) {
                    e.printStackTrace();
                    throw new BgException("出现异常，修改新闻主图失败");
                }
                if(!mainImgFileOldName.equals(mainImageFileNewName)){
                    FileManageService fileManageService = new FileManageService();
                    fileManageService.deleteFile(newsMainFolderPath + mainImgFileOldName);

                    //计算新闻主图图片在工程中的相对路径，用于记录到数据库
                    String mainImageNewFileRelPath = Constant.uploadNewsDbPrefixPath + nid + "/" + mainImageFileNewName;
                    UpdateNewsMainImgFilePathBean filePathBean = new UpdateNewsMainImgFilePathBean();
                    filePathBean.setNid(nid);
                    filePathBean.setMainimage(mainImageNewFileRelPath);
                    sqlSession.update("dazhimen.bg.bean.News.updateMainImgPath",filePathBean);
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
            throw new BgException("出现异常，修改新闻主图失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
    /**
     * 保存修改新闻列表图片
     * @param nid
     * @param listImgFile
     * @param bashPath
     * @throws BgException
     */
    public void saveModifyNewsListImg(String nid, CommonsMultipartFile listImgFile, String bashPath) throws BgException {
        SqlSession sqlSession = null;
        try {
            if(listImgFile != null && !listImgFile.isEmpty()) {
                sqlSession = MyBatisUtil.createSession();
                String listImgPath = sqlSession.selectOne("dazhimen.bg.bean.News.getListImgPath", nid);
                if (listImgPath == null || listImgPath.equals("")) {
                    throw new BgException("出现异常，查询原新闻列表图片路径时出错");
                }
                String listImgFileOldName = listImgPath.substring(listImgPath.lastIndexOf("/") + 1);
                String newsMainFolderPath = bashPath + Constant.newsPrefixPath  + nid + "\\";
                //获得文件的原始名称
                String listImgFileOrginalName = listImgFile.getOriginalFilename();
                //获得原始文件的后缀
                String listImgFileSuffixName = listImgFileOrginalName.substring(listImgFileOrginalName.lastIndexOf("."));
                //新文件名
                //通过新闻主目录+nid+_listimg+原始文件后缀名，计算出文件转移的路径
                String listImageFileNewName = nid + "_listimg" + listImgFileSuffixName;
                //通过产品主目录+pid+_listimg+原始文件后缀名，计算出文件转移的路径
                String listImageTransferFilename = newsMainFolderPath + listImageFileNewName;
                try {
                    listImgFile.transferTo(new File(listImageTransferFilename));
                } catch (IOException e) {
                    e.printStackTrace();
                    throw new BgException("出现异常，修改新闻列表图片失败");
                }
                if(!listImgFileOldName.equals(listImageFileNewName)){
                    FileManageService fileManageService = new FileManageService();
                    fileManageService.deleteFile(newsMainFolderPath + listImgFileOldName);

                    //计算列表图片在工程中的相对路径，用于记录到数据库
                    String listImageNewFileRelPath = Constant.uploadNewsDbPrefixPath + nid + "/" + listImageFileNewName;
                    UpdateNewsListImgFilePathBean filePathBean = new UpdateNewsListImgFilePathBean();
                    filePathBean.setNid(nid);
                    filePathBean.setListimage(listImageNewFileRelPath);
                    sqlSession.update("dazhimen.bg.bean.News.updateListImgPath",filePathBean);
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
            throw new BgException("出现异常，修改新闻列表图片失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
    public ModifyNewsDataBean getModifyNewsTitleData(String nid) throws BgException {
        SqlSession sqlSession = null;
        ModifyNewsDataBean newsBean = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            newsBean = sqlSession.selectOne("dazhimen.bg.bean.News.getModifyNewsTitleData" ,nid);
            if(newsBean == null){
                throw new Exception("获取新闻信息异常");
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return newsBean;
    }
    /**
     * 获取新闻的数据，用于查看
     * @param nid 新闻id
     * @return  新闻信息
     * @throws BgException
     */
    public ViewNewsBean getViewNewsData(String nid) throws BgException {
        SqlSession sqlSession = null;
        ViewNewsBean newsBean = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            newsBean = sqlSession.selectOne("dazhimen.bg.bean.News.getNewsInforById" ,nid);
            if(newsBean == null){
                throw new Exception("获取新闻信息异常");
            }
            List<GenNewsContentBean> contentBeans = sqlSession.selectList("dazhimen.bg.bean.News.getNewsContentById", nid);
           String newsHtml = GenNewsHtmlUtil.genBrowseNewsHtml(newsBean.getTitle(), contentBeans);
           newsBean.setNewscontenthtml(newsHtml);
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return newsBean;
    }

    /**
     * 修改新闻状态
     * @param nid 新闻id
     * @param status  要修改的状态
     * @throws BgException
     */
    public void saveModifyNewsStatus(String nid, String status) throws BgException {
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            ModifyNewsStatusBean newsStatusBean = new ModifyNewsStatusBean();
            newsStatusBean.setNid(nid);
            newsStatusBean.setStatus(status);
            sqlSession.update("dazhimen.bg.bean.News.saveModifyNewsStatus",newsStatusBean);
            sqlSession.commit();
        } catch (Exception e) {
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException("出现异常，修改新闻状态失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }

    /**
     *  查询所有新闻信息
     * @param page
     * @param rows
     * @return
     * @throws BgException
     */
    public String queryAllNews(String page, String rows) throws BgException {
        List<ListViewNewsBean> newsBeans = null;
        SqlSession sqlSession = null;
        Integer totalCount = 0;
        try {
            sqlSession = MyBatisUtil.createSession();

            SingleValueBean allNewsCountValue = sqlSession.selectOne("dazhimen.bg.bean.News.getAllNewsCount");
            if(allNewsCountValue == null || allNewsCountValue.getValueInfo() == null){
                throw new BgException("获取新闻数据总条数出错");
            }
            totalCount = Integer.parseInt(allNewsCountValue.getValueInfo());
            PaginationParamBean paramBean = PaginationUtil.getPaginationParamBean(page,rows);
            newsBeans = sqlSession.selectList("dazhimen.bg.bean.News.listAllNews", paramBean);
        } catch (Exception e) {
            e.printStackTrace();
            throw new BgException("出现异常，查询所有新闻信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", totalCount);
        jsonObject.put("rows", newsBeans);
        return jsonObject.toString();
    }

    /**
     * 按条件查询信息信息
     * @param page
     * @param rows
     * @param paramBean
     * @return
     * @throws BgException
     */
    public String queryAllNewsByParams(String page, String rows, QueryNewsParamBean paramBean) throws BgException {
        List<ListViewNewsBean> newsBeans = null;
        SqlSession sqlSession = null;
        Integer totalCount = 0;
        try {
            sqlSession = MyBatisUtil.createSession();

            SingleValueBean allNewsCountValue = sqlSession.selectOne("dazhimen.bg.bean.News.getAllNewsCountByParam", paramBean);
            if(allNewsCountValue == null || allNewsCountValue.getValueInfo() == null){
                throw new BgException("获取新闻数据总条数出错");
            }
            totalCount = Integer.parseInt(allNewsCountValue.getValueInfo());
            PaginationParamBean paginationParamBean = PaginationUtil.getPaginationParamBean(page,rows);
            paramBean.setStartnum(paginationParamBean.getStartnum());
            paramBean.setGetrows(paginationParamBean.getGetrows());
            newsBeans = sqlSession.selectList("dazhimen.bg.bean.News.listAllNewsByParam", paramBean);
        } catch (Exception e) {
            e.printStackTrace();
            throw new BgException("出现异常，查询所有产品信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", totalCount);
        jsonObject.put("rows", newsBeans);
        return jsonObject.toString();
    }

    /**
     * 保存新增新闻信息
     * @param addNewsBean
     * @param basePath
     * @throws BgException
     */
    public void saveAddNews(AddNewsBean addNewsBean, String basePath) throws BgException {
        //1 生成nid
        IdUtils idUtils = new IdUtils();
        String nid = idUtils.getNewsId();
        //2 计算新闻主目录路径
        String newsMainFolderPath = basePath + Constant.newsPrefixPath  + nid + "\\";
        FileManageService fileService = new FileManageService();
        try{
            fileService.createFolder(newsMainFolderPath);
        }catch (BgException e){
            e.printStackTrace();
            throw new BgException("出现异常,创建新闻主目录失败");
        }
        CommonsMultipartFile listImageFile = addNewsBean.getListImgFile();
        //获得列表图片文件的原始名称
        String listImageOrginalName = listImageFile.getOriginalFilename();
        //获得原始文件的后缀
        String listImageSuffixName = listImageOrginalName.substring(listImageOrginalName.lastIndexOf("."));
        //新文件名
        String listImageFileNewName = nid + "_listimg" + listImageSuffixName;

        //通过产品主目录+pid+_listimg+原始文件后缀名，计算出文件转移的路径
        String listImageTransferFilename = newsMainFolderPath + listImageFileNewName;

        try {
            listImageFile.transferTo(new File(listImageTransferFilename));
        } catch (IOException e) {
            e.printStackTrace();
            throw new BgException("出现异常,保存新闻列表图片失败");
        }
        //计算列表图片在工程中的相对路径，用于记录到数据库
        String listImageFileRelPath = Constant.uploadNewsDbPrefixPath + nid + "/" + listImageFileNewName;

        CommonsMultipartFile mainImgFile = addNewsBean.getMainImgFile();
        String mainImageOrginalName = mainImgFile.getOriginalFilename();
        String mainImageSuffixName = mainImageOrginalName.substring(mainImageOrginalName.lastIndexOf("."));
        //重新编号之后的 新文件名
        String mainImageFileNewName = nid + "_mainimg" + mainImageSuffixName;
        //存储到数据库中的相对路径+新文件名
        String mainImageFileRelPath = Constant.uploadNewsDbPrefixPath +  nid +  "/" + mainImageFileNewName;

        String mainImageTransferFilename = newsMainFolderPath + mainImageFileNewName;
        try {
            mainImgFile.transferTo(new File(mainImageTransferFilename));
        } catch (IOException e) {
            throw new BgException("出现异常,保存新闻主图失败");
        }
        SqlSession sqlSession = null;
        FileOutputStream fileOutputStream = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            addNewsBean.setNid(nid);
            addNewsBean.setListimgurl(listImageFileRelPath);
            addNewsBean.setMainimgurl(mainImageFileRelPath);

            String newsContentFileName = nid + "_newscontent.html";

            String newsContentFileRelPath = Constant.uploadNewsDbPrefixPath +  nid +  "/" + newsContentFileName;
            addNewsBean.setHtmlfileurl(newsContentFileRelPath);
            int result = sqlSession.insert("dazhimen.bg.bean.News.saveAddNews", addNewsBean);
            List<NewsContentBean> newsContentBeans = addNewsBean.getContentBeans();
            List<GenNewsContentBean> genNewsContentBeans = new ArrayList<GenNewsContentBean>();
            for(int i = 0; i < newsContentBeans.size(); i++){
                NewsContentBean contentBean = newsContentBeans.get(i);
                String contentId = idUtils.getNesContentId();
                String contenteType = contentBean.getContenttype();

                GenNewsContentBean genNewsContentBean = new GenNewsContentBean();
                genNewsContentBean.setContenttype(contenteType);
                genNewsContentBean.setContentSort(contentBean.getContentsort());
                if(contenteType.equals("1")){
                    contentBean.setContentvalue(contentBean.getContentsubtitle());
                    genNewsContentBean.setContentvalue(contentBean.getContentsubtitle());
                }else if(contenteType.equals("2")){
                    CommonsMultipartFile contentFile = contentBean.getContentfile();
                    //获得列表图片文件的原始名称
                    String contentFileOrginalName = contentFile.getOriginalFilename();
                    //获得原始文件的后缀
                    String contentFileSuffixName = contentFileOrginalName.substring(contentFileOrginalName.lastIndexOf("."));
                    //新文件名
                    String contentFileNewName = contentId + "_contentimg" + contentFileSuffixName;

                    //通过产品主目录+pid+_listimg+原始文件后缀名，计算出文件转移的路径
                    String contentFileTransferFilename = newsMainFolderPath + contentFileNewName;

                    try {
                        contentFile.transferTo(new File(contentFileTransferFilename));
                    } catch (IOException e) {
                        e.printStackTrace();
                        throw new BgException("出现异常,保存新闻内容图片失败");
                    }
                    //计算列表图片在工程中的相对路径，用于记录到数据库
                    String contentFileRelPath = Constant.uploadNewsDbPrefixPath + nid + "/" + contentFileNewName;
                    contentBean.setContentvalue(contentFileRelPath);
                    genNewsContentBean.setContentvalue(contentFileNewName);
                }else{
                    contentBean.setContentvalue(contentBean.getContenttext());
                    genNewsContentBean.setContentvalue(contentBean.getContenttext());
                }
                contentBean.setContentid(contentId);
                contentBean.setNid(nid);
                sqlSession.insert("dazhimen.bg.bean.News.saveAddNewContents", contentBean);
                genNewsContentBeans.add(genNewsContentBean);
            }
            String newsContentFilePath = newsMainFolderPath + newsContentFileName;
            File newContentFile = new File(newsContentFilePath);

            fileOutputStream = new FileOutputStream(newContentFile);
            Collections.sort(genNewsContentBeans, new SortNewsContent());
            String newsHtml = GenNewsHtmlUtil.genMobileNewsHtml(addNewsBean.getTitle(), genNewsContentBeans);
            fileOutputStream.write(newsHtml.getBytes("UTF-8"));

            sqlSession.commit();
        }catch (BgException e){
            e.printStackTrace();
            sqlSession.rollback();
            fileService.deleteFolder(newsMainFolderPath);
            throw new BgException(e.getMessage());
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            sqlSession.rollback();
            fileService.deleteFolder(newsMainFolderPath);
            throw new BgException("生成新闻html文件时，字符集编码不支持");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            sqlSession.rollback();
            fileService.deleteFolder(newsMainFolderPath);
            throw new BgException("找不到新闻html文件");
        } catch (IOException e) {
            e.printStackTrace();
            sqlSession.rollback();
            fileService.deleteFolder(newsMainFolderPath);
            throw new BgException("生成新闻html文件时，出现读写错误");
        } catch (Exception e){
            sqlSession.rollback();
            fileService.deleteFolder(newsMainFolderPath);
            throw new BgException("出现异常，添加新闻失败");
        } finally{
            MyBatisUtil.closeSession(sqlSession);
            try {
                fileOutputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    public void saveDeleteNews(HttpServletRequest resq) throws BgException {
        String nid = resq.getParameter("nid");
        if(nid == null || nid.equals("")){
            throw new BgException("传入的nid为空，删除新闻失败");
        }
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            sqlSession.delete("dazhimen.bg.bean.News.saveDeleteNewsContent", nid);
            sqlSession.delete("dazhimen.bg.bean.News.saveDeleteNewsInfor", nid);
            sqlSession.update("dazhimen.bg.bean.News.saveDeleteNewsCollection", nid);
            String newsMainFolderPath = resq.getSession().getServletContext().getRealPath("/") + Constant.newsPrefixPath  + nid + "\\";
            FileManageService fileService = new FileManageService();
            fileService.deleteFolder(newsMainFolderPath);
            sqlSession.commit();
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，删除新闻失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
    private class SortNewsContent implements Comparator {
        public int compare(Object o1, Object o2) {
            GenNewsContentBean newsContent1 = (GenNewsContentBean)o1;
            GenNewsContentBean newsContent2 = (GenNewsContentBean)o2;
            Integer contentSort1 = Integer.parseInt(newsContent1.getContentSort());
            Integer contentSort2 = Integer.parseInt(newsContent2.getContentSort());
            if(contentSort1 > contentSort2)
                return 1;
            else{
                return -1;
            }
        }
    }
}
