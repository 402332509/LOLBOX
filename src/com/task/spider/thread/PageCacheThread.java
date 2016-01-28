package com.task.spider.thread;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.common.constant.GlobalStaticVar;
import com.common.model.Pagecache;
import com.jfinal.kit.HttpKit;

public class PageCacheThread extends Thread{
	
	private String matchId;
	private String serverName;
	private String playerName;
	

	public PageCacheThread(String matchId, String serverName, String playerName) {
		this.matchId = matchId;
		this.serverName = serverName;
		this.playerName = playerName;
	}


	@Override
	public void run() {
		String url = "http://lolbox.duowan.com/matchList/ajaxMatchDetail2.php";
		Map<String,String> data = new HashMap<String,String>();
		data.put("serverName", serverName);
		data.put("playerName", playerName);
		data.put("matchId", matchId);
		String response = HttpKit.get(url, data);
		Matcher matcher = Pattern.compile("<span id=\"playerNames\">.+?</span>").matcher(response);
		
		while(matcher.find()){
			String[] usernames = matcher.group().replace("<span id=\"playerNames\">", "").replace("</span>", "").split("\\|");
			for (String username : usernames) {
				if(null==Pagecache.dao.findPlayerByPlayerName(username)){
					Pagecache pagecache = new Pagecache();
					pagecache.setPlayerName(username);
					pagecache.setServerName(serverName);
					pagecache.setHtml("");
					pagecache.setCreateTime(new Date());
					pagecache.save();
				}
			}
		}
//		for (String string : GlobalStaticVar.usernameSet.keySet()) {
//			Record record = new Record();
//			record.set("playerName", string);
//			record.set("serverName", serverName);
//			record.set("createTime", new Date());
//			record.set("html",response);
//			String sql="replace into pagecache set playerName = ? ,serverName = ?, createTime = ?, html = ?";
//			Db.query(sql,string,serverName,new Date(),"");
//			GlobalStaticVar.BusinessLog.info("插入或更新一条数据,playerName="+string);
//		}
	}
}
