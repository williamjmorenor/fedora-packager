# Dockerfile to create a fedora packager setup inside a docker container
FROM fedora:rawhide
LABEL maintainer="williamjmorenor@fedoraproject.org"

RUN dnf install -y --refresh \
     bash \
     fedora-packager \
     fedora-review \
     mock \
     sudo \
     rpmlint \
     wget \
     && dnf groupinstall -y "Development Tools" \
     && dnf clean all


# Create a user to not run packaging taks as root
RUN useradd -ms /bin/bash packager
# Packager user must be in mock package
RUN usermod -a -G mock packager
# Let become the packager user root, you need to install build dependencies.
RUN usermod -a -G wheel packager
# Use sudo without password.
RUN echo "packager ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
# Define user and home for packaging.
USER packager
WORKDIR /home/packager
VOLUME /home/packager
ENTRYPOINT [ "/usr/bin/bash" ]
