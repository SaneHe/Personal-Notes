ARG JENKINS_VERSION
FROM ${JENKINS_VERSION}

USER root

# 更改时区
RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/* && \
    apk --no-cache add tzdata \
    && cp -rf "/usr/share/zoneinfo/Asia/Shanghai" /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone
