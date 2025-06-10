FROM mysql:5.7

# Copy backup script into the image
COPY backup.sh /backup.sh

# Make sure the script is executable
RUN chmod +x /backup.sh

# Set default command to run the backup script
CMD ["/backup.sh"]
