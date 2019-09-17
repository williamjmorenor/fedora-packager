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
     rpmdevtools \ 
     deltarpm \
     python3-pyrpm \
     createrepo_c \
     && dnf clean all

# Create a user to not run packaging tasks as root
RUN useradd -ms /bin/bash packager
# Packager user must be in the mock package
RUN usermod -a -G mock packager
# Let the packager user become root.
RUN usermod -a -G wheel packager
# Use sudo without password.
RUN echo "packager ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
# Define user and home for packaging.
USER packager
WORKDIR /home/packager
VOLUME /home/packager
ENTRYPOINT [ "/usr/bin/bash" ]
