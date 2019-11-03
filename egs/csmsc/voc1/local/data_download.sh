#!/bin/bash -e

# Copyright 2019 Nagoya University (Tomoki Hayashi)
#  Apache 2.0  (http://www.apache.org/licenses/LICENSE-2.0)

download_dir=$1

# check arguments
if [ $# != 1 ]; then
    echo "Usage: $0 <download_dir>"
    exit 1
fi

# download dataset
cwd=$(pwd)
if [ ! -e "${download_dir}/CSMSC" ]; then
    mkdir -p "${download_dir}"
    cd "${download_dir}"
    wget https://weixinxcxdb.oss-cn-beijing.aliyuncs.com/gwYinPinKu/BZNSYP.rar
    mkdir CSMSC && cd CSMSC && unrar x ../BZNSYP.rar
    # convert new line code
    find CSMSC/PhoneLabeling -name "*.interval" | while read -r line; do
        nkf -Lu --overwrite "${line}"
    done
    rm ../BZNSYP.rar
    cd "${cwd}"
    echo "Successfully finished download."
else
    echo "Already exists. Skip download."
fi
