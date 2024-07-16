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
ok now we can obviously see that to run an application we wont need the usermode that comes with the OS we can say that its a unnecessary part what we actually need is the kernel part , and the kernel part is already available in the Host OS if we can use it then we reached the halfway , lets keep in mind that the kernel of the linux is one beside its version differences it stay the same what makes it like ubuntu and fedora ... is the little specifications added by usermode so lets make a package that contains those little specifications and the dependencies and the app and make it run on the Host kernel 

#### what is a container ??
  Containers allow devs to package everything required to run an app—the code, runtimes, and system tools—into one convenient location. 
  
