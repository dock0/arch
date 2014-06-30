FROM scratch
MAINTAINER akerl <me@lesaker.org>
ADD ducktape /ducktape
RUN ["ducktape", "https://github.com/dock0/arch/releases/download/v0.0.5/root.tar.bz2"]
CMD ["/bin/bash"]
