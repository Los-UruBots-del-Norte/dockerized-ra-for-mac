# Dockerized Ubuntu RA for Mac OS X

This repository contains a dockerized version of the RA Framework.

https://github.com/Los-UruBots-del-Norte/framework
https://github.com/robotics-erlangen/framework

All credits go to the respective software owners.
This repository only encapsulates the framework in a Docker container.

## Notice for Silicon based Macs

As the software is not supported to run on Silicon Macs, the use of Rosetta 2 is required to run this container.
This comes with a significant performance cost during the installation.

## Running the project

### Preparing the environment

As the Framework is a GUI based application, a helper tool has to be used to access the window.
This repository uses X11 and Xquartz to make that possible.
To install it on Mac OS X follow these steps or another guide (https://gist.github.com/sorny/969fe55d85c9b0035b0109a31cbcb088):

1. Install xquartz via brew and launch it

```bash
brew install --cask xquartz
open -a XQuartz
```

2. Go to the security settings of the program and enable "Allow connections from network clients"
3. Restart your device for the changes to take effect
4. Check whether XQuartz is up and running

```bash
ps aux | grep Xquartz
/opt/X11/bin/Xquartz :0 -listen tcp
```

5. Enable host forwarding for X11

```bash
# Only allow local containers
xhost +localhost

# Allow all external connections (not recommended)
xhost +
```

### Starting the Docker container

This step requires that Docker is installed on your system and that the Daemon is running

```bash
docker build -t dockerized-ra-on-mac:latest .
docker run -it dockerized-ra-on-mac:latest bash
```

After the container has been launched, start the installation process:

```bash
. /etc/profile
cd home
./installer.sh
```

When the original installation script completes, the following error should be visible:

```
qt.qpa.xcb: could not connect to display 
qt.qpa.plugin: Could not load the Qt platform plugin "xcb" in "" even though it was found.
This application failed to start because no Qt platform plugin could be initialized. Reinstalling the application may fix this problem.

Available platform plugins are: eglfs, linuxfb, minimal, minimalegl, offscreen, vnc, xcb.

qemu: uncaught target signal 6 (Aborted) - core dumped
Aborted
``````

This error occurrs as the Docker container has no accessible display.
This is why X11 is used in this project.
To launch the application, just run the install.sh in /home.