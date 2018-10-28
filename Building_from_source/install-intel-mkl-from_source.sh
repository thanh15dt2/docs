#! /bin/bash

echo ""
echo "************************************************ Please confirm *******************************************************"
echo " Installing Intel(R) Math Kernel Library for Deep Neural Networks (Intel(R) MKL-DNN) from source may take a long time. "
echo " Select n to skip Intel MKL-DNN installation or y to install it." 
read -p " Continue installing Intel MKL-DNN (y/n) ? " CONTINUE
if [[ "$CONTINUE" == "y" || "$CONTINUE" == "Y" ]]; then
	echo "";
	echo "Installing Intel MKL-DNN"; 
	echo "";
	sudo apt update -y && sudo apt-get upgrade -y
	sudo apt install -y build-essential cmake pkg-config
	sudo apt install -y libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev
	sudo apt install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
	sudo apt install -y libxvidcore-dev libx264-dev
	sudo apt install -y libgtk2.0-dev libgtk-3-dev
	sudo apt install -y libatlas-base-dev gfortran
	sudo apt install -y python2.7-dev python3-dev
	
	export INTEL_MKL_VERSION=0.16
	export INTEL_MKL_DOWNLOAD_URL=https://github.com/intel/mkl-dnn/archive/v$INTEL_MKL_VERSION.zip
  
	export CURRENT_DIR=`pwd`
	wget "$INTEL_MKL_DOWNLOAD_URL" -O mkl-dnn.zip
	unzip mkl-dnn.zip
	cd mkl-dnn-$INTEL_MKL_VERSION/
	mkdir build
	cd build
	cmake -D CMAKE_BUILD_TYPE=RELEASE \
	      -D CMAKE_INSTALL_PREFIX=/usr/local \
	      -D INSTALL_PYTHON_EXAMPLES=OFF \
	      -D WITH_V4L=ON \
	      -D OPENCV_EXTRA_MODULES_PATH=$CURRENT_DIR/opencv_contrib-$OPENCV_VERSION/modules \
	      -D BUILD_DOCS=OFF \
	      -D BUILD_PERF_TESTS=OFF \
	      -D BUILD_TESTS=OFF \
	      -D BUILD_EXAMPLES=OFF ..
	make -j $(nproc)
	sudo make install
	sudo ldconfig
else
	echo "";
	echo "Skipping OpenCV installation";
	echo "";
fi
