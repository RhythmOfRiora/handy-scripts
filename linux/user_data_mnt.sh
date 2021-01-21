#!/bin/bash -xe

EC2_INSTANCE_ID=$(curl -s http://instance-data/latest/meta-data/instance-id)
AWS_REGION="us-east-1"
######################################################################

DATA_STATE="unknown"
until [ "${DATA_STATE}" == "attached" ]; do
  DATA_STATE=$(aws ec2 describe-volumes \
    --region ${AWS_REGION} \
    --filters \
        Name=attachment.instance-id,Values=${EC2_INSTANCE_ID} \
        Name=attachment.device,Values=/dev/xvdp \
    --query Volumes[].Attachments[].State \
    --output text)

  sleep 5
done

mkdir -p /mnt/db
mkdir -p /mnt/influx
mount /dev/nvme1n1 /mnt/db
mount /dev/nvme2n1 /mnt/influx
echo /dev/nvme1n1 /mnt/db ext4 defaults,nofail 0 2 >> /etc/fstab
echo /dev/nvme2n1 /mnt/influx ext4 defaults,nofail 0 2 >> /etc/fstab
chown -R influxdb:influxdb /mnt/
service influxdb start

/dev/xvdf
mkdir -p /mnt/grafana
mount /dev/xvdf /mnt/grafana
echo /dev/xvdf /mnt/grafana ext4 defaults,nofail 0 2 >> /etc/fstab
# Persist the volume in /etc/fstab so it gets mounted again
echo '/dev/xvdh /data ext4 defaults,nofail 0 2' >> /etc/fstab
