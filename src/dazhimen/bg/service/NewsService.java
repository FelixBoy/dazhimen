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
import util.IdUtils;
import util.PaginationUtil;

import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * Created by Administrator on 2017/4/12.
 */
public class NewsService {
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
        try{
            sqlSession = MyBatisUtil.createSession();
            addNewsBean.setNid(nid);
            addNewsBean.setListimgurl(listImageFileRelPath);
            addNewsBean.setMainimgurl(mainImageFileRelPath);
            int result = sqlSession.insert("dazhimen.bg.bean.News.saveAddNews", addNewsBean);
            List<NewsContentBean> newContentBeans = addNewsBean.getContentBeans();
            for(int i = 0; i < newContentBeans.size(); i++){
                NewsContentBean contentBean = newContentBeans.get(i);
                String contentId = idUtils.getNesContentId();
                String contenteType = contentBean.getContenttype();
                if(contenteType.equals("1")){
                    contentBean.setContentvalue(contentBean.getContentsubtitle());
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
                }else{
                    contentBean.setContentvalue(contentBean.getContenttext());
                }
                contentBean.setContentid(contentId);
                contentBean.setNid(nid);
                sqlSession.insert("dazhimen.bg.bean.News.saveAddNewContents", contentBean);
            }
            sqlSession.commit();
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            fileService.deleteFolder(newsMainFolderPath);
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
}
