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

Developers often face issues with dependencies when deploying programs across different devices. Docker provides a solution by packaging applications and their dependencies into isolated containers.

### Understanding Containers and Containerization

![Containers_vs_VM](https://github.com/jeftani/inception42/assets/78095454/bfc10c85-9322-40a8-a571-598ecbbb3f0b)

Every program has specific dependencies necessary for proper functioning. For instance, a C++ program might require certain libraries and a compiler. Additionally, there could be dependencies requiring other dependencies, forming a dependency tree. Traditional solutions like virtual machines (VMs) were developed to address this issue.

A hypervisor, software that runs multiple virtual machines on a single physical machine, manages VMs. However, this method often wastes resources due to fixed memory allocations.

Containerization, exemplified by Linux, operates processes in either user space or kernel space. The kernel, a fundamental part of the operating system, manages system resources and facilitates hardware-software communication.

In the user space, programs interact with the kernel through APIs (system calls), forming a bridge between the user space and the kernel. Unlike VMs, which duplicate the kernel and user space for each operating system, containerization utilizes features like cgroups to define resource limits and namespaces to monitor processes.

### Building Containers from Scratch

Tools like LXC and LXD are used to create containers in Linux. To build a container from scratch:

1. Obtain a root filesystem image containing essential Linux system files (/bin, /lib, /sbin, etc.).
2. Mount the root filesystem and the proc filesystem using the `chroot` command, focusing on the new root and allowing process-level isolation.
3. Utilize namespaces to restrict process views and cgroups to limit memory and CPU usage.

In summary, building a container in Linux requires three essential components: namespaces, chroot, and cgroups.


the trouble why I would use container is the OS what if I could just seperate the APP and its dependencies that would be much better 
ok lets find out what is that OS the os is divided in two parts kernel mode and the user mode (a liitle os specification) 
so the the kernel is already exist on the original operating system so why i wouldnt use it , if i did so then i know that i ran the half way 
as we know that the kernel is one in all the linux distribution and all the usermode that are added is what specify what kind of linux distribution 

the concept of the containers is already in the linux but in internal way , thats what we called the name space and the cgroups (that is able to control the resources for several process) 
and the name spaces is to monitore the process bumble it so it can be viewed to each other .
