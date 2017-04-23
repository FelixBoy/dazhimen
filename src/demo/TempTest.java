package demo;

import dazhimen.bg.exception.BgException;
import util.*;

/**
 * Created by Administrator on 2017/3/15.
 */
public class TempTest {
    public static void main(String[] args) throws BgException {
        System.out.println(new SeqUtils().getSeqNextVal("user_seq"));
    }
}
