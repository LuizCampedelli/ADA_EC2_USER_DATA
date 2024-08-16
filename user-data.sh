#!/bin/bash
# Atualizar pacotes
# Update packages
sudo yum update -y

# Instalar Nginx usando yum
# Install Nginx using yum
sudo yum install nginx -y

# Verificar se a instalação foi bem-sucedida
# Check if the installation was successful
if ! command -v nginx &> /dev/null
then
    echo "Nginx não foi instalado com sucesso" >&2
    exit 1
fi

# Iniciar o serviço Nginx
# Start the Nginx service
sudo systemctl start nginx
sudo systemctl enable nginx

# Criar uma página HTML personalizada
# Create a custom HTML page
sudo mkdir -p /usr/share/nginx/html
echo "<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="shortcut icon" href="https://ada-site-frontend.s3.sa-east-1.amazonaws.com/home/header-logo.svg" type="image/x-icon">
    <title>Projeto 03</title>
</head>
<body>
    <div class="container">
        <div class="cabecalho">
            <a href="https://ada.tech/" target="_blank"><img src="https://ada-site-frontend.s3.sa-east-1.amazonaws.com/home/header-logo.svg" alt="Logotipo da ADA" class="sc-252c66c8-7 fWMNFR"></a>
            <h1>Santander Coders Projeto Web Deploy na AWS EC2</h1>
            <a href="https://www.santanderopenacademy.com/pt_br/index.html" target="_blank"><img class="santander-header__logo-image" src="https://pro-becas-images-s3.s3.eu-west-1.amazonaws.com/images/logo-soa.svg" alt="Logotipo Santander Open Academy"></a>
        </div>
        <hr class="custom-hr">
        <div class="aluno">
            <h2>Autor</h2>
            <h3>Luiz Otavio Campedelli</h3>
            <h4>Id: 1182001</h4>
        </div>
        <hr class="custom-hr">
        <div class="corpo">
            <h2>Agradecimentos</h2>
            <div class="texto">
                <p>Gostaria de expressar minha sincera gratidão aos professores <strong><a href="https://www.linkedin.com/in/herika-machado-6082441a/" target="_blank">Hérika Machado</a></strong> e <strong><a href="https://www.linkedin.com/in/daniel-vieira-9a9680127/" target="_blank">Daniel Vieira</a></strong> pela dedicação, paciência e orientação durante todo o curso de Sistema Operacional Linux. Seus ensinamentos foram fundamentais para o meu desenvolvimento e compreensão das complexidades desse sistema. Através do seu compromisso e apoio, pude aprofundar meus conhecimentos e construir as bases necessárias para continuar minha jornada no mundo da tecnologia.
                <br>
                <br>Agradeço, também, pela motivação contínua e pelo encorajamento para superar os desafios ao longo do curso. Sem suas contribuições, este projeto não seria possível.
                <br>
                <br>Quero também expressar meu agradecimento aos meus colegas de turma. O compartilhamento de conhecimento e a colaboração ao longo do curso foram essenciais para meu aprendizado e crescimento. Juntos, enfrentamos os desafios e nos apoiamos em cada etapa do caminho.
                <br>
                <br>Obrigado por todo o conhecimento compartilhado e por serem uma fonte de inspiração.</p>
            </div>
        </div>
    </div>
    <footer>
        <div class="contato">
            <a href="https://github.com/LuizCampedelli" target="_blank" title="GitHub"><i class="fab fa-github"></i></a>
            <a href="https://www.linkedin.com/in/luiz-otavio-campedelli" target="_blank" title="LinkedIn"><i class="fab fa-linkedin"></i></a>
        </div>
        <p>© 2024 <a href="" target="_blank">Luiz Otavio Campedelli</a></p>
    </footer>
    <button id="scroll-top-btn">↑</button>
    <script>
        const scrollTopBtn = document.getElementById('scroll-top-btn');
        function handleScroll() {
            if (window.scrollY > 100) {
                scrollTopBtn.style.display = 'block';
            } else {
                scrollTopBtn.style.display = 'none';
            }
        }

        window.addEventListener('scroll', handleScroll);

        scrollTopBtn.addEventListener('click', function () {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });

        handleScroll();
    </script>
</body>
</html>
" | sudo tee /usr/share/nginx/html/index.html

# Criar um arquivo de estilo CSS personalizado
# Create a custom CSS file
echo "* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

html, body {
  height: 100%; /* Para garantir que o corpo tenha altura total */
}

body {
  display: flex;
  flex-direction: column;
  font-family: 'Roboto', sans-serif;
  background-color: #182319;
  color: #fff;
  margin: 0;
}

.container {
  flex: 1; /* Faz o contêiner principal expandir para ocupar o espaço disponível */
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
}

.cabecalho {
  display: flex;
  flex-direction: column; /* Changed from row to column for vertical stacking */
  justify-content: center; /* Center content horizontally */
  align-items: center; /* Center content vertically */
  margin: 2em 5%;
  gap: 2em;
  text-decoration: none;
  color: inherit;
}

.cabecalho h1 {
  font-size: 1.5rem;
  text-align: center; /* Ensures text inside h1 is centered */
}

.custom-hr {
  border: 0;
  height: 2px;
  background: #99f135;
  margin: 1.5em 0;
}

.aluno {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  margin: 2em 5%;
  gap: 1em;
}

.corpo h2 {
  margin-bottom: 1.5em;
}

.corpo {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin: 2em 5%;
  line-height: 1.8;
}

.corpo .texto {
  margin: 1em 15%;
}

.corpo p a {
  text-decoration: none;
  color: #fff;
  transition: 0.5s ease;
}

.corpo p a:hover {
  color: #A6F750;
}

footer {
  text-align: center;
  padding: 20px 0;
  background-color: #182319;
  width: 100%;
}

footer .contato {
  display: flex;
  gap: 15px;
  align-items: center;
  justify-content: center;
  margin-bottom: 5px;
}

footer a {
  text-decoration: none;
  color: #fff;
  transition: 0.5s ease;
}

footer a:hover {
  color: #A6F750;
}

#scroll-top-btn {
  position: fixed;
  bottom: 20px;
  right: 20px;
  background-color: #444;
  color: #fff;
  border: none;
  border-radius: 50%;
  padding: 10px 15px;
  font-size: 1.5rem;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

#scroll-top-btn:hover {
  background-color: #A6F750;
}
" | sudo tee /usr/share/nginx/html/style.css

# Reiniciar o Nginx para garantir que as mudanças sejam aplicadas
# Restart Nginx to ensure the changes are applied
sudo systemctl restart nginx
