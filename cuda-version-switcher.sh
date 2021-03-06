#!/bin/bash
#Description: Bash script to switch between installed CUDA/CUDNN versions (10.x) for Ubuntu 18.04/19.04
#Author: Matt Kruse

CUDA_VERSIONS=$(ls -d1 /usr/local/cuda-*)
CUDA_SYMLINK="/usr/local/cuda"

if [[ -e $CUDA_SYMLINK ]]
	then
			SYMLINK_VERSION=$(readlink $CUDA_SYMLINK)
			EXISTING_SYMLINK=true
	else
			EXISTING_SYMLINK=false
fi

if $EXISTING_SYMLINK
	then
		echo "[INFO] Found existing CUDA symlink: $SYMLINK_VERSION"
fi

echo "[INFO] Available Cuda Versions: "
for VERSION in $CUDA_VERSIONS
	do
		echo "       $VERSION" | sed 's/\/usr\/local\/cuda-//'
	done
echo -n "[INPUT] Please input the major and minor version number (e.g. 10.0) you want symlinked: "
read CUDA_VERSION
if [[ -e "${CUDA_SYMLINK}-${CUDA_VERSION}" ]]
	then
		echo "[INFO] Using selected version: $CUDA_VERSION"
	else
		echo "[ERROR] Could not find the selected version \"$CUDA_VERSION\" in versions: \n $CUDA_VERSIONS"
		echo "[ERROR] Exiting..."
fi

#IF existing CUDA, test if old cuda is in the PATH (shell/LD_CONFIG)
if $EXISTING_SYMLINK
	then
		sudo rm $CUDA_SYMLINK
		if [[ $PATH =~ "/usr/local/cuda/bin" ]]
			then
				echo "[INFO] Found cuda in PATH, removing..."
				sed -i 's/:\/usr\/local\/cuda\/bin//' ~/.profile
		fi
		
		if [[ $(grep -q "LD_LIBRARY_PATH=" ~/.profile) < 0 ]]
			then
				echo "[INFO] Modifying LD_LIBRARY_PATH"
				LD_LIBRARY_PATH=$(echo $LD_LIBRARY_PATH | sed 's/\:\/usr\/local\/cuda*\/lib64//')
				sed -i '/^LD_LIBRARY_PATH/d' ~/.profile
		fi

fi
OLD_PATH=$(echo $PATH | sed 's/:\/usr\/local\/cuda\/bin//')
sed -i '/^PATH=/d' ~/.profile
echo "PATH=${OLD_PATH}:/usr/local/cuda/bin" >> ~/.profile
echo "LD_LIBRARY_PATH=${NEW_LD_LIBRARY_PATH}:/usr/local/cuda-${CUDA_VERSION}/lib64" >> ~/.profile

sudo ln -s ${CUDA_SYMLINK}-${CUDA_VERSION} /usr/local/cuda
# export PATH=$PATH:/usr/local/cuda/bin
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${CUDA_SYMLINK}/lib64
echo "[INFO] Please make sure to run \`source ~/.profile\` to add the new env variables"
echo "[INFO] CUDA version switch complete..."
echo "[INFO] Current \$PATH: $PATH"
echo "[INFO] Current \$LD_LIBRARY_PATH: $LD_LIBRARY_PATH"
echo "[INFO] Current CUDA symlink: $CUDA_SYMLINK -> $(readlink $CUDA_SYMLINK)"

while [[ "$INSTALL_CUDNN" != "y" ]] || [[ "$INSTALL_CUDNN" != "y" ]]
	do
		read -s -p "[INPUT] Do you want to install CUDNN for your version of CUDA? (y/n)"  INSTALL_CUDNN
	done

