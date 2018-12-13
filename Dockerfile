FROM ubuntu:18.04
MAINTAINER Reto Achermann <reto.achermann@inf.ethz.ch>

COPY config.pp /config.pp
COPY aptsources.list /sources.list

# install dependencies for puppet
RUN apt-get update && apt-get upgrade -y &&  \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
            wget apt-utils 

# install puppet
RUN wget -q https://apt.puppetlabs.com/puppet6-release-bionic.deb \ 
           -O puppetlabs-release-repo.deb
RUN dpkg -i puppetlabs-release-repo.deb
RUN rm -rf puppetlabs-release-repo.deb
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y puppet-agent


# run module install on the puppet script
RUN /opt/puppetlabs/bin/puppet module install \
          --target-dir=/opt/puppetlabs/puppet/modules \
          --modulepath /etc/puppetlabs/code/modules puppetlabs-vcsrepo


# apply the puppet script etc. 
RUN /opt/puppetlabs/bin/puppet apply --onetime --verbose \
      --no-daemonize --no-usecacheonfailure --no-splay \
      --show_diff /config.pp
