```shell
service=cabinet
```

```
kubectl create ns monitor-trace
kubectl -n monitor-trace apply -f elasticsearch.yaml

kubectl -n monitor-trace delete -f elasticsearch.yaml
kubectl -n monitor-trace delete pvc elasticsearch-elasticsearch-0 elasticsearch-elasticsearch-1 elasticsearch-elasticsearch-2
```



```
helm upgrade --install skywalking skywalking --namespace monitor-trace --create-namespace -f values.yaml

helm uninstall skywalking --namespace monitor-trace
```


```shell
kubectl create ns monitor-trace
kubectl -n monitor-trace apply -f ${service}/elasticsearch.yaml

kubectl -n monitor-trace delete -f ${service}/elasticsearch.yaml
kubectl -n monitor-trace delete pvc elasticsearch-elasticsearch-0
kubectl delete ns monitor-trace
```

```shell
helm install skywalking skywalking --namespace monitor-trace --create-namespace -f ${service}/values.yaml
helm upgrade skywalking skywalking --namespace monitor-trace --create-namespace -f ${service}/values.yaml

helm uninstall skywalking --namespace monitor-trace
```



```shell
kubectl -n monitor-trace get pvc
kubectl -n monitor-trace get pod -o wide
kubectl -n monitor-trace describe pod elasticsearch-0
kubectl -n monitor-trace logs -f --tail 300 elasticsearch-0
kubectl -n monitor-trace logs -f --tail 300 elasticsearch-1
kubectl -n monitor-trace logs -f --tail 300 elasticsearch-2
```





# 客户端集成

参考文档:

https://github.com/apache/skywalking-java/blob/main/docs/en/setup/service-agent/java-agent/containerization.md

​	https://github.com/apache/skywalking-java/blob/main/docs/en/setup/service-agent/java-agent/configurations.md

