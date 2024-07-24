## Latency
- SLO: 90% of requests served within 50ms over the last 30 seconds
- SLI: buckets of requests in a histogram showing the 90th percentile over the last 30 seconds

<img width="1130" alt="image" src="https://github.com/user-attachments/assets/2bfe1988-e612-420d-954c-2085ef2fef44">

Query
```
histogram_quantile(0.95,
sum(rate(apiserver_request_duration_seconds_bucket{job="kubernetes-apiservers"}[5m]))by (le, verb))
```

## Availability
- SLO: 90% availability
- SLI: total number of successful requests / total number of requests

<img width="1130" alt="image" src="https://github.com/user-attachments/assets/e3346e9f-1af7-4ee2-bab9-35af78ac7f4f">

Query
```
sum (rate(apiserver_request_total{job="kubernetes-apiservers",code!~"5.."}[2d]))
/
sum (rate(apiserver_request_total{job="kubernetes-apiservers"}[2d]))
```

## Error Budget
<img width="1130" alt="image" src="https://github.com/user-attachments/assets/2b3b1f6b-57e1-4692-84aa-5fea86418ec4">

Query
```
1 - ((1 - (sum(increase(apiserver_request_total{job="kubernetes-apiservers", code="200"}[7d])) by (verb)) / sum(increase(apiserver_request_total{job="kubernetes-apiservers"}[7d])) by (verb)) / (1 - .90))
```

## Throughput
<img width="1130" alt="image" src="https://github.com/user-attachments/assets/55d2c5aa-d956-418c-adf5-eb4f7abf925c">

Query
```
sum(rate(apiserver_request_total{job="kubernetes-apiservers",code=~"2.."}[5m]))
```
