package com.common.constant;

public enum CacheStatus {
	UNUSED("0"),USEED("1");
	
	private final String symbol;
	
	CacheStatus(String symbol){
		this.symbol=symbol;
	}
	
	@Override
	public String toString() {
		return symbol;
	}
}
