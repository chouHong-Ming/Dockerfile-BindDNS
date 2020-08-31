FROM centos:7.7.1908


RUN yum -y install bind bind-libs bind-chroot bind-utils


RUN cp -r /var/named /var/named-default


ADD asset/entrypoint.sh .
ENTRYPOINT ["sh", "entrypoint.sh"]


