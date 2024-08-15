#!/bin/bash
# Atualizar os pacotes e o sistema
yum update -y

# Instalar o servidor web Nginx
amazon-linux-extras install nginx1 -y

# Iniciar o serviço Nginx e habilitá-lo para iniciar automaticamente no boot
systemctl start nginx
systemctl enable nginx

# Criar a página HTML simples
echo "<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    <div class="matrix-line" id="matrixText">
        <!-- Characters will be dynamically inserted here by JavaScript -->
    </div>

    <script>
        const finalText = "Bem vindo ao AWS Nginx, deploy em EC2 com User Data.";
        const characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        const matrixLine = document.getElementById("matrixText");

        // Initialize the line with random characters
        for (let i = 0; i < finalText.length; i++) {
            const span = document.createElement("span");
            if (finalText[i] === " ") {
                span.innerHTML = "&nbsp;"; // Ensure proper spaces
            } else {
                span.textContent = characters[Math.floor(Math.random() * characters.length)];
            }
            span.className = "matrix-char";
            matrixLine.appendChild(span);
        }

        let iterations = 0;
        const maxIterations = 3;
        const interval = setInterval(() => {
            for (let i = 0; i < finalText.length; i++) {
                if (iterations < maxIterations) {
                    // Change characters randomly
                    if (finalText[i] !== " ") {
                        matrixLine.children[i].textContent = characters[Math.floor(Math.random() * characters.length)];
                    }
                } else {
                    // Settle on the final text with proper spaces
                    if (finalText[i] === " ") {
                        matrixLine.children[i].innerHTML = "&nbsp;";
                    } else {
                        matrixLine.children[i].textContent = finalText[i];
                    }
                }
            }
            iterations++;
            if (iterations > maxIterations) {
                clearInterval(interval); // Stop the animation after 3 iterations
            }
        }, 100); // Change every 100ms
    </script>
</body>
</html>
" > /usr/share/nginx/html/index.html

# Configurar permissões (se necessário)
chown nginx:nginx /usr/share/nginx/html/index.html
chmod 644 /usr/share/nginx/html/index.html

# Reiniciar o serviço Nginx para garantir que as alterações sejam aplicadas
systemctl restart nginx
