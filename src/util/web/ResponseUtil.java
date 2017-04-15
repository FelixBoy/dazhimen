package util.web;

import net.sf.json.JSONObject;
import util.Constant;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by Administrator on 2017/4/15.
 */
public class ResponseUtil {
    public static void writeFailMsgToBrowse(HttpServletResponse resp, String data){
        resp.setCharacterEncoding(Constant.CharSet);
        resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        PrintWriter out = null;
        try {
            out = resp.getWriter();
            out.write(data);
        } catch (IOException ex) {
            ex.printStackTrace();
        }finally {
            out.close();
        }
    }
    public static void writeMsg(HttpServletResponse resp, String data){
        resp.setCharacterEncoding(Constant.CharSet);
        PrintWriter out = null;
        try {
            out = resp.getWriter();
            out.write(data);
        } catch (IOException ex) {
            ex.printStackTrace();
        }finally {
            out.close();
        }
    }
    public static void writeJavaScript(HttpServletResponse resp, String jsStr){
        resp.setContentType("text/html;charset=utf-8");
        PrintWriter out = null;
        try {
            out = resp.getWriter();
            out.write(jsStr);
        } catch (IOException ex) {
            ex.printStackTrace();
        }finally {
            out.close();
        }
    }

    public static void writeFailMsgToApiResult(HttpServletResponse resp, String failMsg){
        resp.setCharacterEncoding(Constant.CharSet);
        PrintWriter out = null;
        try {
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("code","400");
            jsonObj.put("msg",failMsg);
            out = resp.getWriter();
            out.write(jsonObj.toString());
        } catch (IOException ex) {
            ex.printStackTrace();
        }finally {
            out.close();
        }
    }
}
