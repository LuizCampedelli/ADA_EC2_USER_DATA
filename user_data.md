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
    <title>Bem-vindo ao Servidor Nginx</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            overflow: hidden;
            background: black;
            color: #00FF00;
            font-family: monospace;
            font-size: 15px;
        }

        .matrix {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
            white-space: nowrap;
        }

        .text-animation span {
            display: inline-block;
            opacity: 0;
            animation: animate 2s linear infinite;
        }

        @keyframes animate {
            0% {
                opacity: 0;
                transform: translateY(-20px);
            }
            50% {
                opacity: 1;
                transform: translateY(0);
            }
            100% {
                opacity: 0;
                transform: translateY(20px);
            }
        }
    </style>
</head>
<body>
    <div class="matrix" id="matrix-container"></div>

    <script>
        const message = "Bem-vindo ao servidor web Nginx configurado automaticamente! Este servidor está rodando em uma instância Amazon Linux.";
        const matrixContainer = document.getElementById('matrix-container');

        function createMatrixEffect() {
            matrixContainer.innerHTML = '';
            for (let i = 0; i < message.length; i++) {
                const span = document.createElement('span');
                span.textContent = message[i];
                span.style.animationDelay = `${i * 0.1}s`;
                matrixContainer.appendChild(span);
            }
        }

        setInterval(createMatrixEffect, 2000);
        createMatrixEffect();
    </script>
</body>
</html>" > /usr/share/nginx/html/index.html

# Configurar permissões (se necessário)
chown nginx:nginx /usr/share/nginx/html/index.html
chmod 644 /usr/share/nginx/html/index.html

# Reiniciar o serviço Nginx para garantir que as alterações sejam aplicadas
systemctl restart nginx
