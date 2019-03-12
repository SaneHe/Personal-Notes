## 五类 `IP` 地址的范围

IP地址分为 `A`, `B`, `C`, `D`, `E`五类。

- 网络号：用于识别主机所在的网络；
- 主机号：用于识别该网络中的主机。

##### 其中 `A` 类分配给政府机关使用，`B` 类地址给大中型企业使用，`C` 类地址给个人使用。这三种是主要的。

>IP地址分为五类，`A` 类保留给政府机构，`B` 类分配给中等规模的公司，`C` 类分配给任何需要的
>人，`D` 类用于组播，`E` 类用于实验，各类可容纳的地址数目不同。

其中 `A` 类、`B` 类、和 `C` 类这三类地址用于 `TCP/IP` 节点，其它两类 `D` 类和 `E` 类被用
于特殊用途。`A`、`B`、`C`三类 `IP` 地址的特征：当把 `IP` 地址写成二进制形式时，`A` 类地址的第一位总是 `0`，`B` 类地址的前两位总是 `10`，`C` 类地址的前三位总是 `110`。

#### `A` 类地址
- `A` 类地址第1字节为网络地址，其它3个字节为主机地址。
- `A` 类地址范围：`1.0.0.1` — `126.155.255.254`
- `A` 类地址中的私有地址和保留地址：
    - `10.X.X.X` 是私有地址（所谓的私有地址就是在互联网上不使用，而被用在局域网络中的地址）
    - `127.X.X.X` 是保留地址，用做循环测试用的

#### `B` 类地址

- `B` 类地址第1字节和第2字节为`网络地址`，其它2个字节为`主机地址`。
- `B` 类地址范围：`128.0.0.1` — `191.255.255.254`。
- `B` 类地址的私有地址和保留地址：
    - `172.16.0.0` — `172.31.255.255` 是私有地址
    - `169.254.X.X` 是保留地址。如果你的IP地址是自动获取IP地址，而你在网络上又没有找到可用的DHCP服务器。就会得到其中一个IP
  
#### `C` 类地址

- `C` 类地址第1字节、第2字节和第3个字节为网络地址，第4个个字节为主机地址。另外第1个字节的前三位固定为110。
- `C` 类地址范围：`192.0.0.1` — `223.255.255.254`。
- `C` 类地址中的私有地址：
    - `192.168.X.X` 是私有地址。

#### `D` 类地址

- `D` 类地址不分网络地址和主机地址，它的第1个字节的前四位固定为1110。
- `D` 类地址范围：`224.0.0.1` — `239.255.255.254`
- 
#### `E` 类地址

- `E` 类地址也不分网络地址和主机地址，它的第1个字节的前五位固定为11110。
- `E` 类地址范围：240.0.0.1—255.255.255.254