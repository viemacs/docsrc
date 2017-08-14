---
title: Network
weight: 20
---

## Cloud

云计算，是用互联网来接入存储或者运行在远程服务器端的应用，数据，服务。所以云计算行业包括了使用基于互联网的方法来计算，存储和开发的公司，或说是在互联网上提供其服务的公司。

### IaaS, PasS, SaaS

云计算可以分为不同层次：基础设施-平台-软件，即 Infrastructure as a Service, Platform as a Service, Software as a Service。

- IaaS: Infrastructure-as-a-Service 基础设施即服务

    提供了远程服务器、存储等网络硬件，使企业在运行应用时不再需要购买服务器等硬件，节省了维护成本和办公场地。实际提供 IaaS 的公司，如 Amozon，MicroSoft，VMWare，Rackspace，RedHat，不仅提供服务器，还会单独提供计算能力。

- Paas: Platform-as-a-Service 平台即服务

    PaaS，也可以叫中间件，使企业的所有开发都能够在这里进行，以节省时间和资源。PaaS 提供了各种开发和分发应用的解决方案，如虚拟服务器和操作系统。如网页应用管理、应用设计、应用虚拟主机、存储、安全、应用开发协作工具。

    大型 PaaS 提供商有: Google App Engine, Microsoft Azure, Force.com, Heroku, Engine Yard; 以及新兴的 AppFog, Mendix, Standing Cloud.

- SaaS: Software-as-a-Service 软件即服务

    通过远程服务器来运行的应用，就属于 SaaS，也是消费者每天接触到的一层云服务。这类服务常由网页接入，商用+家用的如 Netflx, MOG, Google Apps, Box.net, Dropbox, iCloud。商用 SaaS 应用如 GoToMeeting (Citrix), WebEx (Cisco), CRM (Salesforce), ADP, SuccessFactors (Workday)。

    SaaS 之前还有 Application Service Provider 的概念。SaaS 并不一定是B/S架构，重要的是让用户依赖于你在网络上提供的服务，而运营的重点也是如何持续稳定地提供服务。

    除了业务服务本身外，SaaS 还需要保障几个服务：

    - 服务发现，寻找可用业务服务
    - 模块更新，保证客户端模块更新
    - 业务服务容器，提供业务服务
    - 离线更新，保障分布式系统的数据安全 （？？）
