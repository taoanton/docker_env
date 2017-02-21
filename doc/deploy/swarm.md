# Swarm集群部署

## 安装swarm

```bash
docker pull swarm:<tag>
```

## 集群
```
# 获取全球token，作为集群唯一标识, 记住这个token
docker run --rm swarm create
e837693901333a2a31671aabe0715f8d

eval $(docker-machine env manager)
docker run -d swarm join --addr=$(docker-machine ip manager):2376 token://e837693901333a2a31671aabe0715f8d
docker run -d -p 3376:3376 -t -v /var/lib/boot2docker:/certs:ro swarm manage -H 0.0.0.0:3376 --tlsverify --tlscacert=/certs/ca.pem --tlscert=/certs/server.pem --tlskey=/certs/server-key.pem token://e837693901333a2a31671aabe0715f8d

eval $(docker-machine env agent1)
docker run -d swarm join --addr=$(docker-machine ip agent1):2376 token://e837693901333a2a31671aabe0715f8d

eval $(docker-machine env agent2)
docker run -d swarm join --addr=$(docker-machine ip agent2):2376 token://e837693901333a2a31671aabe0715f8d

# 加入集群
docker run -d swarm join -addr=192.168.99.102:2375 token://e837693901333a2a31671aabe0715f8d
docker run -d swarm join -addr=192.168.99.100:2375 token://e837693901333a2a31671aabe0715f8d

# 启动管理机
docker run -d -p 2377:2375 swarm manage token://e837693901333a2a31671aabe0715f8d
docker run -d -p 2377:2375 -v $(pwd)/cluster:/tmp/cluster swarm manage file:///tmp/cluster


# 
docker -H 192.168.99.102:2377 info
docker -H $(docker-machine ip manager):2377 info

# 查看集群所有节点信息。在任何一台机器上执行
docker run --rm swarm list token://e837693901333a2a31671aabe0715f8d
```

## 错误
执行`docker-machine ls`是出现以下错误：  
```
NAME      ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER        ERRORS
agent1    -        virtualbox   Running   tcp://192.168.99.102:2376           Unknown       Unable to query docker version: Get https://192.168.99.102:2376/v1.15/version: x509: certificate is valid for 192.168.99.107, not 192.168.99.102

# 修复方法
docker-machine regenerate-certs [name]
```

docker login -u=someuser -p=password registry.somedomain.com
export DOCKER_HOST=$(docker-machine ip manager):3376
eval "$(docker-machine env --swarm manager)"


