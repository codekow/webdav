# HTTP / WebDAV Server

The primary goal of this project is to provide an option for people to
locally interact with remote data stored in PVCs.

WebDAV is a protocol for transferring files to and from a server.

## Introduction

This repo contains a simple node project that will allow you to build the WebDAV image and deploy a WebDAV pod using one of the provided templates.

## Building and Deploying a WebDAV Server

In order to build and deploy your own WebDAV server you will need to first configure the build process, and you can then utilize the provided templates to deploy a running instance of WebDAV.

Specific instructions for building and deploying this project can be found in the respective directories:

* [node](containers/node) (NodeJS s2i)
* [apache](containers/apache) (Apache base image)

The apache image has the ability to serve out files via regular HTTP requests

## Mounting the Drive in Windows

1) Open the `Windows File Explorer` and select `This PC` from the left panel.
2) Select the `Computer` menu from the ribbon and click on `Map Network Drive`.
3) Paste the Route for the WebDAV server into the `Folder` field and check the box for `Connect using different credentials`.  Click `Finish`.
![map-network-drive](docs/map-network-drive.png)
4) Enter the username and password from the WebDAV environment variables and click `ok`. 

The drive should now be accessible from your Windows machine.

## Addition information for using WebDav

* [Digital Ocean - WebDav Access](https://www.digitalocean.com/community/tutorials/how-to-configure-webdav-access-with-apache-on-ubuntu-20-04#step-4-accessing-webdav)
