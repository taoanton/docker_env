docker环境搭建

## command
```bash
sudo docker run -i -t -p 80:80 dev/nginx bash
sudo docker run --name nginx1 -d -p 8080:80 dev/nginx

sudo docker exec -it <container> bash

sudo docker build -t my-nginx .

docker tag hello-world 127.0.0.1:5000/hello-world

# 删除停止的镜像
sudo docker ps -f "status=exited" --format "{{.ID}}" |xargs sudo docker rm
sudo docker rm -f `sudo docker ps -aq`
sudo docker stop `sudo docker ps -q`

# 删除unstage镜像
docker rmi $(docker images | grep "^<none>" | awk "{print $3}")

docker logs <container id>

杀死所有正在运行的容器
docker kill $(docker ps -a -q)

删除所有已经停止的容器
docker rm $(docker ps -a -q)

删除所有未打 dangling 标签的镜像
docker rmi $(docker images -q -f dangling=true)

删除所有镜像
docker rmi $(docker images -q)

导出容器
docker export php_php > registry.domain.com-dev-php-5.6.tar
```

## registry
sudo docker run -d -v /opt/registry:/var/lib/registry -p 5000:5000 --restart=always --name registry registry:2.4.1
sudo docker run -d -p 9000:9000 --privileged -v /var/run/docker.sock:/var/run/docker.sock uifd/ui-for-docker

ps -aux|grep nginx  

## ansible 
```
# 
ansible vagrant1 -i hosts -m ping

# openresty image.server
docker run -d -p 8081:80 -v /www/image.server:/www/now/image.server  --restart=always --name openresty openresty/openresty
```


rancher
```

# add host

sudo docker run -d --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/rancher:/var/lib/rancher rancher/agent:v1.0.2 http://172.16.1.222:8085/v1/scripts/786B1EC9C8DC911B4255:1467705600000:Z1qUbExWBZ6qB8UHSht1RWXGdE
```

## daocloud
curl -sSL https://get.daocloud.io/daomonit/install.sh | sh -s abd36a496653f0349545c337e50ddeb5839159ae

> https://get.daocloud.io/toolbox/

## Intellij Idea use docker
https://www.jetbrains.com/help/idea/2016.1/docker.html
https://www.jetbrains.com/help/idea/2016.1/run-debug-configuration-docker-deployment.html