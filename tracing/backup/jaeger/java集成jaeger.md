# 集成



```
export JAVA_TOOL_OPTIONS="-javaagent:opentelemetry-javaagent.jar"
export OTEL_SERVICE_NAME="test"
```



```
OTEL_TRACES_EXPORTER=jaeger
OTEL_EXPORTER_JAEGER_ENDPOINT=http://jaeger-collector.tracing:14250
OTEL_EXPORTER_JAEGER_TIMEOUT=10000
```



```
java -jar test.jar
```





# 测试

```
export OTEL_TRACES_EXPORTER=jaeger
export OTEL_EXPORTER_JAEGER_ENDPOINT=http://192.168.2.34:31151
export OTEL_EXPORTER_JAEGER_TIMEOUT=10000
```



# 参考文档

https://opentelemetry.io/docs/instrumentation/java/automatic/

https://opentelemetry.io/docs/instrumentation/java/automatic/agent-config/

https://github.com/open-telemetry/opentelemetry-java/blob/main/sdk-extensions/autoconfigure/README.md#jaeger-exporter

