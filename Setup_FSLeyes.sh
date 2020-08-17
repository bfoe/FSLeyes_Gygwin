#!/bin/sh

# download remaining scripts from FSLeyes_Gygwin repository
echo "Initializing Setup"
if [ ! -f "Setup_FSLeyes_CompileAll.sh" ]; then
  wget -q https://raw.githubusercontent.com/bfoe/FSLeyes_Gygwin/master/Setup_FSLeyes_CompileAll.sh
  chmod +x Setup_FSLeyes_CompileAll.sh
fi
if [ ! -f "RUN_FSLeyes.sh" ]; then
  wget -q https://raw.githubusercontent.com/bfoe/FSLeyes_Gygwin/master/RUN_FSLeyes.sh
  chmod +x RUN_FSLeyes.sh
fi
if [ ! -f "backup_wheels.sh" ]; then
  wget -q https://raw.githubusercontent.com/bfoe/FSLeyes_Gygwin/master/backup_wheels.sh
  chmod +x backup_wheels.sh
fi
if [ ! -f "setup-x86_64.exe" ]; then
  wget -q https://www.cygwin.com/setup-x86_64.exe # get local copy
  chmod +x ./setup-x86_64.exe
fi

# install Cygwin packages
echo "Install Cygwin packages"
./setup-x86_64.exe -q -P python38-devel -P python38-wheel -P python38-h5py -P python38-wx -P python38-ipython -P python38-cffi \
-P gcc-g++ -P gcc-fortran -P make -P cmake -P wget -P psmisc -P xinit -P liblapack-devel -P libzmq-devel \
-P libfreetype-devel -P libffi-devel -P zlib-devel -P libGLU-devel -P libglut-devel -P libgle-devel >>/dev/null
export PATH=$PATH:/usr/lib/lapack

# start actual FSLeyes install
echo "Install Python packages"
pip3.8 install https://github.com/bfoe/FSLeyes_Gygwin/releases/download/v0.1/scipy-1.5.2-cp38-cp38-cygwin_3_1_6_x86_64.whl
pip3.8 install https://github.com/bfoe/FSLeyes_Gygwin/releases/download/v0.1/kiwisolver-1.2.0-cp38-cp38-cygwin_3_1_6_x86_64.whl
pip3.8 install https://github.com/bfoe/FSLeyes_Gygwin/releases/download/v0.1/matplotlib-3.3.1-cp38-cp38-cygwin_3_1_6_x86_64.whl
pip3.8 install PyOpenGL==3.1.5 https://github.com/bfoe/FSLeyes_Gygwin/releases/download/v0.1/PyOpenGL_accelerate-3.1.5-cp38-cp38-cygwin_3_1_6_x86_64.whl
pip3.8 install https://github.com/bfoe/FSLeyes_Gygwin/releases/download/v0.1/indexed_gzip-1.3.2-cp38-cp38-cygwin_3_1_6_x86_64.whl
pip3.8 install https://github.com/bfoe/FSLeyes_Gygwin/releases/download/v0.1/pyzmq-19.0.2-cp38-cp38-cygwin_3_1_6_x86_64.whl
pip3.8 install fslpy fsleyes

# install additional spatialindex library
if [ ! -f "/usr/local/lib/libspatialindex.dll.a" ]; then
  echo "Install spatialindex library"
  rm spatialindex-src-1.9.3.tar.gz 2>/dev/null
  wget -q https://github.com/bfoe/FSLeyes_Gygwin/releases/download/v0.1/spatialindex-src-1.9.3.tar.gz
  tar zxf spatialindex-src-1.9.3.tar.gz; cd spatialindex-src-1.9.3; 
  make install; cd ..; rm -rf spatialindex-src-1.9.3*
else
  echo "Spatialindex library seems to be installed already"
fi

# install FSLeyes extras
echo "Install fsleyes extras"
pip3.8 install fsleyes[extras]
echo "done"
