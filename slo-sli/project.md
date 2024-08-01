## Availability SLI
### The percentage of successful requests over the last 5m
```
sum(rate(apiserver_request_total{job="kubernetes-apiservers",code!~"5.."}[5m]))
/
sum(rate(apiserver_request_total{job="kubernetes-apiservers"}[5m]))
```
<img width="1369" alt="image" src="https://github.com/user-attachments/assets/7421a02b-95b2-41d7-ab5b-7e8bdc7f798b">

## Latency SLI
### 90% of requests finish in these times
```
histogram_quantile(0.90, sum(rate(apiserver_request_duration_seconds_bucket{job="kubernetes-apiservers"}[5m])) by (le, verb))
```
<img width="1369" alt="image" src="https://github.com/user-attachments/assets/d579be3e-d2e5-4ebe-95dc-d19ebb13ae14">

## Throughput
### Successful requests per second
```
sum(rate(apiserver_request_total{job="kubernetes-apiservers",code=~"2.."}[1s]))
```
<img width="1369" alt="image" src="https://github.com/user-attachments/assets/d8d24b90-7444-4b70-90b8-82e409f1f2a5">

## Error Budget - Remaining Error Budget
### The error budget is 20%
```
1 - (
  sum(increase(apiserver_request_total{job="kubernetes-apiservers", code!~"2.."}[7d])) 
  / sum(increase(apiserver_request_total{job="kubernetes-apiservers"}[7d]))
)
```
<img width="1369" alt="image" src="https://github.com/user-attachments/assets/eb41baf1-530a-4e27-bd59-b135fd75ac6b">
