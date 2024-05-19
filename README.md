# inception42
## installing the docker 
first we update the apt 
```bash
 sudo apt update
```
then we install the docker 
```bash
 sudo apt install docker.io
```
then we enable the docker using this command 

```bash
 sudo systemctl enable docker --now
```
check the status of the docker in your device using 

```bash
 sudo  systemctl ststus docker 
```
it must show active (running) 

now check the version of ur docker

```bash
  docker --version
```
then run a test using the docker 

```bash
  docker run -it ubuntu 
```
