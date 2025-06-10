#!/bin/sh

# Set fail on error
set -e

TIMESTAMP=$(date +%F-%H-%M)
BACKUP_FILE="/backup/all-databases-$TIMESTAMP.sql.gz"

echo "Starting backup at $(date)"

# Dump and compress
mysqldump -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" --all-databases | gzip > "$BACKUP_FILE"

# Verify backup was created
if [ -f "$BACKUP_FILE" ]; then
    echo "Backup successful: $BACKUP_FILE"
    ls -lh "$BACKUP_FILE"
else
    echo "Backup failed!"
    exit 1
fi

# Cleanup old backups (keeps last 7 days)
find /backup -name "*.sql.gz" -mtime +7 -delete
