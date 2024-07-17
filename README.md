Certainly! Here's a revised version of your text:

---

# Inception42: Docker Installation and Containerization

## Installing Docker

Let's start by installing Docker. First, ensure your package manager is up to date:

```bash
sudo apt update
```

Now, install Docker:

```bash
sudo apt install docker.io
```

Next, enable and start Docker using the systemctl command:

```bash
sudo systemctl enable docker --now
```

Check the status of Docker on your device:

```bash
sudo systemctl status docker
```

It should show as active (running). Now, verify the Docker version:

```bash
docker --version
```

Run a test using Docker:

```bash
docker run -it ubuntu
```

in the begining the developers were strugglingwhen they want to run an application on multi devices each one with its specific dependencies and its specific OS
hello
so in order to solve that problem the VMs comes to the point and suggest using an addition layer called the hypervisor to manage multiple OS in a single device

### Understanding Containers and Containerization

![Containers_vs_VM](https://github.com/jeftani/inception42/assets/78095454/bfc10c85-9322-40a8-a571-598ecbbb3f0b)

here above you can see the Virtual machine how it function 
but also the VMs has its own disadvantages if you can say , one of them is the non-flexibilty of managing the resources that VMs can be a waste resources and memory here the concept of conatiners comes up .  lets now look at the recepe of the application using the VMs the Virtual hardware and the OS and a few dependencies that helps the app and the App itself 
if we can seperate those and fetch the dependencies and the the app then we reached the halfway , lets bring the OS to the table and check its ingridients it contains two parts the kernel mode and the user mode , the usermode  its where the application being run and they have a little access to the resources ex the browsers the text editors ... and the kernel mode this mode has a unlimited access to the resources it manage and have a complete manipulation to the hardware.
ok now we can obviously see that to run an application we wont need the usermode that comes with the OS we can say that its a unnecessary part what we actually need is the kernel part , and the kernel part is already available in the Host OS if we can use it then we reached the halfway , lets keep in mind that the kernel of the linux is one beside its version differences it stay the same what makes it like ubuntu and fedora ... is the little specifications added by usermode so lets make a package that contains those little specifications and the dependencies and the app and make it run on the Host kernel , after packaging the whole layer we called it Image to make the terms clear a running version of the image we call it container. what i forgot to mention is that the concept of containers is not new since it is used internally in the linux in the form of Cgroups and the Namespaces Cgroups which monitor the resources of a specific process and the Namespaces are about monitoring the hierarchy of processes and the accessibility through the processes wa do isolate all the processes using namespaces so anything outside is not visible to them so using the kernel which is available in every OS and using the tech inside of it which are Cgroups and the Namespaces will definitely helps to run the containers 

one more thing is an example of visibility if we run a command in the container and we do the ps -ax it will show that the first process named pid 1 and it is isolated from the host but from the host the process is obviously appeared on the ps -ax we can notice that its not like VMs and that containers share stuff with the host .

#### building a container manually
  

##### what is docker ???
  docker is an open source software that helps create and manage the containers
  until that day there is two types of the containers either the linux or the windows container so the Docker in the windows (docker Desktop) install a Vm of the linux in order to run the containers .
  after installing the docker there is several command to input 
  
Docker run -it <name of the image>  : it means that u run this image in interactive mode -t (terminal).
docker ps -a    : the containers list 
docker ps -aq    : list the ids of the containers 
docker images : list the images 
docker stop <id> : stops the container 
docker rm (for container) and rmi (for images) <id> : removes.
 -q : list the images ides .
 curl <website>: fetch the html.
 docker info : shows the info about the docker .
 docker image pull <name of the image> : pulling the image.
 docker container create <name of the image> : it creates a container from an image .
 docker container start -i <name of the image> : it starts the container .
 docker container run -it <name of the image > : it sum the pull and create and start the container.
 
the job of the container is to run one single process and when you exit() the whole container is being exited that because the container is the app running inside ex : Bash when you exit that app what will the container run ??? then it exit 

#### what is a container ??
  Containers allow devs to package everything required to run an app—the code, runtimes, and system tools—into one convenient location. 
##### the docker architecture 
![1 2O2XM1Q_LhOWCDEhXScf8w](https://github.com/user-attachments/assets/8c7e2afc-b1f8-44fe-813d-0f72af654500)
when we talk about the docker architecture there is three fundamental parts which are docker daemon and the containerD and the runc 
we talk about each one unit starting with the 

lets begin with the " pstree -p " this command that will show us the processes that build the architecture of the docker 

systemd(1)─┬─ModemManager(601)─┬─{ModemManager}(615)
           │                   ├─{ModemManager}(616)
           │                   └─{ModemManager}(618)
           ├─containerd(645)─┬─{containerd}(663)
           │                 ├─{containerd}(664)
           │                 ├─{containerd}(665)
           │                 ├─{containerd}(666)
           │                 ├─{containerd}(668)
           │                 └─{containerd}(670)
           ├─containerd-shim(128222)─┬─bash(128240)
           │                         ├─{containerd-shim}(128223)
           │                         ├─{containerd-shim}(128224)
           │                         ├─{containerd-shim}(128225)
           ├─cron(554)
           ├─dockerd(669)─┬─{dockerd}(671)
           │              ├─{dockerd}(672)
           │              ├─{dockerd}(673)
           │              ├─{dockerd}(680)
           │              ├─{dockerd}(688)
           │              ├─{dockerd}(689)
           │              ├─{dockerd}(710)
           │              ├─{dockerd}(99619)
           │              └─{dockerd}(125896)


--> docker daemon : is the server side of the docker engine and its the part that receive the commands and talks to the kernel
and when you run a command the docker daemon takes it and run the containerD which role is to manage the containers this conatinerD uses these leighweight processes that again run the container with the runc which is running the container with specific specification .

this is the output of the command lets check for the docker daemon and the containerD 
the containerD is a process that manage the lifecycle of the whole container from image to the host to the low level things 
and here is the open source link of it https://github.com/containerd/containerd if u check the repo and goes to the   runtime requirment 
you will find that most interaction with the linux conatiner are handled by the "runc" 
and to figure out how these containers works lets trace a container 
      " sudo strace -f -p 'pidof containerd' -o strace_log "
this command is able to give a log of a container through its id 
the -f stands for follow so the strace follow the child processes 
and the -p is the processes you want to trace .
and it will give you a file contain all the traces 
you gonna look for the runc which will execute the containerd_shim then the magical word "unshare" which is the one that isolate the files of the container .
after that there is the clone() which make a copy of the first process and give it the id 1 then two ...
in another universe you can check the namespaces and the processes related in the file proc
another info is that the docker daemon is listening in HTTP so its not secure so you can work with TLS self signed or other .
###### network in containers 
  what is the main purpose of the containers is to run your application but how we can do that how we can create and move our programs to the container 
  there is the command " cp " like in the linux and its syntax is " docker container cp [source file] [container name / ID ]: /path_where_to_execute. this solving a problem of the transportation but the problem when you edit that file you have to execute it and move it again so its a permenent solution in order to solve that you have to use the network use the -p 80:80 as a port to run it . 
when you create any container it comes with its own network stack  
  and every container comes with three type of networking Bridge and host and the none this last when you attach any container with it it becomes isolated and can not connect to any network and the bridge is the default network of any container 

###### the storage 
  the storage in container is different from the regular since when you end the container all the added stuff will be removed and no longer in the container 
  and you can do it by yourself creat a folder then endl the conytainer it will end immediately after ending it 
  so the solution that pops on the top is to mount that means is to creat an isolated folder and refer to it inside the container using the -v
  "docker container run -it -v /path/to/thefile:new/file"
  then this conatainer will have a live view to the folder .
  DOCKER volume is the second solution which is better and more efficient 
  the docker volumes which are in the same path /var/lib/volumes.
  
  "docker volume create <any name>"
  
