# fedora-packager
Dockerfile to create a fedora packager setup inside a Container

NOT READY FOR PRODUCTION - THIS IS A TESTING IMAGE

# Usage.

## Getting Started.

Download the last image available in the docker hub with:

```bash
  docker pull williamjmorenor/fedora-packager
```

Create a directory to store your packager files outside the container:

```bash
  mkdir $HOME/rpm-packaging
```

Create a container with the name "rpm-packaging" mount "$HOME/rpm-packaging" as a volume to the container and start a interactive shell:

```bash
  docker run --name rpm-packaging -v $HOME/rpm-packaging:/home/packager:rw -ti williamjmorenor/fedora-packager
  bash-4.4$ pwd
  /home/packager
  bash-4.4$ whoami
  packager
  bash-4.4$ dnf --version
  3.5.1
    Installed: dnf-0:3.5.1-1.fc30.noarch at Mon Sep 17 01:11:23 2018
    Built    : Fedora Project at Tue Sep 11 09:19:59 2018

    Installed: rpm-0:4.14.2-1.fc30.x86_64 at Thu Sep  6 10:29:33 2018
    Built    : Fedora Project at Tue Aug 21 11:33:49 2018
  bash-4.4$ rpm --version
  RPM version 4.14.2
  bash-4.4$ rpmbuild --version
  RPM version 4.14.2
  bash-4.4$ exit
  exit
```

## Reuse the docker container.

To resue the same docker container run:

```bash
  docker start rpm-packaging -i
```

## Update to the last image.

Remove old image and container:

```bash
  docker rm rpm-packaging
  docker image rm williamjmorenor/fedora-packager
```

Pull last image and recreate container:

```bash
  docker pull williamjmorenor/fedora-packager
  docker run --name rpm-packaging -v $HOME/rpm-packaging:/home/packager:rw -ti williamjmorenor/fedora-packager
```

# Using mock to build rpm packages.
TODO