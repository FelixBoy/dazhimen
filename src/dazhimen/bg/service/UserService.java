package dazhimen.bg.service;

import dazhimen.api.exception.ApiException;
import dazhimen.bg.bean.PaginationParamBean;
import dazhimen.bg.bean.SingleValueBean;
import dazhimen.bg.bean.user.*;
import dazhimen.bg.exception.BgException;
import db.MyBatisUtil;
import net.sf.json.JSONObject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import util.*;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Created by zhj on 2017/3/13.
 */
public class UserService {
    /**
     * 重置用户密码
     * @param resetPasswordBean
     * @return
     */
    public boolean saveResetUserPassword(ResetPasswordBean resetPasswordBean) throws BgException {
        if(!CheckIsExistsUtils.checkUidIsExists(resetPasswordBean.getUid())){
            throw new BgException("传入的uid在数据库中不存在");
        }
        SqlSession sqlSession = null;
        int result = 0;
        try{
            sqlSession = MyBatisUtil.createSession();
            result = sqlSession.update("dazhimen.bg.bean.User.saveResetUserPassword", resetPasswordBean);
            sqlSession.commit();
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，重置密码失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }
    /**
     *  修改用户密码
     * @param modifyPasswordBean 修改用户密码的JavaBean
     * @return 修改是否成功 true/false
     */
    public boolean saveModifyPassword(ModifyPasswordBean modifyPasswordBean) throws BgException {
        int result = 0;
        if(!CheckIsExistsUtils.checkUidIsExists(modifyPasswordBean.getUid())){
            throw new BgException("传入的uid不存在，修改密码失败");
        }
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            CheckOldPasswordBean oldPasswordBean = new CheckOldPasswordBean();
            String uid = modifyPasswordBean.getUid();
            String oldPassword = modifyPasswordBean.getOldpassword();
            String oldPasswordMd5 = GlobalUtils.hex_md5(oldPassword);
            String oldFinallyPassword = GlobalUtils.hex_md5(uid + oldPasswordMd5);
            String loginname = modifyPasswordBean.getLoginname();
            oldPasswordBean.setUid(uid);
            oldPasswordBean.setOldpassword(oldFinallyPassword);
            String value = sqlSession.selectOne("dazhimen.bg.bean.User.checkOldPassword", oldPasswordBean);
            if(value == null || value.equals("")){
                throw new BgException("原始密码错误，修改密码失败");
            }
            String newPassword = modifyPasswordBean.getNewpassword();
            String newPasswordMd5 = GlobalUtils.hex_md5(newPassword);
            String newFinallyPassword = GlobalUtils.hex_md5(uid + newPasswordMd5);
            modifyPasswordBean.setNewpassword(newFinallyPassword);
            result = sqlSession.update("dazhimen.bg.bean.User.saveModifyPassword", modifyPasswordBean);
            sqlSession.commit();
        }catch (BgException e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException(e.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，修改密码失败");
        } finally{
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }
    /**
     * 保存掌门新增
     * @param userBean 要保存的掌门信息
     * @return 保存是否成功
     */
    public boolean saveMasterAdd(UserBean userBean) throws BgException {
        int result = 0;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean value = sqlSession.selectOne("dazhimen.bg.bean.User.checkLoginname", userBean.getLoginname());
            boolean checkLoginNameresult;
            if(value == null){
                checkLoginNameresult = false;
            }else{
                checkLoginNameresult = value.getValueInfo() == null? false:true;
            }
            if(checkLoginNameresult){
                throw new BgException("登录名已经存在，新增掌门失败");
            }
            String uid = new IdUtils().getUid();
            userBean.setUid(uid);
            String md5Pw = GlobalUtils.hex_md5(userBean.getPassword());
            String finallyPassword = GlobalUtils.hex_md5(userBean.getUid()+md5Pw);
            userBean.setPassword(finallyPassword);

            String masterMainFolderPath = userBean.getBasepath() + Constant.masterPrefixPath  + uid + "\\";
            FileManageService fileService = new FileManageService();
            try{
                fileService.createFolder(masterMainFolderPath);
            }catch (BgException e){
                e.printStackTrace();
                throw new BgException("出现异常,创建掌门头像主目录失败");
            }

            CommonsMultipartFile headerImageFile = userBean.getHeaderimgFile();
            //获得文件的原始名称
            String headerFileOrginalName = headerImageFile.getOriginalFilename();
            //获得原始文件的后缀
            String headerFileSuffixName = headerFileOrginalName.substring(headerFileOrginalName.lastIndexOf("."));
            //新文件名
            String headerFileNewName = uid + headerFileSuffixName.toLowerCase();
            //通过掌门主目录+uid+原始文件后缀名，计算出文件转移的路径
            String headerFileTransferFilename = masterMainFolderPath + headerFileNewName;

            try {
                headerImageFile.transferTo(new File(headerFileTransferFilename));
            } catch (IOException e) {
                e.printStackTrace();
                throw new BgException("出现异常，保存头像文件失败");
            }
            //计算列表图片在工程中的相对路径，用于记录到数据库
            String headerFileRelPath = Constant.uploadMasterDbPrefixPath + uid + "/" + headerFileNewName;
            userBean.setHeaderimg(headerFileRelPath);

            result = sqlSession.insert("dazhimen.bg.bean.User.saveAddMater", userBean);
            sqlSession.commit();
        }catch (BgException e){
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }catch (Exception e){
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException("出现异常，新增掌门失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }

    /**
     * 查询所有掌门的信息
     * @return 包含所有掌门信息的 list
     */
    public String queryAllMasters(String page, String rows) throws BgException {
        SqlSession sqlSession = null;
        List<UserBean> userBeans = null;
        Integer totalCount = 0;
        try{
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean allMasterCountValue = sqlSession.selectOne("dazhimen.bg.bean.User.getAllMasterCount");
            if(allMasterCountValue == null || allMasterCountValue.getValueInfo() == null){
                throw new ApiException("获取掌门数据总条数出错");
            }
            totalCount = Integer.parseInt(allMasterCountValue.getValueInfo());
            PaginationParamBean paramBean = PaginationUtil.getPaginationParamBean(page,rows);
            userBeans = sqlSession.selectList("dazhimen.bg.bean.User.listAllMaster", paramBean);
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询所有掌门信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", totalCount);
        jsonObject.put("rows", userBeans);
        return jsonObject.toString();
    }
    /**
     * 查询所有掌门的信息
     * @return 包含所有掌门信息的 list
     */
    public String queryAllMastersByParam(String page, String rows, QueryMasterParamBean paramBean) throws BgException {
        SqlSession sqlSession = null;
        List<UserBean> userBeans = null;
        Integer totalCount = 0;
        try{
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean allMasterCountValue = sqlSession.selectOne("dazhimen.bg.bean.User.getAllMasterCountByParam", paramBean);
            if(allMasterCountValue == null || allMasterCountValue.getValueInfo() == null){
                throw new ApiException("获取掌门数据总条数出错");
            }
            totalCount = Integer.parseInt(allMasterCountValue.getValueInfo());
            PaginationParamBean paginationParamBean = PaginationUtil.getPaginationParamBean(page,rows);
            paramBean.setStartnum(paginationParamBean.getStartnum());
            paramBean.setGetrows(paginationParamBean.getGetrows());
            userBeans = sqlSession.selectList("dazhimen.bg.bean.User.listAllMasterByParam", paramBean);
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询所有掌门信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", totalCount);
        jsonObject.put("rows", userBeans);
        return jsonObject.toString();
    }

    /**
     * 查询所有管理员的信息
     * @return 包含所有掌门信息的 list
     */
    public String queryAllAdmin(String page, String rows) throws BgException {
        SqlSession sqlSession = null;
        List<UserBean> userBeans = null;
        Integer totalCount = 0;
        try{
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean allAdminCountValue = sqlSession.selectOne("dazhimen.bg.bean.User.getAllAdminCount");
            if(allAdminCountValue == null || allAdminCountValue.getValueInfo() == null){
                throw new BgException("获取管理员数据总条数出错");
            }
            totalCount = Integer.parseInt(allAdminCountValue.getValueInfo());
            PaginationParamBean paramBean = PaginationUtil.getPaginationParamBean(page,rows);
            userBeans = sqlSession.selectList("dazhimen.bg.bean.User.listAllAdmin", paramBean);
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询所有管理员信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", totalCount);
        jsonObject.put("rows", userBeans);
        return jsonObject.toString();
    }

    /**
     * 查询所有管理员的信息
     * @return 包含所有掌门信息的 list
     */
    public String queryAllAdminByParam(String page, String rows, QueryMasterParamBean paramBean) throws BgException {
        SqlSession sqlSession = null;
        List<UserBean> userBeans = null;
        Integer totalCount = 0;
        try{
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean allAdminCountValue = sqlSession.selectOne("dazhimen.bg.bean.User.getAllAdminCountByParam", paramBean);
            if(allAdminCountValue == null || allAdminCountValue.getValueInfo() == null){
                throw new ApiException("获取管理员数据总条数出错");
            }
            totalCount = Integer.parseInt(allAdminCountValue.getValueInfo());
            PaginationParamBean paginationParamBean = PaginationUtil.getPaginationParamBean(page,rows);
            paramBean.setStartnum(paginationParamBean.getStartnum());
            paramBean.setGetrows(paginationParamBean.getGetrows());
            userBeans = sqlSession.selectList("dazhimen.bg.bean.User.listAllAdminByParam", paramBean);
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询所有管理员信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", totalCount);
        jsonObject.put("rows", userBeans);
        return jsonObject.toString();
    }
    /**
     * 通过uid获取 制定掌门的信息
     * @param uid 要获取信息的掌门ID
     * @return 返回要获取的掌门信息
     */
    public UserBean getMasterDataByUid(String uid) throws BgException {
        SqlSession sqlSession = null;
        UserBean user = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            user = sqlSession.selectOne("dazhimen.bg.bean.User.getMasterById", uid);
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询指定掌门信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return user;
    }
    public UserBean getAdminDataByUid(String uid) throws BgException {
        SqlSession sqlSession = null;
        UserBean user = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            user = sqlSession.selectOne("dazhimen.bg.bean.User.getAdminById", uid);
        }catch (Exception e){
            e.printStackTrace();
            throw new BgException("出现异常，查询指定管理员信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return user;
    }


    /**
     * 保存对制定master的修改信息
     * @param user
     * @return
     * @throws SQLException
     */
    public boolean saveMasterModify(UserBean user) throws BgException {
        SqlSession sqlSession = null;
        int result = 0;
        try{
            sqlSession = MyBatisUtil.createSession();
            String loginanme = user.getLoginname();
            String loinameOrginal = user.getLoginnameorginal();
            if(!loginanme.equals(loinameOrginal)){
                SingleValueBean value = sqlSession.selectOne("dazhimen.bg.bean.User.checkLoginname", user.getLoginname());
                boolean checkLoginNameresult;
                if(value == null){
                    checkLoginNameresult = false;
                }else{
                    checkLoginNameresult = value.getValueInfo() == null? false:true;
                }
                if(checkLoginNameresult){
                    throw new BgException("登录名已经存在，修改掌门信息失败");
                }
            }
            result = sqlSession.update("dazhimen.bg.bean.User.saveMasterModify", user);
            CommonsMultipartFile headerFile = user.getHeaderimgFile();
            if(headerFile != null && !headerFile.isEmpty()){
                String headerImgPath = sqlSession.selectOne("dazhimen.bg.bean.User.getHeaderImgUrl", user.getUid());
                if(headerImgPath == null || headerImgPath.equals("")){
                    throw new BgException("出现异常，查询查询原头像路径时出错");
                }
                String headerImgFileOldName = headerImgPath.substring(headerImgPath.lastIndexOf("/") + 1);
                String userMainFolderPath = user.getBasepath() + Constant.masterPrefixPath  + user.getUid() + "\\";
                //获得文件的原始名称
                String headerFileOrginalName = headerFile.getOriginalFilename();
                //获得原始文件的后缀
                String headerFileSuffixName = headerFileOrginalName.substring(headerFileOrginalName.lastIndexOf("."));
                //新文件名
                String headerFileNewName = user.getUid() + headerFileSuffixName.toLowerCase();
                //通过课程主目录+pid+_listimg+原始文件后缀名，计算出文件转移的路径
                String headerFileTransferFilename = userMainFolderPath + headerFileNewName;
                try {
                    headerFile.transferTo(new File(headerFileTransferFilename));
                } catch (IOException e) {
                    e.printStackTrace();
                    throw new BgException("出现异常，保存掌门头像失败");
                }
                if(!headerImgFileOldName.equals(headerFileNewName)){
                    FileManageService fileManageService = new FileManageService();
                    fileManageService.deleteFile(userMainFolderPath + headerImgFileOldName);

                    //计算列表图片在工程中的相对路径，用于记录到数据库
                    String headerImageNewFileRelPath = Constant.uploadMasterDbPrefixPath + user.getUid() + "/" + headerFileNewName;
                    UpdateMasterHeaderFIlePathBean filePathBean = new UpdateMasterHeaderFIlePathBean();
                    filePathBean.setUid(user.getUid());
                    filePathBean.setHeaderpath(headerImageNewFileRelPath);
                    sqlSession.update("dazhimen.bg.bean.User.updateMasterHeaderFilePath",filePathBean);
                }
            }
            sqlSession.commit();
        }catch (BgException e){
            sqlSession.rollback();;
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }catch (Exception e){
            sqlSession.rollback();;
            e.printStackTrace();
            throw new BgException("出现异常，修改掌门信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }

    public boolean saveMasterDel(HttpServletRequest resq, String uid) throws BgException {
        int result = 0;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            result = sqlSession.update("dazhimen.bg.bean.User.saveMasterDel", uid);
            String masterFolderPath = resq.getSession().getServletContext().getRealPath("/") + Constant.masterPrefixPath  + uid + "\\";
            FileManageService fileService = new FileManageService();
            fileService.deleteFolder(masterFolderPath);
            sqlSession.commit();
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，删除掌门信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }
    public boolean saveAddAdmin(UserBean userBean) throws BgException {
        userBean.setMphone(userBean.getMphone().trim());
        userBean.setPassword(userBean.getPassword().trim());
        userBean.setLoginname(userBean.getLoginname().trim());
        userBean.setName(userBean.getName().trim());
        int result = 0;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            SingleValueBean value = sqlSession.selectOne("dazhimen.bg.bean.User.checkLoginname", userBean.getLoginname());
            boolean checkLoginNameresult;
            if(value == null){
                checkLoginNameresult = false;
            }else{
                checkLoginNameresult = value.getValueInfo() == null? false:true;
            }
            if(checkLoginNameresult){
                throw new BgException("登录名已经存在，新增管理员失败");
            }
            userBean.setUid(new IdUtils().getUid());
            //密码加密规则，是loginname+password明文之后，md5
            String passwordMd5 = GlobalUtils.hex_md5(userBean.getLoginname()+userBean.getPassword());
            userBean.setPassword(passwordMd5);

            result = sqlSession.insert("dazhimen.bg.bean.User.saveAddAdmin", userBean);
            sqlSession.commit();
        }catch (BgException e){
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }catch (Exception e){
            sqlSession.rollback();
            e.printStackTrace();
            throw new BgException("出现异常，新增管理员失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }

    public boolean saveModifyAdmin(UserBean user) throws BgException {
        user.setMphone(user.getMphone().trim());
        user.setLoginname(user.getLoginname().trim());
        user.setName(user.getName().trim());
        SqlSession sqlSession = null;
        int result = 0;
        try{
            sqlSession = MyBatisUtil.createSession();
            String loginanme = user.getLoginname();
            String loinameOrginal = user.getLoginnameorginal();
            if(!loginanme.equals(loinameOrginal)){
                SingleValueBean value = sqlSession.selectOne("dazhimen.bg.bean.User.checkLoginname", user.getLoginname());
                boolean checkLoginNameresult;
                if(value == null){
                    checkLoginNameresult = false;
                }else{
                    checkLoginNameresult = value.getValueInfo() == null? false:true;
                }
                if(checkLoginNameresult){
                    throw new BgException("登录名已经存在，修改管理员信息失败");
                }
            }
            result = sqlSession.update("dazhimen.bg.bean.User.saveModifyAdmin", user);
            sqlSession.commit();
        }catch (BgException e){
            sqlSession.rollback();;
            e.printStackTrace();
            throw new BgException(e.getMessage());
        }catch (Exception e){
            sqlSession.rollback();;
            e.printStackTrace();
            throw new BgException("出现异常，修改管理员信息失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }
    public boolean saveDeleteAdmin(String uid) throws BgException {
        int result = 0;
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            result = sqlSession.update("dazhimen.bg.bean.User.saveDelAdmin", uid);
            sqlSession.commit();
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new BgException("出现异常，删除管理员失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
        return result == 1;
    }
}
