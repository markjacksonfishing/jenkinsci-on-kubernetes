FROM jenkins/jenkins:lts

# For the sake of this demo I have cut corners. If I were to do this nicer, I would address the below items
# Pin versions in apt get install. Instead of `apt-get install <package>` use `apt-get install <package>=<version>`
# Delete the apt-get lists after installing something
# Avoid additional packages by specifying `--no-install-recommends`

# Distributed Builds plugins
RUN /usr/local/bin/install-plugins.sh ssh-agent && \
    /usr/local/bin/install-plugins.sh email-ext && \
    /usr/local/bin/install-plugins.sh mailer && \
    /usr/local/bin/install-plugins.sh slack && \
    /usr/local/bin/install-plugins.sh htmlpublisher && \
    /usr/local/bin/install-plugins.sh greenballs && \
    /usr/local/bin/install-plugins.sh simple-theme-plugin && \
    /usr/local/bin/install-plugins.sh kubernetes
    
