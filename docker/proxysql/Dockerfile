FROM ubuntu:14.04

RUN cp /etc/apt/sources.list /etc/apt/sources.list.backup \
	&& sed -i "s/archive.ubuntu.com/mirrors.aliyun.com/g" /etc/apt/sources.list \
  	&& ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN apt-get update && apt-get install -y \
	automake \
	cmake \
	make \
	g++ \
	gcc \
	gdb \
	gdbserver \
	git \
	libmysqlclient-dev \
	libssl-dev \
	libtool \
	mysql-client \
	tzdata \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/

RUN cd /opt; git clone https://github.com/akopytov/sysbench.git
RUN cd /opt/sysbench; ./autogen.sh; ./configure --bindir=/usr/bin; make; make install

ADD ./conf/proxysql.cnf /etc/
RUN mkdir -p /var/lib/proxysql
ADD ./compile_and_start_proxysql.sh /tmp/
RUN chmod +x /tmp/compile_and_start_proxysql.sh

CMD ["/tmp/compile_and_start_proxysql.sh"]
