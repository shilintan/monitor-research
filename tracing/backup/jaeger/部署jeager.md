# 部署

```
helm dependency build
helm template --values ../values.yaml --output-dir ../../manifest/ ./
```



```
namespace=test
```

```
namespace=prod
```

```
helm install jaeger jaeger/ --namespace tracing --create-namespace -f values-${namespace}.yaml
helm upgrade jaeger jaeger/ --namespace tracing --create-namespace -f values-${namespace}.yaml

helm uninstall jaeger --namespace tracing
```



# 访问:

http://:16686

http://trace-monitor.local.your-domain-name.com





```
kubectl -n tracing get pvc
kubectl -n tracing edit pvc data-jaeger-cassandra-0
kubectl -n tracing edit pvc data-jaeger-cassandra-1
kubectl -n tracing edit pvc data-jaeger-cassandra-2

kubectl get pv|grep tracing/data-jaeger-cassandra-0
kubectl get pv|grep tracing/data-jaeger-cassandra-1
kubectl get pv|grep tracing/data-jaeger-cassandra-2

kubectl -n tracing get svc
kubectl -n tracing get endpoints
kubectl -n tracing get pod -o wide
kubectl -n tracing get ingress

kubectl -n tracing describe pod jaeger-cassandra-0
kubectl -n tracing describe pod jaeger-collector-55d8558b5f-fk27g

kubectl -n tracing logs -f --tail 300 jaeger-cassandra-0
kubectl -n tracing logs -f --tail 300 jaeger-cassandra-1
kubectl -n tracing logs -f --tail 300 jaeger-cassandra-2
kubectl -n tracing logs -f --tail 300 jaeger-cassandra-schema-7zqx5
kubectl -n tracing logs -f --tail 300 deploy/jaeger-collector
kubectl -n tracing logs -f --tail 300 deploy/jaeger-query

kubectl -n tracing describe pod jaeger-cassandra-0
```

