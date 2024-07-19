kubectl create secret generic grafana-login \
 --from-literal=admin-user=user \
 --from-literal=admin-password=password 