FROM ubuntu

# 国内使用本机仓库地址覆盖ubuntu默认仓库地址
# COPY sources.list /etc/apt/

# apt安装包之前先进行update,防止源缓存不一致报错
# 安装build-essential构建环境包和wget包
# 安装完成后清除缓存
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    build-essential \
    wget \
  && rm -rf /var/lib/apt/lists/*

# 获取最新anaconda安装脚本
# 执行脚本安装anaconda 安装路径为-p参数
# 删除anaconda安装脚本
RUN wget   --no-check-certificate  https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-`uname -p`.sh -O ~/anaconda3.sh \
    && bash ~/anaconda3.sh -b -p /home/anaconda3 \
    && rm ~/anaconda3.sh

# 设置环境变量
ENV PATH=/home/anaconda3/bin:$PATH

# 使用conda安装keras环境及必须支撑包
RUN conda install -y \
    h5py \
    pandas \
    keras \
    tensorflow

# 安装jieba中文分词工具包，conda仓库没有jieba包，使用pip安装，安装完成后conda --list可以看到
RUN pip install jieba

# 安装gensim 词向量工具包
RUN conda install -y gensim

# 安装keras-bert 使用bert
RUN pip install keras-bert
