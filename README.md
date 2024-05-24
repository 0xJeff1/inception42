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
 
the process in linux is being ran in one of the two sides of linux either in the user space or the kernel space.
lets define what is a kernel first the kernel is a fundamental part of the operating system , it is a software that manage system resources and facilitates communication between hardware and software .
the user space is any program that you run in ur device and it interact with the kernel using the API (system calls) which makes a bridge between the user space and the kernel  what the point of this is that when you use the VMs every operating system has its own kernel and user space and the most important part is the kernel is repeated all over the os created .

this feature is added to kernel called c_groups is a way to define the limits of the resources , like I want a specific process to use 200MB memory.
and the namespaces is a way to monitor the processes since the process has a view on the other processes the namespace limit the process view on the other ones  all these features + the file systems of any OS and compress it torball (Zip file) 
 we can say that the conatiner is a process that we are a bit controlling by sizing the namespace and the c_groups 

lxc and lxd are a tools to creat containers in the linux .


now that we discovered how the containers works lets try to build our own container from scratch 

1) the first thing we do is grab ourself an image we can use the rootfs (root filesystems) are read only files , and contains the minimal linux system files to boot which are the /bin and /lib and /sbin ... when you run the containers the runtime unpacks the the rootfs and mount it as the container's root directory  "/". using the command chroot you are focusing on the new root and then mount the proc (the proc filesystem is a virtual filesystem that provides information about processes ) filesystem 
2) Why /proc Mounting is Important:

Process Information: Without mounting /proc, processes inside the chroot wouldn't be able to access information about themselves (like process ID, memory usage, etc.). Tools like ps or top wouldn't function correctly.
System Information: In some cases, applications might rely on information from /proc to understand the broader system environment (e.g., CPU type, available memory). Mounting /proc allows some level of access to this information. and then we can do the process level isolation so that the processes aren't shared among the host and the container.
to fullfill that we us the command 
```bash
  unshare -p -f --mount-proc=$PWD/rootfs/proc
```
this is called namespaces
then you can compare the process id that can you fetch and all that  using top and ps and ps aux
and finally we can get into our namspace and restrict the limit of the memory and the cpu usage using the cgroups option.

so to build a container in linux you will need 3 essential thing 
1) Namespaces
2) chroot
3) Cgroups
   
.
.

new chapter in the docker :

   the VMs is building a virtual machine that is simular to a real device which contain Vhardware and an opearting system and the dependencies and finaly the app that we want to install the point is what if we can fetch the dependencies and the app and work with it in an isolated way that would be better .
lets define what is the OS the os contains  actually two parts which are the kernel mode and the user mode  the first thing that happened when you run an os is that it starts recognising the hardware ...

I dont actually need the usermode  I only need the kernel mode 



