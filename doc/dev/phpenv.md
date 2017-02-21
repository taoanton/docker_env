# PHP开发环境搭建

## 搭建步骤
1.启动`Docker Quickstart Terminal`
![](../images/applications_folder.png)

2.导入镜像  
```
# 导入本地镜像文件
docker load -i registry.somedomain.com-dev-tomcat.8.0.tar
docker load -i registry.somedomain.com-dev-mysql.5.6.tar
docker load -i registry.somedomain.com-dev-redis.3.2.tar
# 通过命令获取镜像
docker pull registry.somedomain.com/dev/tomcat:8.0
```

3.启动
```
cd php_env
./compose.sh start // 启动
start		// 启动
restart		// 重启
deploy		// 部署站点
rm			// 删除容器
stop		// 停止
up			// 启动+部署+重启
ssh			// 进入容器
```

