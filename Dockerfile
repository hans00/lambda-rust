# https://github.com/lambci/docker-lambda#documentation
FROM lambci/lambda:build-provided.al2

ARG RUST_VERSION=1.52.1
ENV CARGO_HOME=/cargo
ENV RUSTUP_HOME=/rustup
RUN yum install -y jq openssl-devel
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
    | sh -s -- -y --profile minimal --default-toolchain $RUST_VERSION
RUN $CARGO_HOME/bin/rustup target add x86_64-unknown-linux-musl
ADD build.sh /usr/local/bin/
VOLUME ["/code"]
WORKDIR /code
ENTRYPOINT ["/usr/local/bin/build.sh"]
