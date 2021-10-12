FROM ubuntu:20.04
EXPOSE "8080"
RUN echo -e "Install Nginx&PHP&cron...\n" \
    && apt update \
    && apt upgrade -y \
    && apt install nginx php7.4 php7.4-fpm php7.4-cgi cron git -y \
    && echo "Done.\n" \
    && echo "Add user www...\n" \
    && groupadd -r www \
    && useradd -r -g www www \
    && echo "\n www ALL=(ALL)  NOPASSWORD:ALL" >> /etc/sudoers \
    && echo "Done.\n" \
    && echo "Modify the files..." \
    && rm /etc/nginx/nginx.conf \
    && rm /etc/php/7.4/fpm/php.ini \
    && rm /etc/php/7.4/fpm/php-fpm.conf \
    && rm /etc/php/7.4/fpm/pool.d/www.conf \
    && echo "Done.\n" \
    && echo "Clean Cache..." \
    && apt clean \
    && apt autoremove \
    && echo "Done."
ADD file.tar /
RUN echo "Setting permission..."\
    && chmod -R +x /home/script \
    && chmod -R 755 /var/www/html \
    && echo "Done."
CMD ["service","php7.4-fpm","start"]