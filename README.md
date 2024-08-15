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
  --tag-specifications "ResourceType=instance,Tags=[{Key=$TAG_KEY,Value=$TAG_VALUE}]" \
  --user-data '#!/bin/bash
sudo yum update -y
sudo yum install nginx -y
if ! command -v nginx &> /dev/null
then
    echo "Nginx não foi instalado com sucesso" >&2
    exit 1
fi
sudo systemctl start nginx
sudo systemctl enable nginx
sudo mkdir -p /usr/share/nginx/html
echo "<!DOCTYPE html>
<html lang=\"en\">
<head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>Matrix Presentation</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: black;
            font-family: monospace;
            color: #0F0;
            font-size: 24px;
        }
        .matrix-line {
            display: flex;
            overflow: hidden;
            white-space: nowrap;
        }
        .matrix-char {
            display: inline-block;
        }
    </style>
</head>
<body>
    <div class=\"matrix-line\" id=\"matrixText\">
        <!-- Characters will be dynamically inserted here by JavaScript -->
    </div>
    <script>
        const finalText = \"Bem vindo ao AWS Nginx, deploy em EC2 com User Data.\";
        const characters = \"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\";
        const matrixLine = document.getElementById(\"matrixText\");
        for (let i = 0; i < finalText.length; i++) {
            const span = document.createElement(\"span\");
            if (finalText[i] === \" \") {
                span.innerHTML = \"&nbsp;\";
            } else {
                span.textContent = characters[Math.floor(Math.random() * characters.length)];
            }
            span.className = \"matrix-char\";
            matrixLine.appendChild(span);
        }
        let iterations = 0;
        const maxIterations = 3;
        const interval = setInterval(() => {
            for (let i = 0; i < finalText.length; i++) {
                if (iterations < maxIterations) {
                    if (finalText[i] !== \" \") {
                        matrixLine.children[i].textContent = characters[Math.floor(Math.random() * characters.length)];
                    }
                } else {
                    if (finalText[i] === \" \") {
                        matrixLine.children[i].innerHTML = \"&nbsp;\";
                    } else {
                        matrixLine.children[i].textContent = finalText[i];
                    }
                }
            }
            iterations++;
            if (iterations > maxIterations) {
                clearInterval(interval);
            }
        }, 100);
    </script>
</body>
</html>
" | sudo tee /usr/share/nginx/html/index.html
sudo systemctl restart nginx'

```

Or through the AWS Console:

Select Launch Instances in EC2 section at AWS Console:

Add a name, select the Amazon Machine Image (AMI), in this case, Amazon Linux 2023.

![Launch ec2 01](https://github.com/user-attachments/assets/61f08ba7-21c3-4f2f-bfe1-c7963fce7aca)

![vpc](https://github.com/user-attachments/assets/2839bc87-98e6-430a-ade8-a0fbd02675cd)

![Launch ec2 03](https://github.com/user-attachments/assets/df6b57ae-0d12-4810-ac22-4f6d18a916c0)

## User data code is in user_data.md, in code of this repo.

![Launch ec2 04](https://github.com/user-attachments/assets/983d2db7-9293-4cd7-a8f4-e5b65ec679ba)

## Hit Launch Instance

# Once launched, wait a few minutes to be ready, and access the EC2 panel, click in the instance id, choose the DNS Ipv4 address, will be like:

```http
 ec2-182-104-22-202.compute-1.amazon.com
```
## Put in your browser and a page will display like this one:

![Welcome to Nginx](https://github.com/user-attachments/assets/2268b396-9ab6-4648-98d3-936cec88dc23)

## Have fun, keep coding!!!
