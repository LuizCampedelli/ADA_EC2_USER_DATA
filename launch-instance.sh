#!/bin/bash

# Variaveis, substitua pelos valores da sua conta
# Variables, replace with your account values
IMAGE_ID="ami-xxxxxxxxxxxxxxxxx"
INSTANCE_TYPE="t2.micro"
KEY_NAME="your-key-name"
SECURITY_GROUP_ID="sg-xxxxxxxxxxxx"
SUBNET_ID="subnet-xxxxxxxxxxxx"
AWS_REGION="us-east-1"
TAG_KEY="Name"
TAG_VALUE="MyNginxServer"

# Read the User Data script
# Le o script de User Data
USER_DATA=$(<user-data.sh)

# Run the EC2 instance
# Inicia a instancia EC2
aws ec2 run-instances \
  --image-id $IMAGE_ID \
  --count 1 \
  --instance-type $INSTANCE_TYPE \
  --key-name $KEY_NAME \
  --security-group-ids $SECURITY_GROUP_ID \
  --subnet-id $SUBNET_ID \
  --region $AWS_REGION \
  --tag-specifications "ResourceType=instance,Tags=[{Key=$TAG_KEY,Value=$TAG_VALUE}]" \
  --user-data "$USER_DATA"
