# 常用命令

* docker images 显示本地已有镜像
* docker info 显示docker系统信息
* docker commit -m -a 提交更新后的镜像
* docker build 通过Dockerfile来构建镜像
* docker import 本地导入镜像
* docker search 查找仓库中镜像
* docker push 将镜像推送到仓库
* docker pull 将仓库中镜像下载到本地
* docker save -o mysql_5.6.tar mysql:5.6 导出镜像到本地
* docker load < mysql_5.6.tar 载入镜像
* docker rmi 移除镜像
* docker attach 运行中容器的stdin，进行命令执行的动作
* docker history 显示镜像的历史
