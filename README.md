# Deploy Harbor HA with ansible
*Wise2C ansible playbook to deploy Harbor HA with GlusterFS and Percorna XtraDB Cluster*
![alt](img/Harbor\ High\ Availability\ Architecture.jpg)

**Before_install:  
需要配置部署机对目标机进行SSH免密登录**
```
ssh-copy-id 192.168.93.138  
ssh-copy-id 192.168.93.143  
...
```
1. 根据实际请求修改hosts  
```
[yumrepo]
192.168.92.139

[glusterfs]
192.168.92.138 
192.168.92.143 
192.168.92.144 

[pxc]
192.168.92.138 
192.168.92.145 
192.168.92.146 

[harbor]
192.168.92.147
192.168.92.148
```

2. 根据实际情况修改group_vars  
* all:  
```
yumrepo: 192.168.92.139 # 指定私有YUM源地址
```
* glusterfs:  
```
brick_dir: /data/glusterfs/gv0 # GlusterFS Cluster本地brick路径
keepalived_rid: 10             # Keepalived服务器的路由标识。在一个局域网内，此标识应该唯一   
keepalived_interface: ens32    # Keepalived的网卡
keepalived_vrid: 110           # 虚拟路由ID标识，这个标识最好是一个数字，并在keepalived.conf配置中唯一
                               # MASTER和BACKUP配置中相同vrrp实例的virtual_router_id必须一致，否则将出现脑裂问题
keepalived_vip: 192.168.92.140 # 虚IP
```
* pxc:  
```
pxc_dir: /data/pxc             # PXC data路径
pxc_password: abc@12345        # PXC root password
sst_password: sst@12345        # PXC sst password
keepalived_rid: 11
keepalived_interface: ens32
keepalived_vrid: 111
keepalived_vip: 192.168.92.141
```
* harbor:  
```
gfs_ip: 192.168.92.140        # 指定mount GlusterFS的IP，即 glusterfs.keepalived_vip
pxc_ip: 192.168.92.141        # 指定PXC的IP，即 pxc.keepalived_vip
registry: 192.168.92.142      # 安装docker时指定的Insecure Registries
pxc_password: abc@12345       # PXC root password
harbor_password: Harbor12345  # Harbor admin password
keepalived_rid: 12          
keepalived_interface: ens32
keepalived_vrid: 112
keepalived_vip: 192.168.92.142
```
3. 启动安装程序
```
docker-compose up -d
```
4. 进入容器
```
docker exec -ti deploy-playbook bash
```
5. 执行ansible-playbook
* install
```
cd /workspace
ansible-playbook -f 0.test.yml -i hosts
ansible-playbook -f 1.yumrepo.yml -i hosts
ansible-playbook -f 2.gfs.yml -i hosts
ansible-playbook -f 3.pxc.yml -i hosts
ansible-playbook -f 4.docker.yml -i hosts
ansible-playbook -f 5.harbor.yml -i hosts
```
* remove
```
cd /workspace
ansible-playbook -f 5.harbor.reset.yml -i hosts
ansible-playbook -f 3.pxc.reset.yml -i hosts
ansible-playbook -f 2.gfs.reset.yml -i hosts
...
```
6. 文件说明
```
0.test.yml           # 测试ansible到hosts是否通畅
1.yumrepo.yml        # 安装私有YUM源
2.gfs.yml            # 安装GlusterFS
2.gfs.reset.yml      # 卸载GlusterFS
3.pxc.yml            # 安装PXC
3.pxc.reset.yml      # 卸载PXC
4.docker.yml         # 安装Docker
5.harbor.yml         # 安装Harbor
5.harbor.reset.yml   # 卸载Harbor
files                # 离线安装需要用到的文件
group_vars           # 主机组变量，需根据实际环境修改
hosts                # 主机文件，需根据实际环境修改
scripts              # 安装需要的脚本
templates            # 安装需要的Jinjia2模版文件
```
