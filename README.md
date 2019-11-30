This is a simple script to make switching between CUDA/CUDNN versions easier in Ubuntu. Tested in Ubuntu 19 with Cuda 10.0/10.1/10.2

`bash cuda-version-switcher.sh`

```
devel@devel:~/Code/cuda-version-switcher$ bash cuda-version-switcher.sh 
[INFO] Available Cuda Versions: 
       10.0
       10.2
[INPUT] Please input the major and minor version number (e.g. 10.0) you want symlinked: 10.2
[INFO] Using selected version: 10.2
[INFO] CUDA version switch complete...
[INFO] Current $PATH: /home/devel/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/local/cuda/bin
[INFO] Current $LD_LIBRARY_PATH: :/usr/local/cuda-10.2/lib64
[INFO] Current CUDA symlink: /usr/local/cuda -> /usr/local/cuda-10.2
[INPUT] Do you want to install the corresponding CUDNN version for your version of CUDA? (y/n)y
[INFO] Installing libcudnn7_7.6.5.32-1+cuda10.2_amd64.deb...
(Reading database ... 169349 files and directories currently installed.)
Preparing to unpack libcudnn7_7.6.5.32-1+cuda10.2_amd64.deb ...
Unpacking libcudnn7 (7.6.5.32-1+cuda10.2) over (7.6.5.32-1+cuda10.2) ...
Setting up libcudnn7 (7.6.5.32-1+cuda10.2) ...
Processing triggers for libc-bin (2.29-0ubuntu2) ...
devel@devel:~/Code/cuda-version-switcher$ 
```