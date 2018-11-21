FROM centos:7.5.1804

RUN     yum -y install epel-release && \
        yum -y install python-pip make openssh-clients git sshpass

RUN     pip install ansible==2.7.2 ansible-lint
RUN     mkdir /etc/ansible

COPY    ansible.cfg /etc/ansible/ansible.cfg
COPY    plugins/ /usr/lib/python2.7/site-packages/ansible/plugins/
COPY    modules/ /usr/lib/python2.7/site-packages/ansible/modules/

VOLUME [ "/sys/fs/cgroup" ]
CMD    ["/bin/bash"]
