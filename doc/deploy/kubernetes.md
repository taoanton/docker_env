# Kubernetes

## 安装Etcd
```
# 下载
wget https://github.com/coreos/etcd/releases/download/v2.3.7/etcd-v2.3.7-linux-amd64.tar.gz
tar zxvf etcd-v2.3.7-linux-amd64.tar.gz
cd etcd-v2.3.7-linux-amd64.tar.gz
cp etcd /usr/bin/etcd
cp etcdctl /usr/bin/etcdctl

# 安装
docker run -d \
  --net=host \
  --restart=always \
  --name=etcd \
  -v /var/etcd/data:/var/etcd/data \
  gcr.io/google_containers/etcd:2.2.1 \
  /usr/local/bin/etcd \
  --addr=192.168.33.11:4001 \
  --bind-addr=0.0.0.0:4001 \
  --data-dir=/var/etcd/data

# 查询健康状态
etcdctl -C http://192.168.33.11:4001 cluster-health
```

接下来往etcd里插入flannel的配置数据。这里指定flannel可以使用的IP地址为10.0.0.0/8区间：
```
docker exec -it etcd etcdctl set /kube.app/network/config '{"Network": "10.0.0.0/8"}'
flanneld --etcd-endpoints=http://192.168.33.11:4001 --etcd-prefix=/kube.app/network --iface=eth1 > flannel.log 2>&1 &
cat flannel.log
```

运行Kubernetes Apiserver
```
docker run -d \
  --name=apiserver \
  --restart=always \
  --net=host \
  gcr.io/google_containers/kube-apiserver:7bf05b2d35172296e4fbd2604362456f \
  kube-apiserver \
  --insecure-bind-address=192.168.33.11 \
  --service-cluster-ip-range=11.0.0.0/16 \
  --etcd-servers=http://192.168.33.11:4001
```

运行Kubernetes Controller Manager
```
docker run -d \
  --name=cm \
  --restart=always \
  gcr.io/google_containers/kube-controller-manager:6c95ef0b57ac9deda34ae1a4a40baa0a \
  kube-controller-manager \
  --master=192.168.33.11:8080
```

运行Kubernetes Scheduler
```
docker run -d \
  --name=scheduler \
  --restart=always \
  gcr.io/google_containers/kube-scheduler:e5342c3d8ced06850af97347daf6ae4b \
  kube-scheduler \
  --master=192.168.33.11:8080
```
服务器启动完毕，可以运行以下命令来查看版本
```
kubectl -s 192.168.33.11:8080 version
```

运行Kubernetes Proxy
```
docker run -d \
  --name=proxy \
  --restart=always \
  
  gcr.io/google_containers/kube-proxy:89f6cb912fe69a0ec8987f614199fc06 \
  --master=192.168.33.11:8080
```
