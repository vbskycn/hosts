# GitHub Hosts 更新工具

这是一个用于自动更新 GitHub 相关 hosts 配置的工具，可以帮助提升 GitHub 的访问速度。

## 功能特点

- 自动获取最新的 GitHub hosts 配置
- 自动备份原有的 hosts 文件（备份文件格式：/etc/hosts.backup.时间戳）
- 使用特殊标记，不影响其他 hosts 配置
- 自动刷新 DNS 缓存
- 支持一键删除配置

## 使用方法

### 方法一：直接运行（推荐）

```
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/vbskycn/hosts/refs/heads/master/update-github-hosts.sh)"
```

### 方法二：下载后运行

1. 下载脚本：

```
curl -O https://raw.githubusercontent.com/vbskycn/hosts/refs/heads/master/update-github-hosts.sh
```

2. 添加执行权限：

```
chmod +x update-github-hosts.sh
```

3. 运行脚本：

```
sudo ./update-github-hosts.sh
```

### 删除 hosts 配置

```
sudo ./update-github-hosts.sh --remove
```

**注意事项：**

- 脚本需要 root 权限运行
- 每次运行都会自动备份原有的 hosts 文件
- 使用 --remove 参数可以删除之前添加的配置
- 脚本会自动处理已存在的配置，无需手动删除