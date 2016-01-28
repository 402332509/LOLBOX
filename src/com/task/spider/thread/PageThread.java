package com.task.spider.thread;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.common.constant.GlobalStaticVar;
import com.jfinal.kit.HttpKit;

public class PageThread extends Thread {
	
	private String serverName;
	private String playerName;
	
	public PageThread(String serverName, String playerName) {
		super();
		this.serverName = serverName;
		this.playerName = playerName;
	}

	@Override
	public void run() {
		String url = "http://lolbox.duowan.com/matchList.php";
		Map<String,String> data = new HashMap<String,String>();
		data.put("serverName", serverName);
		data.put("playerName", playerName);
		String response = HttpKit.get(url, data);
		Matcher matcher = Pattern.compile("<li id=\"cli(\\d+)\">").matcher(response);
		List<String> matchIds = new ArrayList<String>();
		while(matcher.find()){
			String matchId = matcher.group().replace("<li id=\"cli", "").replace("\">", "");//.substring(beginIndex, endIndex);
			matchIds.add(matchId);
		}
		for (String matchId : matchIds) {
			GlobalStaticVar.exthreadPool.execute(new PageCacheThread(matchId, serverName, playerName));
		}
		
	}

}
