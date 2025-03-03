## Docker Setup for VNC and VSCode

### Default Credentials

- **User**: `rgs`
- **Password**: `sjo`
- **VNC Password**: `sjo`

You can change these credentials by modifying the `Dockerfile` before building the container.

### Building the Docker Image

Download the `Dockerfile` and run the following command in the same directory:
```
sudo docker build -t my_container -f dfDeveloper.
```
### Running the Container

To start the container, use:
```
sudo docker run -it --cap-add=SYS_ADMIN -p 5901:5901 -p 22:22 my_container
```
### Important Notes

- The container will **instantly close** if you don't use the `-it` flag.
- The `--cap-add=SYS_ADMIN` flag is required to grant enough permissions for the X11 display, allowing VSCode to run properly.

---
