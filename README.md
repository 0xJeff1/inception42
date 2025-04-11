<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  
</head>
<body>
  <h1>🐳 Inception42: Docker Installation and Containerization</h1>

  <h2>📦 Installing Docker</h2>
  <p>First, update your package manager:</p>
  <pre><code>sudo apt update</code></pre>

  <p>Install Docker:</p>
  <pre><code>sudo apt install docker.io</code></pre>

  <p>Enable and start Docker:</p>
  <pre><code>sudo systemctl enable docker --now</code></pre>

  <p>Check Docker status:</p>
  <pre><code>sudo systemctl status docker</code></pre>

  <p>Verify Docker version:</p>
  <pre><code>docker --version</code></pre>

  <p>Run a test container:</p>
  <pre><code>docker run -it ubuntu</code></pre>

  <h2>🧠 Why Docker? A Brief History</h2>
  <p>Originally, developers struggled to run applications across multiple devices due to differing dependencies and operating systems.</p>

  <h3>🔁 Virtual Machines</h3>
  <p>Virtual Machines (VMs) emerged to solve this by using a <strong>hypervisor</strong> to manage multiple OSes on a single machine. However, VMs come with overhead and inflexible resource usage.</p>

  <h2>📦 Containers: A Modern Solution</h2>
  <img src="https://github.com/jeftani/inception42/assets/78095454/bfc10c85-9322-40a8-a571-598ecbbb3f0b" alt="Containers vs VMs">

  <h3>🧬 Under the Hood: Kernel, Cgroups & Namespaces</h3>
  <ul>
    <li><strong>Kernel Mode</strong>: Full access to system resources.</li>
    <li><strong>User Mode</strong>: Limited access; where apps like browsers run.</li>
  </ul>

  <p>Containers use the <strong>host kernel</strong> and isolate environments using:</p>
  <ul>
    <li><strong>Cgroups</strong>: Limit and monitor resource usage per process.</li>
    <li><strong>Namespaces</strong>: Isolate process trees and visibility.</li>
  </ul>

  <p>Example:</p>
  <ul>
    <li>Inside a container, <code>ps -ax</code> shows only container processes.</li>
    <li>On the host, the same processes are visible, showcasing the shared kernel.</li>
  </ul>

  <h2>🔧 Building a Container Manually</h2>

  <h3>What is Docker?</h3>
  <p><em>Docker is an open-source platform that simplifies creating, deploying, and running containers.</em></p>
  <p>In Windows, Docker Desktop runs a Linux VM to support Linux containers.</p>

  <h2>🛠️ Essential Docker Commands</h2>
  <pre><code>
docker run -it <image>        # Run container interactively
docker ps -a                  # List all containers
docker ps -aq                 # List container IDs
docker images                 # List Docker images
docker stop <container_id>   # Stop a running container
docker rm <container_id>     # Remove a container
docker rmi <image_id>        # Remove an image
docker pull <image>          # Pull image from registry
docker info                  # Display Docker system info
docker container create <image>
docker container start -i <container_id>
docker container run -it <image>  # Equivalent to pull + create + start
curl <website>               # Fetch webpage (HTML)
</code></pre>

  <p><em>Note:</em> Containers run a single process. If that process (e.g., <code>bash</code>) exits, the container stops.</p>

  <h2>🧱 What Is a Container?</h2>
  <p><em>Containers package all components (code, runtime, libraries) needed to run an app reliably across environments.</em></p>

  <h2>🧬 Docker Architecture</h2>
  <img src="https://github.com/user-attachments/assets/8c7e2afc-b1f8-44fe-813d-0f72af654500" alt="Docker Architecture">

  <h3>Core Components:</h3>
  <ul>
    <li><strong>Docker Daemon (<code>dockerd</code>)</strong>: Handles requests and communicates with OS.</li>
    <li><strong>ContainerD</strong>: Manages container lifecycle.</li>
    <li><strong>RunC</strong>: Low-level runtime that starts containers.</li>
  </ul>

  <p>Inspect architecture with:</p>
  <pre><code>pstree -p</code></pre>

  <p>Use <code>strace</code> to trace Docker internals:</p>
  <pre><code>
sudo strace -f -p $(pidof containerd) -o strace_log
</code></pre>

  <p>Look for:</p>
  <ul>
    <li><strong>unshare</strong>: Isolates file system.</li>
    <li><strong>clone()</strong>: Spawns new container process (PID 1).</li>
  </ul>

  <p><em>📎</em> Also, Docker uses <strong>HTTP</strong> for communication—consider securing it with <strong>TLS</strong>.</p>

  <h2>🌐 Networking in Containers</h2>
  <p>Copy files into container:</p>
  <pre><code>docker container cp <local_path> <container_id>:/path</code></pre>

  <p>Expose container port:</p>
  <pre><code>docker run -p 80:80 <image></code></pre>

  <h3>Types of Docker Networks:</h3>
  <ul>
    <li><strong>bridge</strong> (default)</li>
    <li><strong>host</strong> (shares host’s network stack)</li>
    <li><strong>none</strong> (completely isolated)</li>
  </ul>

  <h2>💾 Storage in Containers</h2>
  <p>By default, changes in a container are lost when it stops.</p>

  <h3>🧩 Solutions:</h3>
  <ol>
    <li><strong>Mounting a host directory</strong>:</li>
    <pre><code>docker run -it -v /host/path:/container/path <image></code></pre>
    <li><strong>Docker Volumes</strong> (persistent and preferred):</li>
    <pre><code>docker volume create myvolume
docker run -it -v myvolume:/data <image></code></pre>
  </ol>
  <p>Volumes are stored in <code>/var/lib/docker/volumes</code>.</p>

  <h2>📄 Dockerfile</h2>
  <p>Use a <code>Dockerfile</code> to automate container builds.</p>
  <pre><code>
# Example
FROM ubuntu
RUN apt update && apt install -y curl
CMD ["bash"]
</code></pre>
  <p>Build with:</p>
  <pre><code>docker build -t myimage .</code></pre>

  <h2>🧠 Network Deep Dive</h2>
  <p>Each container has its own network namespace. Use:</p>
  <pre><code>ip link show
ip addr show
ifconfig</code></pre>

  <p>You can assign a container to a specific network using:</p>
  <pre><code>docker run --network <network_name> ...</code></pre>

  <h2>🧪 Useful MySQL Commands (In-Container)</h2>
  <pre><code>
USE database_name;
SELECT CURRENT_USER();
SELECT User, Host FROM mysql.user;
SHOW GRANTS FOR 'username'@'hostname';
SELECT * FROM wp_comments;
</code></pre>

  <h2>🧹 Clean Up Docker</h2>
  <pre><code>docker system prune -a</code></pre>

  <h2>🛠️ Install Useful Tools in Containers</h2>
  <pre><code>apt-get update && apt-get install procps</code></pre>
</body>
</html>
