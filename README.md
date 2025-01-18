# rn6src

This repository contains the source code of updates packages for ReadyNAS 
systems running ReadyNAS OS 6.10.x.

## Directory structure

The repos is organized into different directories. Each directory represents
a package and holds the files needed to build that package.
To save on disk space only the `debian` directory with the build information
as well as the original source archive are stored in the repository.
Additionally a README.md file in the directory of a package _may_ give hints
on special prerequisites needed to build the package.

## Installing packages

In case you just want to install some of the packages provided by the code
here, it is easier to just add the package repository to your ReadyNAS. To
do so
- log in to your ReadyNAS using ssh
- on the cli run
  ``` bash
  wget https://repos.rnxtras.com/debian/add_rnx_repo.sh
  chmod +x add_rnx_repo.sh
  ./add_rnx_repo.sh
  ```
- now you should be able to install packages using
  ``` bash
  apt install name_of_package
  ```

## Building packages

To build a package 

* change to the package's directory
  * if there's a `.dsc` file, run `dpkg-source -x <filename>.dsc`
  * else
    * unpack the original source archive to someplace **outside** the repository
    * **copy** the `debian` directory into the folder with the unpacked source
* change to the directory with the unpacked source
* [optional] make your changes to the files in the `debian` directory
* run `debuild -sa`
