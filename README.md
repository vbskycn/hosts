# 一键修改hostshosts
一键修改hosts，让你的linux可以直连github,tmdb





**你可以使用`curl`或者`wget`来下载并执行这个程序。下面是两种不同的方法：**

使用`curl`：

```bash
curl -fsSL https://mirror.ghproxy.com/raw.githubusercontent.com/vbskycn/hosts/master/auto_hosts.sh | bash
```

使用`wget`：

```bash
wget -qO- https://mirror.ghproxy.com/raw.githubusercontent.com/vbskycn/hosts/master/auto_hosts.sh | bash
```

![image-20240515093447944](https://img-cloud.zhoujie218.top/2024/05/15/66441139cd969.png)



**可以定时每天3点自动执行**

```bash
crontab -e
```

然后，在文件末尾添加以下行：

```bash
0 3 * * * curl -fsSL https://mirror.ghproxy.com/raw.githubusercontent.com/vbskycn/hosts/master/auto_hosts.sh | bash
```

保存并退出编辑器。cron 将会在每天的凌晨 3 点自动执行该脚本。