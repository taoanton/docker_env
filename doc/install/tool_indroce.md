# 工具介绍

在2014年底，Docker公司提出了三个容器编排（orchestration ）工具Docker Machine、Compose与Swarm；它们可以简化Docker环境的创建，应用的组装以及集群管理。

## Docker Machine
在没有Machine时，安装docker需要根据不同的OS使用不同的安装方法，配置文件也在不同的位置，流程复杂而且不简单方便。  
Docker Machine简化了部署的复杂度，无论是在本机的虚拟机上还是在公有云平台，只需要一条命令便可搭建好Docker主机

## Docker Compose
Docker Compose 是 Docker 官方编排（Orchestration）项目之一，负责快速在集群中部署分布式应用。  
Compose是用来在Docker中定义和运行复杂应用的工具，前身是 Fig，兼容 Fig 的模板文件。

Dockerfile 可以让用户管理一个单独的应用容器；而 Compose 则允许用户通过模板（docker-compose.yml）维护所有应用程序容器的逻辑定义以及它们之间的连接关系

## Docker Swarm
Machine帮我们快速构建docker的单机环境。  
Docker Swarm是一个集群管理和调度工具，它会基于应用程序的生命周期、容器的使用与性能的需求自动优化分布式应用程序的基础架构。


## Docker Registry

