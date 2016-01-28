package com.util;

import javax.sql.DataSource;

import com.jfinal.kit.PropKit;
import com.jfinal.plugin.c3p0.C3p0Plugin;

public class DataSourceFactory {
	
	public static DataSource getDataSource() {
		return new C3p0Plugin(PropKit.get("jdbcUrl"), PropKit.get("user"),
				PropKit.get("password").trim()).getDataSource();
	}
	
}
