package com.nilushan.adaptive_concurrency_control;

import com.codahale.metrics.MetricRegistry;
import com.codahale.metrics.Snapshot;
import com.codahale.metrics.Timer;
import com.github.rollingmetrics.histogram.HdrBuilder;

public class ThreadPoolSizeModifier implements Runnable {

	public static int IN_PROGRESS_COUNT;
	public static MetricRegistry METRICS;
	public static HdrBuilder BUILDER;
	public static Timer LATENCY_TIMER;
	public static MetricRegistry METRICS2;
	public static HdrBuilder BUILDER2;
	public static Timer THROUGHPUT_TIMER;
	private static double oldTenSecondRate;
	private final CustomThreadPool threadPool;


	public ThreadPoolSizeModifier(CustomThreadPool pool) {
		this.threadPool = pool;
		METRICS = new MetricRegistry();
		BUILDER = new HdrBuilder();
		BUILDER.resetReservoirOnSnapshot();
		BUILDER.withPredefinedPercentiles(new double[] { 0.99 }); // Predefine required percentiles
		LATENCY_TIMER = BUILDER.buildAndRegisterTimer(METRICS, "ThroughputAndLatency");
		METRICS2 = new MetricRegistry();
		BUILDER2 = new HdrBuilder();
		THROUGHPUT_TIMER = BUILDER2.buildAndRegisterTimer(METRICS2, "ThroughputAndLatency2");
		AdaptiveConcurrencyControl.LOGGER.info(
				"Thread pool size, Current 10 Second Throughput, Throughput Difference, In pogress count, Average Latency, 99th percentile Latency, Concurrency");
	}

	@Override
	public void run() {
		try {
			int currentThreadPoolSize = threadPool.getThreadPoolSize();
			double currentTenSecondRate = THROUGHPUT_TIMER.getTenSecondRate();
			double rateDifference = (currentTenSecondRate - oldTenSecondRate) * 100 / oldTenSecondRate;
			int currentInProgressCount = IN_PROGRESS_COUNT;
			Snapshot latencySnapshot = LATENCY_TIMER.getSnapshot();
			double currentMeanLatency = latencySnapshot.getMean() / 1000000;
			double current99PLatency = latencySnapshot.get99thPercentile() / 1000000;
			int concurrency = StatusData.getActiveConnectionCounter();

			AdaptiveConcurrencyControl.LOGGER
					.info(currentThreadPoolSize + ", " + currentTenSecondRate + ", " + rateDifference + ", "
							+ currentInProgressCount + ", " + currentMeanLatency + ", " + current99PLatency + ", " + concurrency);
			if(currentTenSecondRate <= 0.0) {
				System.exit(0);
			}

			oldTenSecondRate = currentTenSecondRate;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
