# Dockerfile-BindDNS
Use to build the image to build the Bind Dns Server

## Description
An easy container image for running the Bind DNS server for the short time. Just prepare the configure file and the zone file (you can find the example in the Github repo) and you can run the service.

## Run
### Docker
You can run the image by using `docker` command. To use `-p` option to expose the service.

`docker run -p 53:53/udp chouhongming/bind-dns`

Also, you must use `-v` option to mount the configure file and the zone file if you have your own domain and you need to set the setting that you want.

`docker run -p 53:53/udp -v ./named.conf:/etc/named.conf -v ./domain.zone:/var/named/domain.zone chouhongming/bind-dns`

### Docker Compose
You can use the `docker-compose.yml` file to run the service easily. Due to the different directory structure, you may need to change your working directory to example directory or use `-f` option to start the service.

`docker-compose -f example/docker-compose.yml up -d`

The command for stopping the service, if you use `-f` option to start the service.

`docker-compose -f example/docker-compose.yml down`

And you can use exec action to login to the container to run the command that you want.

`docker-compose -f example/docker-compose.yml exec server bash`

If you want to rebuild the image, you can replace `image: chouhongming/bind-dns` with `build: ..` and run the `docker-compose` with `--build` option, for example:

```
version: "3.7"
services:
server:
    build: ..
    ports:
    - "53:53/udp"
```

`docker-compose -f example/docker-compose.yml up -d --build`

### Kubernetes
You can copy the `k8s-resource.yml` file and replace the word `[YOUR_K8S_NAMESPACE]` with the namespace that you want to apply the service. If you have your own configure file and domain zone, you also can edit or add the setting in the ConfigMap section.

`kubectl apply -f k8s-resource.yml`

## Volume
- /etc/named.conf

    To write the setting that you want, if you are not familer with the Bind DNS setting, you can visit the web [DNS Servers](https://docs.fedoraproject.org/en-US/Fedora/24/html/Networking_Guide/ch-DNS_Servers.html) to learn how to use it.

- /var/named/

    To add your zone setting and keep all the running data like DNS catch, slave information...etc. Noted that you can *NOT* mount the same path to two or more container for this path or the service will runs inexpertly.

- /var/named/abc.com.zone

    To mount your zone setting only. If you don't want to keep other file of the Bind DNS server, You can just mount the zone file that you need.

## Environment
- NAMEDCONF=/etc/named.conf

    Provides a custom configuration file option. To use the -c flag that causes the named daemon to use the custom configuration file to start.

- LOG_LEVEL

    Provides a debugging option. To use the -d flag that causes the named daemon to write debugging information to a file. This variable determines the level of messages printed, with valid levels from 1 to 11, where level 11 supplies the most information.

