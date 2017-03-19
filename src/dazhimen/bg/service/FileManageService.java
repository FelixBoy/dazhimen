package dazhimen.bg.service;

import dazhimen.bg.exception.CreateFolderException;

import java.io.File;

/**
 * Created by Administrator on 2017/3/19.
 */
public class FileManageService {
    public void createFolder(String folderPath) throws CreateFolderException {
        File dir = new File(folderPath);
        if (dir.exists()) {// 判断目录是否存在
            return;
        }
        boolean createResult = dir.mkdirs();
        if(!createResult){
          throw new CreateFolderException("创建目录失败！");
        }
    }
}
