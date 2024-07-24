## Latency
*measured in milliseconds and be a line graph*
- SLO: 90% of requests served within 50ms over the last 30 seconds
- SLI: buckets of requests in a histogram showing the 90th percentile over the last 30 seconds

<img width="1130" alt="image" src="https://github.com/user-attachments/assets/20f8a7bd-0084-4048-b653-657810123dc9">

Query
```
histogram_quantile(0.95,
sum(rate(apiserver_request_duration_seconds_bucket{job="kubernetes-apiservers"}[5m]))by (le, verb))
```

## Availability
* a single number showing a percentage*
- SLO: 90% availability
- SLI: total number of successful requests / total number of requests

<img width="1130" alt="image" src="https://github.com/user-attachments/assets/9d32ec35-d4b0-4e16-92f4-f7e39a91023b">

Query
```
sum (rate(apiserver_request_total{job="kubernetes-apiservers",code!~"5.."}[2d]))
/
sum (rate(apiserver_request_total{job="kubernetes-apiservers"}[2d]))
```

## Error Budget
*a line graph showing a percentage*
<img width="1130" alt="image" src="https://github.com/user-attachments/assets/81a3c793-93db-4ee4-8b50-cc329d6ee683">

Query
```
1 - ((1 - (sum(increase(apiserver_request_total{job="kubernetes-apiservers", code="200"}[7d])) by (verb)) / sum(increase(apiserver_request_total{job="kubernetes-apiservers"}[7d])) by (verb)) / (1 - .90))
```

## Throughput
*a line graph showing RPS (requests per second)*
<img width="1130" alt="image" src="https://github.com/user-attachments/assets/69350f8b-19b3-463e-a1eb-f0262e2d2b42">

Query
```
sum(rate(apiserver_request_total{job="kubernetes-apiservers",code=~"2.."}[5m]))
```
