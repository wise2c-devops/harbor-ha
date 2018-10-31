FROM centos:7.5.1804

RUN yum clean all && \
    yum -y install epel-release && \
    yum -y install PyYAML python-jinja2 python-httplib2 python-keyczar python-paramiko python-setuptools git python-pip && \
    yum -y install docker-compose docker && \
    yum -y install ansible

ADD HAharbor-playbook /workspace

WORKDIR /workspace

CMD sh -c 'while true;do sleep 1;done'
