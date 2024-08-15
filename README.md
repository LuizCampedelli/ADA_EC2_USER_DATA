# ADA EC2 USER DATA

This project aims to create a simple web server in AWS EC2, using it's user data parameters.

Deploy will be handled in Nginx, using and t2.micro, in default VPC settings, using Amazon Linux 2023.

No DNS, AWS Route 53 nor AWS Cloudfront will be added in this project, to keep as simple as possible.

So, that's how is done:




## Demonstração

![AWS EC2 USER DATA drawio (1)](https://github.com/user-attachments/assets/ce8e975a-3b8e-4fd1-8213-6f2e572d0e01)




## Deploy

To deploy via command line, directly to EC2 instance connect or through the AWS CLI:

```bash
  aws ec2 run-instances \
  --image-id $IMAGE_ID \
  --count 1 \
  --instance-type $INSTANCE_TYPE \
  --key-name $KEY_NAME \
  --security-group-ids $SECURITY_GROUP_ID \
  --subnet-id $SUBNET_ID \
  --region $AWS_REGION \
  --tag-specifications "ResourceType=instance,Tags=[{Key=$TAG_KEY,Value=$TAG_VALUE}]"
```

Or through the AWS Console:

Select Launch Instances in EC2 section at AWS Console:

Add a name, select the Amazon Machine Image (AMI), in this case, Amazon Linux 2023.

![Launch ec2 01](https://github.com/user-attachments/assets/61f08ba7-21c3-4f2f-bfe1-c7963fce7aca)

![Launch ec2 02](https://github.com/user-attachments/assets/8dfbf4d8-73f0-469a-a65a-db03bb20ebad)

![Launch ec2 03](https://github.com/user-attachments/assets/df6b57ae-0d12-4810-ac22-4f6d18a916c0)

## User data code is in user_data.txt, in code of this repo.

![Launch ec2 04](https://github.com/user-attachments/assets/983d2db7-9293-4cd7-a8f4-e5b65ec679ba)

## Hit Launch Instance

# Once launched, wait a few minutes to be ready, and access the EC2 panel, click in the instance id, choose the DNS Ipv4 address, will be like:

```http
 ec2-182-104-22-202.compute-1.amazon.com
```
## Put in your browser and a page will display like this one:

![Welcome to Nginx](https://github.com/user-attachments/assets/2268b396-9ab6-4648-98d3-936cec88dc23)

## Have fun, kepp coding!!!
