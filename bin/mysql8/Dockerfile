FROM mysql:8
RUN echo "default-authentication-plugin=mysql_native_password" >> /etc/mysql/my.cnf

ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
