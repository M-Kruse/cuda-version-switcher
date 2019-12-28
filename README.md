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
[INFO] Found cuda in PATH, removing...
[INFO] Modifying LD_LIBRARY_PATH
[INFO] Please make sure to run `source ~/.profile` to add the new env variables
[INFO] CUDA version switch complete...
[INFO] Current $PATH: /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/usr/local/cuda/bin
[INFO] Current $LD_LIBRARY_PATH: :/usr/local/cuda-10.0/lib64
[INFO] Current CUDA symlink: /usr/local/cuda -> /usr/local/cuda-10.0
[INPUT] Do you want to install CUDNN for your version of CUDA? (y/n)
[INFO] Found the following LibCUDNN versions from NVIDIA for CUDA 10.0 :
        7.3.0.29
        7.3.1.20
        7.4.1.5
        7.4.2.24
        7.5.0.56
        7.5.1.10
        7.6.0.64
        7.6.1.34
        7.6.2.24
        7.6.3.30
        7.6.4.38
        7.6.5.32
[INPUT] Do you want to use a version older than the latest version listed? (y/n)y
[INPUT] Please select a libCUDNN version from above: 7.5.1.10
[INFO] Installing libcudnn7_7.5.1.10-1+cuda10.0_amd64.deb...
dpkg: warning: downgrading libcudnn7 from 7.6.5.32-1+cuda10.2 to 7.5.1.10-1+cuda10.0
(Reading database ... 183764 files and directories currently installed.)
Preparing to unpack libcudnn7_7.5.1.10-1+cuda10.0_amd64.deb ...
Unpacking libcudnn7 (7.5.1.10-1+cuda10.0) over (7.6.5.32-1+cuda10.2) ...
Setting up libcudnn7 (7.5.1.10-1+cuda10.0) ...
Processing triggers for libc-bin (2.29-0ubuntu2) ...
[INFO] Installing libcudnn7-dev_7.5.1.10-1+cuda10.0_amd64.deb...
dpkg: warning: downgrading libcudnn7-dev from 7.6.5.32-1+cuda10.2 to 7.5.1.10-1+cuda10.0
(Reading database ... 183764 files and directories currently installed.)
Preparing to unpack libcudnn7-dev_7.5.1.10-1+cuda10.0_amd64.deb ...
update-alternatives: removing manually selected alternative - switching libcudnn to auto mode
Unpacking libcudnn7-dev (7.5.1.10-1+cuda10.0) over (7.6.5.32-1+cuda10.2) ...
Setting up libcudnn7-dev (7.5.1.10-1+cuda10.0) ...
update-alternatives: using /usr/include/x86_64-linux-gnu/cudnn_v7.h to provide /usr/include/cudnn.h (libcudnn) in auto mode
devel@devel:~/Code/cuda-version-switcher$ 
```