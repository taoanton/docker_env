# Docker Compose

## YML语法
image:镜像的ID  
build:直接从pwd的Dockerfile来build，而非通过image选项来pull  
links：连接到那些容器。每个占一行，格式为SERVICE[:ALIAS],例如 – db[:database]  
external_links：连接到该compose.yaml文件之外的容器中，比如是提供共享或者通用服务的容器服务。格式同links  
command：替换默认的command命令  
ports: 导出端口。格式可以是：  

<a name="command"></a>
## 常用命令
```
# 启动容器 -d是后台运行
docker-compose up -d
# 启动/重启
docker-compose restart
docker-compose start
# 删除所有
docker-compose rm --all
# 构建或重新构建镜像
docker-compose build
```


## 安装Docker Compose
下载地址： https://github.com/docker/compose/releases
```bash
curl -L https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```
参考：
> https://docs.docker.com/compose/install/