if [[ $INSTALL_CUDNN == "y" ]]
	then
		LIBCUDNN_VERSIONS=$(curl -s "https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/"| grep libcudnn |  grep -o '<a .*href=.*>' | sed -e 's/<a /\n<a /g' | sed -e 's/<a .*href=['"'"'"]//' -e 's/["'"'"'].*$//' -e '/^$/ d' | grep cuda${CUDA_VERSION} | grep dev | awk -F'-' {'print $2'}| sed 's/dev_//')
		echo -e "\n[INFO] Found the following LibCUDNN versions from NVIDIA for CUDA $CUDA_VERSION :"
		for n in $LIBCUDNN_VERSIONS
			do 
				echo "        $n"
			done #echo $LIBCUDNN_VERSIONS | tr ' ' '\n'
		echo -n "[INPUT] Do you want to use a version older than the latest version listed? (y/n)"
		read INSTALL_OLD_CUDNN
		if [[ $INSTALL_OLD_CUDNN == "y" ]]
			then
					echo -n "[INPUT] Please select a libCUDNN version from above: "
					read OLD_CUDNN_VERSION
					if [[ "$LIBCUDNN_VERSIONS" =~ "$OLD_CUDNN_VERSION" ]]
						then
							CUDNN_URL="https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/libcudnn7_${OLD_CUDNN_VERSION}-1+cuda${CUDA_VERSION}_amd64.deb"
							CUDNN_DEV_URL="https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/libcudnn7-dev_${OLD_CUDNN_VERSION}-1+cuda${CUDA_VERSION}_amd64.deb"
					else
						read -p "[ERROR] Could not detect the version selected. Falling back to the newest version. Press any key to continue."
						#Fall back to no to make sure the latest version is used
						INSTALL_OLD_CUDNN="n"
					fi
		fi
		if [[ $INSTALL_OLD_CUDNN == "n" ]]
			then
				case $CUDA_VERSION in
					10.0) CUDNN_URL="https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/libcudnn7_7.6.5.32-1+cuda10.0_amd64.deb"
					CUDNN_DEV_URL="https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/libcudnn7-dev_7.6.5.32-1+cuda10.0_amd64.deb"
					;;
					10.1) CUDNN_URL="https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/libcudnn7_7.6.5.32-1+cuda10.1_amd64.deb"
					CUDNN_DEV_URL="https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/libcudnn7-dev_7.6.5.32-1+cuda10.1_amd64.deb"
					;;
					10.2) CUDNN_URL="https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/libcudnn7_7.6.5.32-1+cuda10.2_amd64.deb"
					CUDNN_DEV_URL="https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/libcudnn7-dev_7.6.5.32-1+cuda10.2_amd64.deb"
					;;
					*) echo "[ERROR] Something went wrong with the CUDNN version selection. Please use 10.0, 10.1 or 10.2."
					;;
				esac
		fi
		CUDNN_PKG=$( echo $CUDNN_URL | awk -F'/' {'print $NF'} )
		CUDNN_DEV_PKG=$( echo $CUDNN_DEV_URL | awk -F'/' {'print $NF'} )
		if [[ ! -f $CUDNN_PKG ]]
			then
				echo "[INFO] Downloading ${CUDNN_PKG}"
				wget $CUDNN_URL > /dev/null 2>&1
				if [[ $? > 0 ]]
					then
						echo "[ERROR] Failed to download ${CUDNN_DEV_URL}. Exiting..."
						exit 1
				fi
		fi
		if [[ ! -f $CUDNN_DEV_PKG ]]
			then
				echo "[INFO] Downloading ${CUDNN_DEV_PKG}"
				wget $CUDNN_DEV_URL > /dev/null 2>&1
				if [[ $? > 0 ]]
					then
						echo "[ERROR] Failed to download ${CUDNN_URL}. Exiting..."
						exit 1
				fi
		fi
		echo "[INFO] Installing ${CUDNN_PKG}..."
		sudo dpkg -i $CUDNN_PKG
		
		if [[ $? > 0 ]]
			then
				echo "[ERROR] Failed to install ${CUDNN_URL}. Exiting..."
				exit 1
		fi
		echo "[INFO] Installing ${CUDNN_DEV_PKG}..."
		sudo dpkg -i $CUDNN_DEV_PKG
		if [[ $? > 0 ]]
			then
				echo "[ERROR] Failed to install ${CUDNN_DEV_URL}. Exiting..."
				exit 1
		fi
	else
		echo "[INFO] Skipping libCUDNN installation..."
fi




