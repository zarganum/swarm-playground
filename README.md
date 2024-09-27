### OCI cloud-init


- 2377 TCP: communication with and between manager nodes
- 7946 TCP/UDP: overlay network node discovery
- 4789 UDP: aka VXLAN (configurable) overlay network traffic

```sh
dnf install -y git
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
usermod -aG docker opc
systemctl enable docker.service
systemctl start docker.service
firewall-cmd --add-port 2377/tcp --permanent
firewall-cmd --add-port 7946/tcp --permanent
firewall-cmd --add-port 7946/udp --permanent
firewall-cmd --add-port 4789/udp --permanent
```
