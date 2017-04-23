package dazhimen.api.service;

import dazhimen.api.bean.customer.ApiQueryCustomerExistsParamBean;
import dazhimen.api.bean.customer.ApiUpdateHeaderFilePathBean;
import dazhimen.api.bean.customer.ModifyCustomerInfoBean;
import dazhimen.api.bean.SingleValueBean;
import dazhimen.api.exception.ApiException;
import dazhimen.api.exception.ParameterCheckException;
import dazhimen.bg.exception.BgException;
import dazhimen.bg.service.FileManageService;
import db.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import util.CheckIsExistsUtils;
import util.Constant;
import util.VerifyCodeUtils;

import java.io.File;
import java.io.IOException;

/**
 * Created by Administrator on 2017/3/18.
 */
public class ApiCustomerService {
    public void modifyHeader(String cid, CommonsMultipartFile headerFile, String bashPath) throws ApiException, ParameterCheckException {
        if(!CheckIsExistsUtils.checkCidIsExists(cid)){
            throw new ApiException("传入的cid值无效，在数据库不存在");
        }
        //获得文件的原始名称
        String headerFileOrginalName = headerFile.getOriginalFilename();
        //获得原始文件的后缀
        String headerFileSuffixName = headerFileOrginalName.substring(headerFileOrginalName.lastIndexOf("."));
        if(!headerFileSuffixName.equals(".jpg") && !headerFileSuffixName.equals(".png")){
            throw new ParameterCheckException("文件类型错误，不是png或者jpg");
        }
        SqlSession sqlSession = null;
        try{
            sqlSession = MyBatisUtil.createSession();
            String oldHeaderUrl = sqlSession.selectOne("dazhimen.api.bean.ApiCustomer.getCustomerHeaderUrl", cid);
            String customerMainFolderPath = bashPath + Constant.customerPrefixPath  + cid + "\\";
            FileManageService fileService = new FileManageService();
            try {
                fileService.createFolder(customerMainFolderPath);
            } catch (BgException e) {
                e.printStackTrace();
                throw new ApiException("创建用户头像存储目录出错");
            }
            //新文件名
            //通过课程主目录+pid+_listimg+原始文件后缀名，计算出文件转移的路径
            String headerFileNewName = cid + "_header" + headerFileSuffixName;
            //计算出文件转移的路径
            String headerImageTransferFilename = customerMainFolderPath + headerFileNewName;
            try {
                headerFile.transferTo(new File(headerImageTransferFilename));
            } catch (IOException e) {
                e.printStackTrace();
                throw new ApiException("出现异常，修改用户头像失败");
            }
            if(oldHeaderUrl != null && !oldHeaderUrl.equals("")){
                String headerImgFileOldName = oldHeaderUrl.substring(oldHeaderUrl.lastIndexOf("/") + 1);
                if(!headerImgFileOldName.equals(headerFileNewName)) {
                    fileService.deleteFile(customerMainFolderPath + headerImgFileOldName);
                }

            }

            String headerNewFileRelPath = Constant.uploadCustomerDbPrefixPath + cid + "/" + headerFileNewName;
            ApiUpdateHeaderFilePathBean fileUrlBean = new ApiUpdateHeaderFilePathBean();
            fileUrlBean.setCid(cid);
            fileUrlBean.setHeaderurl(headerNewFileRelPath);
            sqlSession.update("dazhimen.api.bean.ApiCustomer.updateHeaderFileUrl",fileUrlBean);
            sqlSession.commit();
        }catch (ApiException e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new ApiException(e.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new ApiException("出现异常，修改用户头像失败");
        }finally {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
    public void modifyPersonalInfo(ModifyCustomerInfoBean customerInfoBean) throws ParameterCheckException, ApiException {
        if(customerInfoBean == null){
            throw new ParameterCheckException("ApiCustomerService的modifyPersonalInfo方法，参数为null");
        }
        String cid = customerInfoBean.getCid();
        if(!CheckIsExistsUtils.checkCidIsExists(cid)){
            throw new ApiException("传入的cid值无效，在数据库不存在");
        }
        String mphone = customerInfoBean.getMphone();
        //校验验证码
        if(!VerifyCodeUtils.checkVerifyCode(customerInfoBean.getVerifycode()) && !VerifyCodeUtils.checkMobileVerifyCode(customerInfoBean.getMphone(), customerInfoBean.getVerifycode())){
            throw new ParameterCheckException("验证码输入错误");
        }
        SqlSession sqlSession = null;
        try {
            sqlSession = MyBatisUtil.createSession();
            ApiQueryCustomerExistsParamBean paramBean = new ApiQueryCustomerExistsParamBean();
            paramBean.setCid(cid);
            paramBean.setMphone(mphone);
            SingleValueBean value = sqlSession.selectOne("dazhimen.api.bean.ApiCustomer.checkMphoneIsOccupy", paramBean);
            boolean checkMphoneIsOccupy;
            if(value == null){
                checkMphoneIsOccupy = false;
            }else{
                checkMphoneIsOccupy = value.getValueInfo() == null? false:true;
            }
            if(checkMphoneIsOccupy){
                throw new ApiException("手机号码已经被占用，修改个人信息失败");
            }
            sqlSession.update("dazhimen.api.bean.ApiCustomer.modifyPersonalInfo", customerInfoBean);
            sqlSession.commit();
        } catch (ApiException e) {
            e.printStackTrace();
            sqlSession.rollback();
            throw new ApiException(e.getMessage());
        }catch (Exception e){
            e.printStackTrace();
            sqlSession.rollback();
            throw new ApiException("修改个人信息出错");
        }finally
        {
            MyBatisUtil.closeSession(sqlSession);
        }
    }
}
