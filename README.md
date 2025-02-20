# ubuntu-xfce-vnc-vscode-Dockerfile
Just a Dockerfie with xfce window manager on ubuntu with vscode preinstalled

## instalation

The default user is "rgs" with the password "sjo", the vnc password is also the same, you can change it by modifying the Dockerfile before building it
Download de Dockerfile and run this on the same directory to build it
"""
sudo docker build -t <name> .
"""
to start it just run the following command:
"""
sudo docker run -it --cap-add=SYS_ADMIN -p 5901:5901 -p 22:22 <name>
"""
the container will instantly close if you don't use "-it" flag.
"--cap-add=SYS_ADMIN" makes it have enough permission to use the x11 display of your machine to be able to run vscode properly
