package com.common.constant;

import java.util.concurrent.ConcurrentLinkedDeque;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.apache.log4j.Logger;

public class GlobalStaticVar {
	public static Logger BusinessLog = null;
	public static Logger ExceptionLog = null;
	public static ConcurrentLinkedDeque<String> usernameSet = new ConcurrentLinkedDeque<String>();
	
	public static ExecutorService threadPool = Executors.newFixedThreadPool(20);
	public static ExecutorService exthreadPool = Executors.newFixedThreadPool(100);
	
	
}
