This is a simple script to make switching between CUDA/CUDNN versions easier in Ubuntu. Tested in Ubuntu 19 with Cuda 10.0/10.1/10.2

`bash cuda-version-switcher.sh`

```
devel@devel:~/Code/cuda-version-switcher$ bash cuda-version-switcher.sh 
[INFO] Found existing CUDA symlink: /usr/local/cuda-10.2
[INFO] Available Cuda Versions: 
       10.0
       10.2
[INPUT] Please input the major and minor version number (e.g. 10.0) you want symlinked: 10.0
[INFO] Using selected version: 10.0
[sudo] password for devel: 
[INFO] Found cuda in PATH, removing...
[INFO] Modifying LD_LIBRARY_PATH
[INFO] CUDA version switch complete...
[INFO] Current $PATH: /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/usr/local/cuda/bin
[INFO] Current $LD_LIBRARY_PATH: :/usr/local/cuda-10.0/lib64
[INFO] Current CUDA symlink: /usr/local/cuda -> /usr/local/cuda-10.0
[INPUT] Do you want to install the corresponding CUDNN version for your version of CUDA? (y/n)y
[INFO] Downloading libcudnn7_7.6.5.32-1+cuda10.0_amd64.deb
[INFO] Downloading libcudnn7-dev_7.6.5.32-1+cuda10.0_amd64.deb

```