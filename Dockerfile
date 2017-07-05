FROM opensuse:42.2
ARG IMAGE_USERID

# Update distro
RUN zypper -q --non-interactive update 

# Install some system requirements
RUN zypper -q --non-interactive install timezone vim aaa_base glibc-locale sudo curl less tar which command-not-found

# Install ruby
RUN zypper -q --non-interactive install ruby2.1

# Setup sudo
RUN echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Add our users
RUN useradd -m vagrant -u $IMAGE_USERID -p "$6$UXwpVIiI8InScbAC$6SUFh/sltxF9lWLdSwLyIv6v8wNsKgiqyeNwMdzqCoqfyh3gE/FyJA0QWxUZxF9CefDr4e7E0OVL4foq78GtI0" 
RUN useradd -m rvm -p "$6$UXwpVIiI8InScbAC$6SUFh/sltxF9lWLdSwLyIv6v8wNsKgiqyeNwMdzqCoqfyh3gE/FyJA0QWxUZxF9CefDr4e7E0OVL4foq78GtI0" 

# Setup rvm
USER rvm
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN curl -sSL https://get.rvm.io | bash -s stable

# Run our command
USER vagrant
CMD ["bash", "-l"] 
