apt-get install mysql-client

mysql -h 127.0.0.1 -P 6033 -usane -psane

CREATE USER 'sane1001'@'%' IDENTIFIED BY 'sane';

grant all privileges on *.* to 'dev'@'%' with grant option;

mysql -h 127.0.0.1 -P 6032 -uadmin -padmin
