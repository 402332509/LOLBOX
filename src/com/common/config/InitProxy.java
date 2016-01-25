package com.common.config;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.common.constant.GlobalStaticVar;
import com.common.model._MappingKit;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.c3p0.C3p0Plugin;

public class InitProxy {
	public boolean initAll() {
		if (initLog()) {
			GlobalStaticVar.BusinessLog.info("初始化日志完成!");
		} else {
			System.out.println("初始化日志失败!");
			return false;
		}
		initProp();
		initDb();
		initTask();
		return true;
	}

	/**
	 * 初始化日志
	 */
	public boolean initLog() {
		Properties props = new Properties();
		InputStream in = InitProxy.class.getClassLoader().getResourceAsStream(
				"log4j.properties");
		try {
			props.load(in);
			PropertyConfigurator.configure(props);
			GlobalStaticVar.BusinessLog = Logger.getLogger("BusinessLog");
			GlobalStaticVar.ExceptionLog = Logger.getLogger("ExceptionLog");
			GlobalStaticVar.BusinessLog.info("日志初始化成功.");
		} catch (IOException e) {
			return false;
		} finally {
			try {
				if (in != null)
					in.close();
			} catch (IOException e) {
				return false;
			} finally {
				in = null;
			}
		}
		return true;
	}

	/**
	 * 初始化配置文件
	 */
	public void initProp() {
		PropKit.use("a_little_config.txt");
	}

	/**
	 * 初始化数据库
	 */
	public void initDb() {
		// 配置C3p0数据库连接池插件
		C3p0Plugin C3p0Plugin = createC3p0Plugin();
		C3p0Plugin.start();
		// 配置ActiveRecord插件
		ActiveRecordPlugin arp = new ActiveRecordPlugin(C3p0Plugin);
		arp.start();
		// 所有配置在 MappingKit 中搞定
		_MappingKit.mapping(arp);
		
	}

	/**
	 * 初始化任务
	 */
	public void initTask() {
//		GlobalStaticVar.BusinessLog.info(Db.find("select * from blog").size());
//		System.out.println("hello world");
		
	}

	public static C3p0Plugin createC3p0Plugin() {
		return new C3p0Plugin(PropKit.get("jdbcUrl"), PropKit.get("user"),
				PropKit.get("password").trim());
	}
}
