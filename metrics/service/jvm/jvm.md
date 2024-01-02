下载agent:

https://github.com/prometheus/jmx_exporter



测试集成

```
java -javaagent:jmx_prometheus_javaagent-0.20.0.jar=12345:jmx_exporter_config.yaml -jar test.jar
```

访问: http://localhost:12345





