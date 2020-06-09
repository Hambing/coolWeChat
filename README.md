# coolWeChat

这是一个Docker images, 基础镜像来自coolq，coolq是一个好东东，该项目名的灵感也来自coolq, 在此一并表示感谢；他们的github链接：https://github.com/CoolQ/docker-wine-coolq

好吧，现在说说coolWechat能干啥呗。现在请打开你的微信。是不是很卡？是不是十几年的聊天记录也不舍的删除，生怕那天要用？对的备份到PC是可以。可是这么私密的信息也不想备份到公司电脑吧？备份到家里的电脑又不想开机，也怕硬盘坏啦。

对啦，这宝物就是帮你备份微信聊天记录的，具体思路如下：
1. 你最好有个群晖，黑的白的，黄的绿的，都行。
2. 在群晖里安装docker
3. 注册表里搜索coolwechat，下载
4. 启动，并映射两个目录：群晖docker目录下的CoolWeChat/WeChat Files/ 到 容器 '/home/user/WeChat Files/' 群晖docker目录下的CoolWeChat/Applcation Data 到'/home/user/.wine/drive_c/users/user/Application Data/'

5. 网络用主机网络，这个黑重要！！！

6. 启动容器，浏览器访问：http://群晖ip:9000，输入密码：MAX8char，是不是已经有一个微信在那里等你了。掏出手机扫他。然后备份。

7. 备份文件都在群晖的docker目录下的CoolWeChat中。如果你的群晖有作RAID，数据是不是感觉很安全。

8. 什么，你没有群晖？好吧，那你用ubuntu玩玩呗。wget htt://github.com/bingor-lee/coolWeChat/docoolwechat.sh    chmod 777 ./docoolwechat.sh   执行他。
