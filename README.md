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
one of the problems that faces developers is that your program wont work in another device because of the dependencies 
so either you can develop a script that can install all these dependencies but you can not predict if the user is using mac or windows or any other os
so one of the solution was the Docker 
Docker is a tool that package the application and the dependencies in an isolate container.
### what is a container or containerization ###

  ![windows_server-virtual_machines_vs_containers_mobile](https://github.com/jeftani/inception42/assets/78095454/bfc10c85-9322-40a8-a571-598ecbbb3f0b)
  
as I said before all the programs have a specific dependencies that may help that program to     work properly 
    for example if ur working with a c++ program u might need a specific libraries and a             compiler to run your code 
    in addition to that there might be a dependencies that needs another one , dependencie tree.
    to fix that problem VMs are developed 

what is a hypervisor ? 
 A hypervisor is a software (is a set of instructions and programs that run ) that run multiple virtual machine on a single physical machine like VMs.
 but using this method is a waste of rsources since u allocate a specific amount of the memory that you might not use.
 so lets take an example of the linux and the containerization 
 
