package com.util;

import com.jfinal.plugin.activerecord.generator.Generator;

public class ModelGenerator {
	public static void main(String[] args) {
		String baseModelPackageName = "com.common";
		String baseModelOutputDir = "";
		String modelPackageName = "";
		String modelOutputDir = "";
		Generator g = new Generator(DataSourceFactory.getDataSource(), baseModelPackageName, baseModelOutputDir, modelPackageName, modelOutputDir);
		g.generate();
	}
}
