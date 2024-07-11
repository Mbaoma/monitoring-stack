# monitoring-stack
This repo will guide you on installation steps for Grafana, Prometheus, Prometheus Blackbox and node exporter via helm charts to monitor a Kubernetes Cluster.

## Install Helm charts
```

```

## Metrics to track
### Cluster Specific (Host Metrics)
**Panel Title**: CPU Usage (%)
monitor for high CPU usage. This metric is a counter that increments every second the CPU is being used. You can use the rate() function to calculate the CPU usage rate over a specified time interval.
**PromQL Query**
```
rate(node_cpu_seconds_total{cpu="1", namespace="staging"}[5m])
```
This query returns the per-second rate of CPU usage averaged over the past 5 minutes. To set up an alert for high CPU usage, you can specify a threshold, such as 80% usage (0.8 in the query)

**Panel Title**: Memory Used
Trigger an alert when available memory falls below a critical threshold. This is a sign of high memory usage and can be critical if not addressed, as it might lead to memory exhaustion and swapping, affecting system performance.
**PromQL Query**
```
node_memory_MemAvailable_bytes
```
<img width="1439" alt="image" src="https://github.com/Mbaoma/monitoring-stack/assets/49791498/c3f5e176-2752-4239-98cf-f7857f11d225">

**Alert**
Trigger an alert when available memory falls below a percentage of total memory, indicating high memory usage. (If the available memory is less than 10% of the total memory, it indicates that most of the memory is being used by applications and processes).
```
node_memory_MemAvailable_bytes{instance=~"your-instance-regex"} / node_memory_MemTotal_bytes{instance=~"your-instance-regex"} < 0.10
```
<img width="1124" alt="image" src="https://github.com/Mbaoma/monitoring-stack/assets/49791498/bce31c79-c6e4-4c8c-99e4-cd800dd02ee8">

**Panel Title**: Network 
A good approach is to set up alerts based on either a sudden drop in network traffic (which might indicate a network issue or a service outage) or a sustained high network traffic (which might indicate potential network saturation or DDoS attacks).
**PromQL Query**
To detect if the network receive rate is too low, you can use the rate() function:
```
rate(node_network_receive_bytes_total{node=~"ip-172-31-95-55\\.ec2\\.internal|ip-172-31-36-214\\.ec2\\.internal"}[5m]) < 1000
```
To detect if the network receive rate is too high, you can use the rate() function:
```
rate(node_network_receive_bytes_total{node=~"ip-172-31-95-55\\.ec2\\.internal|ip-172-31-36-214\\.ec2\\.internal"}[5m]) < 10000
```

<img width="1439" alt="image" src="https://github.com/Mbaoma/monitoring-stack/assets/49791498/e57ad1a0-63c6-40ab-a259-6f2df4e9b321">

**Panel Title**: Disk Usage
indicates the number of I/O operations currently in progress. set an alert if the number of I/O operations exceeds a certain threshold for a sustained period.
**PromQL Query**
```
node_disk_io_now > 100
```

### Application Specific (Synthetic monitoring)
This is where the Blackbox exporter comes in
You can import dashboard ```7587``` or browse out dashboards from [grafana dashboard library](https://grafana.com/grafana/dashboards/)
<img width="1077" alt="image" src="https://github.com/Mbaoma/monitoring-stack/assets/49791498/ec5777b8-8fad-4c65-b17a-169f43255fc3">

<img width="1440" alt="image" src="https://github.com/Mbaoma/monitoring-stack/assets/49791498/7f44b39d-0647-443a-bff9-410c72c34235">

## Alerting (send alerts to a Slack channel)
Add webhook
<img width="1020" alt="image" src="https://github.com/Mbaoma/monitoring-stack/assets/49791498/d2f28680-cbed-4817-90dc-f8cb2329cb3e">
 
