package com.task.spider;

import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import org.apache.log4j.Logger;

import com.common.constant.CacheStatus;
import com.common.constant.GlobalStaticVar;
import com.common.model.Pagecache;
import com.jfinal.aop.Duang;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.task.spider.thread.PageThread;

public class PageSpider {

	private static Logger BusinessLog = GlobalStaticVar.BusinessLog;
	private static Logger ExceptionLog = GlobalStaticVar.ExceptionLog;

	public void initTask() {
		ScheduledExecutorService service = Executors
				.newSingleThreadScheduledExecutor();

		Runnable runnable = new Runnable() {

			@Override
			public void run() {
				BusinessLog.info("开始扫描数据库中的用户名...");
				List<Pagecache> untrackedPlayers = Pagecache
						.findUntrackedPlayer(10);
				for (Pagecache pagecache : untrackedPlayers) {
					try {
						pagecache.setStatus(Integer.parseInt(CacheStatus.USEED
								.toString()));
						pagecache.update();
						PageThread pageThread = new PageThread(
								pagecache.getServerName(),
								pagecache.getPlayerName());
						GlobalStaticVar.threadPool.execute(pageThread);
					} catch (Exception e) {
						ExceptionLog.error(
								"任务执行中断,playerName="
										+ pagecache.getPlayerName(), e);
					}

				}

			}
		};

		service.scheduleAtFixedRate(runnable, 1, 10, TimeUnit.SECONDS);

	}

}
