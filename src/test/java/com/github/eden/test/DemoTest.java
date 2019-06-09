package com.github.eden.test;


import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.core.LoggerContext;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;

public class DemoTest {

    static {
        LoggerContext logContext = (LoggerContext) LogManager.getContext(false);
        File conFile = new File("/Users/zjz/work/java/eden/conf/log4j2.xml");
        logContext.setConfigLocation(conFile.toURI());
        logContext.reconfigure();
    }


    @Test
    public void test() {
        Logger logger = LoggerFactory.getLogger(DemoTest.class);
        logger.debug("hello world...{}", "How are you");
        logger.info("xxxx");
    }
}
