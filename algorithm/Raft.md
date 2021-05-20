# `Raft`

> `Raft` 算法是对 `Paxos` 算法的简化、改进

1. `Leader` 总统节点，负责发出提案
2. `Follower` 追随者节点，负责同意 `Leader` 发出的提案
3. `Candidate` 候选人，负责争夺 `Leader`

### 步骤

> `Raft`  将一致性问题分解为两个的子问题，`Leader选举` 和 `状态复制`

#### `Leader` 选举

1. 每个 `Follower` 都持有一个定时器

2. 当定时器时间到了而集群中仍然没有 `Leader`，`Follower` 将声明自己是 `Candidate` 并参与 `Leader` 选举，同时将消息发给其他节点来争取他们的投票，若其他节点长时间没有响应 `Candidate` 将重新发送选举信息

3. 集群中其他节点将给 `Candidate` 投票

4. 获得多数派支持的 `Candidate` 将成为第M任 `Leader`（M任是最新的任期）

5. 在任期内的 `Leader` 会不断发送心跳给其他节点证明自己还活着，其他节点受到心跳以后就清空自己的计时器并回复 `Leader` 的心跳。这个机制保证其他节点不会在 `Leader` 任期内参加 `Leader` 选举

6. 当 `Leader` 节点出现故障而导致 `Leader` 失联，没有接收到心跳的 `Follower` 节点将准备成为 `Candidate` 进入下一轮 `Leader` 选举

7. 若出现两个 `Candidate` 同时选举并获得了相同的票数，那么这两个 `Candidate` 将随机推迟一段时间后再向其他节点发出投票请求，这保证了再次发送投票请求以后不冲突

#### 状态复制

1. `Leader` 负责接收来自 `Client` 的提案请求

2. 提案内容将包含在 `Leader` 发出的下一个心跳中

3. `Follower` 接收到心跳以后回复 `Leader` 的心跳

4. `Leader` 接收到多数派 `Follower` 的回复以后确认提案并写入自己的存储空间中并回复 `Client`

5. `Leader` 通知 `Follower` 节点确认提案并写入自己的存储空间，随后所有的节点都拥有相同的数据

6. 若集群中出现网络异常，导致集群被分割，将出现多个 `Leader`

7. 被分割出的非多数派集群将无法达到共识，即脑裂

8. 当集群再次连通时，将只听从最新任期 `Leader` 的指挥，`旧Leader` 将退化为 `Follower`，此时集群重新达到一致性状态

# 搬迁

- [知乎](https://zhuanlan.zhihu.com/p/130332285)
- [知乎2](https://zhuanlan.zhihu.com/p/147691282)
