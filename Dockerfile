FROM debian
RUN apt-get update -y
RUN apt-get install -y openssh-server vim net-tools
RUN apt-get install -y ansible
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN mkdir /root/.ssh
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EXPOSE 22
CMD    ["/usr/sbin/sshd", "-D"]


# sudo docker run -d -P --name test_ssh docker_name
# sudo docker port test_ssh 22
# ssh root@localhost -p 49154
# The password is `root`
# root@test_ssh $
# docker exec test_ssh passwd -d root
# docker cp file_on_host_with_allowed_public_keys test_ssh:/root/.ssh/authorized_keys
# docker exec test_ssh chown root:root /root/.ssh/authorized_keys