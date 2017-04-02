package demo;

import java.net.*;
 
public class Test6 {
    public static void main(String[] args) {
        // TODO Auto-generated method stub
        InetAddress ia=null;
        try {
            ia=ia.getLocalHost();
             
            String localname=ia.getHostName();
            String localip=ia.getHostAddress();
            System.out.println("name"+ localname);
            System.out.println("ip"+localip);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}