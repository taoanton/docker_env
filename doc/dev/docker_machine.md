# Docker Machine

## 常用命令
```bash
# 

# 创建machine
docker-machine create --driver <类型> <machine名>
docker-machine create --driver virtualbox default
docker-machine create -d virtualbox default
# 设置内存和硬盘大小 以下示例分配了100G虚拟硬盘 4G内存
docker-machine create --driver virtualbox --virtualbox-disk-size "100000" --virtualbox-memory 4096 default

# 进入machine
docker-machine ssh default

# 查看所有machine
docker-machine ls

# 获取ip
docker-machine ip default

# 重启
docker-machine restart default
```

## 错误
```
Error response from daemon: ... no space left on device
```
`no space left on device`磁盘空间不足

```
Error checking TLS connection: Error checking and/or regenerating the certs: There was an error validating certificates for host "192.168.99.100:2376": x509: certificate is valid for 192.168.99.102, not 192.168.99.100
You can attempt to regenerate them using 'docker-machine regenerate-certs [name]'.
Be advised that this will trigger a Docker daemon restart which will stop running containers.
```
执行以下命令
```
docker-machine regenerate-certs [name]
```