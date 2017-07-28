FROM hennevogel/orr:latest
ARG IMAGE_USERID

USER root
# Install some development requirements
RUN zypper -q --non-interactive install timezone vim aaa_base glibc-locale sudo curl less tar which command-not-found

# Setup sudo
RUN echo 'orr ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Add our users
RUN useradd -m rvm
RUN useradd -m orr-dev -u $IMAGE_USERID

# Setup rvm
USER rvm
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN curl -sSL https://get.rvm.io | bash -s stable

# Run our command
USER orr-dev
CMD ["bash", "-l"] 
