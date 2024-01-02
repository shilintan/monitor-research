# 部署loki

```
helm template loki-distributed --namespace monitor-log --values ../values.yaml          --output-dir ../../manifest/ ./
helm template promtail         --namespace monitor-log --values ../values-promtail.yaml --output-dir ../../manifest/ ./

```



```
helm upgrade --install loki     loki-distributed --namespace monitor-log --create-namespace -f values-s3.yaml
helm upgrade --install promtail promtail         --namespace monitor-log --create-namespace -f values-promtail.yaml

helm uninstall loki     --namespace monitor-log
helm uninstall promtail --namespace monitor-log
kubectl -n monitor-log delete pvc data-loki-loki-distributed-ingester-0      wal-loki-loki-distributed-ingester-0 	data-loki-loki-distributed-ingester-1  wal-loki-loki-distributed-ingester-1
kubectl -n monitor-log delete pvc data-loki-loki-distributed-ruler-0         data-loki-loki-distributed-ruler-1
kubectl -n monitor-log delete pvc data-loki-loki-distributed-compactor-0     wal-loki-loki-distributed-compactor-0 	data-loki-loki-distributed-compactor-1 wal-loki-loki-distributed-compactor-1
kubectl -n monitor-log delete pvc data-loki-loki-distributed-index-gateway-0 data-loki-loki-distributed-index-gateway-1
```



```
  resources:
    requests:
      cpu: 100m
      memory: 128Mi
    limits:
      cpu: 10000m
      memory: 12800Mi
```



# 调试


```
kubectl -n monitor-log get pvc
kubectl -n monitor-log describe pvc data-loki-loki-distributed-ingester-0

kubectl -n monitor-log get all
kubectl -n monitor-log get pod -o wide
kubectl -n monitor-log get svc
kubectl -n monitor-log describe pod loki-loki-distributed-gateway-858d5d76b6-82bxb
kubectl -n monitor-log describe pod loki-loki-distributed-query-frontend-5c6df4bf87-szdh8
kubectl -n monitor-log describe pod loki-loki-distributed-querier-0
kubectl -n monitor-log describe pod loki-loki-distributed-distributor-6959c77fb9-6wzsh
kubectl -n monitor-log describe pod loki-loki-distributed-ingester-0
kubectl -n monitor-log describe pod loki-loki-distributed-compactor-0

kubectl -n monitor-log edit svc loki-loki-distributed-memberlist
    publishNotReadyAddresses: true
kubectl -n monitor-log get endpoints loki-loki-distributed-memberlist
    querier
    ingester
    distributor
    


kubectl -n monitor-log logs -f --tail 300 deploy/loki-loki-distributed-gateway
kubectl -n monitor-log logs -f --tail 300 deploy/loki-loki-distributed-query-frontend
kubectl -n monitor-log logs -f --tail 300 deploy/loki-loki-distributed-querier
kubectl -n monitor-log logs -f --tail 3000 loki-loki-distributed-ingester-0
kubectl -n monitor-log logs -f --tail 3000 loki-loki-distributed-ingester-1
kubectl -n monitor-log logs -f --tail 300 deploy/loki-loki-distributed-distributor
kubectl -n monitor-log logs -f --tail 300 loki-loki-distributed-ruler-0
kubectl -n monitor-log logs -f --tail 300 loki-loki-distributed-ruler-1
kubectl -n monitor-log logs -f --tail 300 loki-loki-distributed-index-gateway-0
kubectl -n monitor-log logs -f --tail 300 loki-loki-distributed-index-gateway-1
kubectl -n monitor-log logs -f --tail 300 loki-loki-distributed-compactor-0
kubectl -n monitor-log logs -f --tail 300 loki-loki-distributed-compactor-1


kubectl -n monitor-log delete pod loki-loki-distributed-query-frontend-7dfff545b9-xj4n5
kubectl -n monitor-log delete pod loki-loki-distributed-ingester-0
kubectl -n monitor-log delete pod loki-loki-distributed-distributor-6959c77fb9-k29s5
kubectl -n monitor-log delete pod loki-loki-distributed-gateway-78d746d54-k6qkd
kubectl -n monitor-log delete pod -l app.kubernetes.io/component=ruler
kubectl -n monitor-log delete pod loki-loki-distributed-compactor-0
kubectl -n monitor-log delete pod loki-loki-distributed-compactor-1


kubectl -n monitor-log exec -it loki-loki-distributed-ruler-79697c78b6-shxwl -- sh
    curl http://alertmanager-main.monitoring.svc.cluster.local:9093/api/v1/alerts
kubectl -n monitor-log exec -it loki-loki-distributed-ingester-0 -- sh
```

```shell
kubectl -n monitor-log get pod|grep ruler
kubectl -n monitor-log delete pod   loki-loki-distributed-ruler-79697c78b6-4z5jr
kubectl -n monitor-log logs -f --tail 300 deploy/loki-loki-distributed-ruler
```


## 调试agent

```
kubectl -n monitor-log get pod -o wide|grep promtail
kubectl -n monitor-log logs -f --tail 300 promtail-jmctj
kubectl -n monitor-log logs -f --tail 300 promtail-tn9sg
kubectl -n monitor-log logs -f --tail 300 promtail-zjxf6
kubectl -n monitor-log exec -it promtail-5pjnk -- bash
```



```
通过
          - replacement: kubernetes-pods
            target_label: scrape_job
配置job类型
```



# 配置loki 到 grafana

添加datasource, loki

Default

http://loki-loki-distributed-gateway.monitor-log



# 配置loki查询账号

为loki创建readonly账号, 权限为Editor

在Preferences修改Timezone为Browser Time

登陆readonly账号, 在Preferences修改Timezone为Browser Time

# 如何使用

参考文档:  ` doc/研发如何查询指定服务的日志.md`





# 关于loki

架构原理: https://grafana.com/docs/loki/latest/fundamentals/architecture/components/





# 存储

参考文档:

​	https://grafana.com/docs/loki/latest/operations/storage/

​	https://grafana.com/docs/loki/latest/operations/storage/boltdb-shipper/

​	



需要使用集群方式

不能使用块存储, 需要使用(远程)文件存储和远程对象存储

索引(boltdb-shipper)和块(aws-s3)



s3
	自定义存储桶清理策略



# 其他方案

es

​	成本高

clickhouse

​	暂不成熟, 集群方案复杂, 中等规模

​	适用于分析数据问题

loki
	成本低、小规模、无聚合

​	适用于分析代码问题
