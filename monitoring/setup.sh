#!/bin/bash
#Grafana login secret
chmod u+x monitoring/secret.sh
./monitoring/secret.sh

#Grafana
helm repo add grafana https://grafana.github.io/helm-charts
helm install grafana grafana/grafana --version 7.3.8 -f monitoring/grafana.yaml -n staging
# helm upgrade grafana grafana/grafana --version 7.3.8 -f monitoring/grafana.yaml -n staging

#Prometheus
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/prometheus --version 25.19.1 -f monitoring/prometheus.yaml -n staging
helm install prometheus-blackbox-exporter prometheus-community/prometheus-blackbox-exporter --namespace staging
# helm upgrade prometheus prometheus-community/prometheus --version 25.19.1 -f monitoring/prometheus.yaml -n staging
