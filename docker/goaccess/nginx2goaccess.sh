#!/bin/bash
#
# Convert from this:
#   http://nginx.org/en/docs/http/ngx_http_log_module.html
# To this:
#   https://goaccess.io/man
#
# Conversion table:
#   $time_local         %d:%t %^
#   $host               %v
#   $http_host          %v
#   $remote_addr        %h
#   $request_time       %T
#   $request_method     %m
#   $request_uri        %U
#   $server_protocol    %H
#   $request            %r
#   $status             %s
#   $body_bytes_sent    %b
#   $bytes_sent         %b
#   $http_referer       %R
#   $http_user_agent    %u
#
# Samples:
#
# log_format combined '$remote_addr - $remote_user [$time_local] '
# '"$request" $status $body_bytes_sent '
# '"$http_referer" "$http_user_agent"';
#   ./nginx2goaccess.sh '$remote_addr - $remote_user [$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent"'
#
# log_format compression '$remote_addr - $remote_user [$time_local] '
# '"$request" $status $bytes_sent '
# '"$http_referer" "$http_user_agent" "$gzip_ratio"';
#   ./nginx2goaccess.sh '$remote_addr - $remote_user [$time_local] "$request" $status $bytes_sent "$http_referer" "$http_user_agent" "$gzip_ratio"'
#
# log_format main
# '$remote_addr\t$time_local\t$host\t$request\t$http_referer\t$http_x_mobile_group\t'
# 'Local:\t$status\t$body_bytes_sent\t$request_time\t'
# 'Proxy:\t$upstream_cache_status\t$upstream_status\t$upstream_response_length\t$upstream_response_time\t'
# 'Agent:\t$http_user_agent\t'
# 'Fwd:\t$http_x_forwarded_for';
#   ./nginx2goaccess.sh '$remote_addr\t$time_local\t$host\t$request\t$http_referer\t$http_x_mobile_group\tLocal:\t$status\t$body_bytes_sent\t$request_time\tProxy:\t$upstream_cache_status\t$upstream_status\t$upstream_response_length\t$upstream_response_time\tAgent:\t$http_user_agent\tFwd:\t$http_x_forwarded_for'
#
# log_format main
# '${time_local}\t${remote_addr}\t${host}\t${request_method}\t${request_uri}\t${server_protocol}\t'
# '${http_referer}\t${http_x_mobile_group}\t'
# 'Local:\t${status}\t*${connection}\t${body_bytes_sent}\t${request_time}\t'
# 'Proxy:\t${upstream_status}\t${upstream_cache_status}\t'
# '${upstream_response_length}\t${upstream_response_time}\t${uri}${log_args}\t'
# 'Agent:\t${http_user_agent}\t'
# 'Fwd:\t${http_x_forwarded_for}';
#   ./nginx2goaccess.sh '${time_local}\t${remote_addr}\t${host}\t${request_method}\t${request_uri}\t${server_protocol}\t${http_referer}\t${http_x_mobile_group}\tLocal:\t${status}\t*${connection}\t${body_bytes_sent}\t${request_time}\tProxy:\t${upstream_status}\t${upstream_cache_status}\t${upstream_response_length}\t${upstream_response_time}\t${uri}${log_args}\tAgent:\t${http_user_agent}\tFwd:\t${http_x_forwarded_for}'
#
# Author: Rogério Carvalho Schneider <stockrt@gmail.com>

# Params
log_format="$1"

# Usage
if [[ -z "$log_format" ]]; then
    echo "Usage: $0 '<log_format>'"
    exit 1
fi

# Variables map
conversion_table="time_local,%d:%t_%^
host,%v
http_host,%v
remote_addr,%h
request_time,%T
request_method,%m
request_uri,%U
server_protocol,%H
request,%r
status,%s
body_bytes_sent,%b
bytes_sent,%b
http_referer,%R
http_user_agent,%u"

# Conversion
for item in $conversion_table; do
    nginx_var=${item%%,*}
    goaccess_var=${item##*,}
    goaccess_var=${goaccess_var//_/ }
    log_format=${log_format//\$\{$nginx_var\}/$goaccess_var}
    log_format=${log_format//\$$nginx_var/$goaccess_var}
done
log_format=$(echo "$log_format" | sed 's/${[a-z_]*}/%^/g')
log_format=$(echo "$log_format" | sed 's/$[a-z_]*/%^/g')

# Config output
echo "
- Generated goaccess config:

time-format %T
date-format %d/%b/%Y
log_format $log_format
"

# EOF


# ./nginx2goaccess.sh '$remote_addr - $remote_user [$time_local] $http_host "$request" ' '$status $body_bytes_sent "$http_referer" ' '"$http_user_agent" "$http_x_forwarded_for"'

# time-format %H:%M:%S
# date-format %d/%b/%Y
# log-format %h %^[%d:%t %^] "%r" %s %b "%R" "%u"
# log-format 与 access.log 的 log_format 格式对应，每个参数以空格或者制表符分割。参数说明如下：
# %t  匹配time-format格式的时间字段
# %d  匹配date-format格式的日期字段
# %h  host(客户端ip地址，包括ipv4和ipv6)
# %r  来自客户端的请求行
# %m  请求的方法
# %U  URL路径
# %H  请求协议
# %s  服务器响应的状态码
# %b  服务器返回的内容大小
# %R  HTTP请求头的referer字段
# %u  用户代理的HTTP请求报头
# %D  请求所花费的时间，单位微秒
# %T  请求所花费的时间，单位秒
# %^  忽略这一字段
