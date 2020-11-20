FROM centos:7.7.1908


RUN yum -y install bind-32:9.11.4-26.P2.el7_9.2.x86_64 && \
    yum -y install bind-chroot-32:9.11.4-26.P2.el7_9.2.x86_64 && \
    yum -y install bind-utils-32:9.11.4-26.P2.el7_9.2.x86_64 && \
    yum -y install bind-libs-32:9.11.4-26.P2.el7_9.2.x86_64


RUN cp -r /var/named /var/named-default


ADD asset/entrypoint.sh .
ENTRYPOINT ["sh", "entrypoint.sh"]


