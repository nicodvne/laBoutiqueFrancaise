FROM php:8.0-buster

RUN apt update && apt-get install -y git unzip cron

#Installation de composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#Copie des sources
COPY . /home/app

WORKDIR /home/app

#Installation des dépendances composer et symfony CLI
RUN composer install
RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony/bin/symfony /usr/local/bin/symfony

#Exécution sur le port 80
EXPOSE 8000
CMD ["symfony", "server:start", "--port=8000"]