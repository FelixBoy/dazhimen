package demo;

import util.pay.WXPayUtil;

import java.util.Map;

/**
 * Created by Administrator on 2017/4/6.
 */
public class WXOrderQuery {
    public static void main(String[] args){
        Map<String, String> map = WXPayUtil.queryWXOrderInfo("4004202001201704066058172109");
        System.out.println(map);
    }
}
