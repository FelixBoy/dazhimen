package dazhimen.bg.service;

import dazhimen.bg.exception.BgException;

import java.io.File;

/**
 * Created by Administrator on 2017/3/19.
 */
public class FileManageService {
    public void createFolder(String folderPath) throws BgException {
        File dir = new File(folderPath);
        if (dir.exists()) {// 判断目录是否存在
            return;
        }
        boolean createResult = dir.mkdirs();
        if(!createResult){
          throw new BgException("创建目录失败！");
        }
    }

    public boolean deleteFolder(String folderPath) {// 删除目录（文件夹）以及目录下的文件
        // 如果sPath不以文件分隔符结尾，自动添加文件分隔符
        File dirFile = new File(folderPath);
        // 如果dir对应的文件不存在，或者不是一个目录，则退出
        if (!dirFile.exists() || !dirFile.isDirectory()) {
            return false;
        }
        boolean flag = true;
        File[] files = dirFile.listFiles();// 获得传入路径下的所有文件
        for (int i = 0; i < files.length; i++) {// 循环遍历删除文件夹下的所有文件(包括子目录)
            if (files[i].isFile()) {// 删除子文件
                flag = deleteFile(files[i].getAbsolutePath());
                if (!flag)
                    break;// 如果删除失败，则跳出
                System.out.println("删除文件成功：" + files[i].getAbsolutePath());
            } else {// 运用递归，删除子目录
                flag = deleteFolder(files[i].getAbsolutePath());
                if (!flag)
                    break;// 如果删除失败，则跳出
                System.out.println("删除目录成功" + files[i].getAbsolutePath());
            }
        }
        if (!flag)
            return false;
        if (dirFile.delete()) {// 删除当前目录
            return true;
        } else {
            return false;
        }
    }
    public boolean deleteFile(String filePath) {// 删除单个文件
        boolean flag = false;
        File file = new File(filePath);
        if (file.isFile() && file.exists()) {// 路径为文件且不为空则进行删除
            file.delete();// 文件删除
            flag = true;
        }
        return flag;
    }

}
