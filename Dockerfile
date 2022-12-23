FROM fedora:37

# install packages
RUN dnf update -y
RUN dnf install -qy rpm-sign gpg createrepo tree cronie util-linux

# initialize user as needed
RUN useradd -u 1001 -Ums /bin/bash abc && usermod -G users abc

WORKDIR /app

# Add crontab file in the cron directory
COPY crontab /etc/cron.d/update-cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/update-cron

# Apply cron job
RUN crontab /etc/cron.d/update-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Copy the scripts into the Folder
COPY ./*.sh ./

# Fix permissions
RUN chmod +x *.sh

# Run the command on container startup
#CMD ./setup.sh && ./update.sh
CMD ./setup.sh && ./update.sh && crond && tail -f /var/log/cron.log