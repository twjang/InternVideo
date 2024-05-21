FROM continuumio/miniconda3
WORKDIR /opt/src/
COPY ./environment.yaml /opt/src
RUN conda config --set remote_max_retries 30 && conda env create --name py310 --file=environment.yaml -y
RUN echo "source activate py310" >> ~/.bashrc
ENV PATH /opt/conda/envs/py310/bin:$PATH
ENV TORCH_CUDA_ARCH_LIST 7.5;8.0
RUN git clone https://github.com/Dao-AILab/flash-attention.git && cd flash-attention && git checkout tags/v2.0.8 && cd csrc/fused_dense_lib && pip install .
RUN cd flash-attention/csrc/layer_norm && pip install .
ARG INTERN_COMMIT=1
RUN git clone https://github.com/twjang/InternVideo.git ./intern_video && cd ./intern_video && git checkout fix/demo
WORKDIR /opt/src/intern_video/InternVideo2/multi_modality
RUN pip install -r requirements.txt
