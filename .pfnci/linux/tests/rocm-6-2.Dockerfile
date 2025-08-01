# AUTO GENERATED: DO NOT EDIT!
ARG BASE_IMAGE="rocm/dev-ubuntu-22.04:6.2"
FROM ${BASE_IMAGE}

RUN export DEBIAN_FRONTEND=noninteractive && \
    ( apt-get -qqy update || true ) && \
    apt-get -qqy install ca-certificates && \
    curl -qL https://repo.radeon.com/rocm/rocm.gpg.key | apt-key add -
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get -qqy update && \
    apt-get -qqy install \
       make build-essential libssl-dev zlib1g-dev \
       libbz2-dev libreadline-dev libsqlite3-dev wget \
       curl llvm libncursesw5-dev xz-utils tk-dev \
       libxml2-dev libxmlsec1-dev libffi-dev \
       liblzma-dev \
\
       && \
    apt-get -qqy install ccache git curl && \
    apt-get -qqy --allow-change-held-packages \
            --allow-downgrades install rocm-dev hipblas hipfft hipsparse hipcub rocsparse rocrand hiprand rocthrust rocsolver rocfft rocprim rccl roctracer-dev

ENV PATH "/usr/lib/ccache:${PATH}"

ENV ROCM_HOME "/opt/rocm"
ENV LD_LIBRARY_PATH "${ROCM_HOME}/lib"
ENV CPATH "${ROCM_HOME}/include"
ENV LDFLAGS "-L${ROCM_HOME}/lib"

RUN git clone https://github.com/pyenv/pyenv.git /opt/pyenv
ENV PYENV_ROOT "/opt/pyenv"
ENV PATH "${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"
RUN pyenv install 3.12.6 && \
    pyenv global 3.12.6 && \
    pip install -U setuptools pip wheel

RUN pip install -U 'numpy==1.26.*' 'scipy==1.16.*' 'optuna==4.*' 'cython==3.0.*' 'fastrlock>=0.5'
RUN pip uninstall -y mpi4py cuda-python && \
    pip check
