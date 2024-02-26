#!/bin/bash
#Esse script tem a função de automatizar o deploy de uma aplicação PHP, em um servidor Apache no sistema operacional CentOS7.
#Para usar o script coloque uma aplicação PHP dentro do diretório /etc/content/ e execute o Script.
#Para verificar se a aplicação foi instanciada com sucesso consule o endereço localhost:80.
#Ou acesse usando o endereço da máquina através do endereço web www."hostname da maquina".com.
#Segue abaixo um breve resumo sobre o comportamento do script.

#Verificação se o Apache está instalado na máquina. Caso já esteja instalado, serão removidos todos os pacotes e arquivos de configuração do Apache. 
#Após a remoção do Apache, começa a isntalação das dependências, sendo as principais: httpd(Apache) e PHP.
httpd -v &> /dev/null

if [ $? -ge 1 ]
then
    yum install httpd -y
    yum install php -y
else
    yum remove httpd* -y
    rm -rf /var/www/html
    rm -rf /etc/httpd
    firewall-cmd --remove-port=80/tcp --permanent

    yum install httpd -y
    yum install php -y
fi

#A parte abaixo é responsável pela transferência da aplicação PHP para o servidor.
systemctl start httpd
mkdir /var/www/html/${HOSTNAME}.com
cp -a /etc/content/. /var/www/html/${HOSTNAME}.com

#Configurações do servidor. sendo estas:
#Criação de um Apache VirtualHost, Abertura de portas através do firewall e configuração de um DNS dentro da máquina através do hostname.
#Ao final o servidor é reiniciado e está pronto para requisições.
touch /etc/httpd/conf.d/${HOSTNAME}.com.conf
printf "<VirtualHost *:80>\n   ServerName www.${HOSTNAME}.com\n   DocumentRoot /var/www/html/${HOSTNAME}.com\n   ErrorLog ./logs/error-app.log\n</VirtualHost>\n" > /etc/httpd/conf.d/${HOSTNAME}.com.conf

firewall-cmd --add-port=80/tcp --permanent
firewall-cmd --reload

sed -i "s/\t${HOSTNAME}/\twww.${HOSTNAME}.com/" /etc/hosts

systemctl restart httpd