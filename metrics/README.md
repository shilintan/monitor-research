[toc]

# 部署

```
kubectl apply --server-side -f kube-prometheus/manifests/setup
kubectl wait \
	--for condition=Established \
	--all CustomResourceDefinition \
	--namespace=monitoring

kubectl apply -f pvc.yaml
kubectl apply -f local
kubectl apply -f kube-prometheus/manifests
kubectl apply -f kube-prometheus/custom
kubectl apply -f kube-prometheus/custom/rule
kubectl apply -f kube-prometheus/custom/rule-extra
```



# 配置中间件告警规则

ceph

```
kubectl apply -f service/ceph/ceph-rules.yaml
```



# 钉钉通知

创建群

创建机器人

​	自定义关键词

```
info
warning
critical
firing
```

# 配置loki查询账号

为loki创建readonly账号, 权限为Editor

在Preferences修改Timezone为Browser Time

登陆readonly账号, 在Preferences修改Timezone为Browser Time



# 清理(从下往上执行)

```shell
kubectl delete -f kube-prometheus/manifests/setup

kubectl delete -f pvc.yaml
kubectl delete -f local
kubectl delete -f kube-prometheus/manifests
kubectl delete -f kube-prometheus/custom
kubectl delete -f kube-prometheus/custom/rule
kubectl delete -f kube-prometheus/custom/rule-extra

kubectl -n monitoring delete pvc prometheus-k8s-db-prometheus-k8s-0 prometheus-k8s-db-prometheus-k8s-1
```

# 调试


```shell
kubectl -n monitoring get pvc
kubectl get pv|grep monitoring
kubectl -n monitoring edit pvc prometheus-k8s-db-prometheus-k8s-0
kubectl -n monitoring describe pvc grafana
kubectl -n monitoring describe pvc prometheus-k8s-db-prometheus-k8s-0
kubectl -n monitoring get pod -o wide
kubectl -n monitoring get pod prometheus-k8s-0 -o yaml
kubectl -n monitoring get svc
kubectl -n monitoring get endpoints
kubectl -n monitoring get ingress
kubectl -n monitoring describe pod alertmanager-main-0
kubectl -n monitoring describe pod prometheus-k8s-0
kubectl -n monitoring describe pod prometheus-k8s-1
kubectl -n monitoring describe pod -l app.kubernetes.io/component=grafana
kubectl -n monitoring describe pod prometheus-operator-776c6c6b87-mfdnt
kubectl -n monitoring delete pod prometheus-k8s-0
kubectl -n monitoring delete pod prometheus-k8s-1
kubectl -n monitoring delete pod dingding-webhook-6cdf9b9cbc-t6vd7
kubectl -n monitoring delete pod alertmanager-main-0
kubectl -n monitoring delete pod alertmanager-main-1
kubectl -n monitoring delete pvc grafana prometheus-k8s-db-prometheus-k8s-0


kubectl -n monitoring get networkpolicy

kubectl -n monitoring delete networkpolicy grafana prometheus-adapter prometheus-k8s prometheus-operator node-exporter blackbox-exporter kube-state-metrics 



kubectl -n monitoring logs -f --tail 300 deploy/prometheus-operator
kubectl -n monitoring logs -f --tail 300 deploy/grafana
kubectl -n monitoring logs -f --tail 300 prometheus-k8s-0
kubectl -n monitoring logs -f --tail 300 prometheus-k8s-1
kubectl -n monitoring logs -f --tail 300 alertmanager-main-0
kubectl -n monitoring logs -f --tail 300 alertmanager-main-1
kubectl -n monitoring logs -f --tail 300 deploy/dingding-webhook
kubectl -n monitoring logs -f --tail 300 deploy/kube-state-metrics

kubectl -n monitoring logs -f --tail 300 dingding-webhook-86b8d959c-9ggxq
kubectl -n monitoring describe pod dingding-webhook-86b8d959c-9ggxq

kubectl -n monitoring exec -it prometheus-k8s-0 -- bash
```



```shell
# 重新加载容器配置文件
curl -X POST http://prometheus.prod.your-domain-name.com/-/reload
```



prometheus 配置文件 `/etc/prometheus/config_out/prometheus.env.yaml`

# 访问

http://192.168.0.118:30675

http://prometheus.local.your-domain-name.com

http://grafana.local.your-domain-name.com              admin/admin

http://alertmanager.local.your-domain-name.com





# grafana安装插件

pmm-pt-summary-panel

```
kubectl -n monitoring exec -it grafana-7b4c5698c8-9pjhf -- bash
grafana-cli plugins install grafana-polystat-panel

kubectl -n monitoring logs -f --tail 300 deploy/grafana
kubectl -n monitoring delete pod grafana-7b4c5698c8-9pjhf
```





# 调试serviceMonitor

```shell
kubectl logs load-generator
kubectl delete pod load-generator
kubectl run -it --tty load-generator --image=alpine/curl:8.4.0 -- sh

  curl http://mysql-server-metrics.dev.svc.cluster.local:9104
  curl http://elasticsearch.dev.svc.cluster.local:9114/metrics
```