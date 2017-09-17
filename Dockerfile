# Pull base image
FROM centos:7

# Locale
RUN sed -i -e "s/LANG=\"en_US.UTF-8\"/LANG=\"ja_JP.UTF-8\"/g" /etc/locale.conf

# Timezone
RUN cp -p /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# System update
RUN yum -y update

# Install tools
RUN yum -y install \
        git \
        less \
        vim \
        curl \
        net-tools

# Install php & php-fpm
RUN yum install -y epel-release && \
    rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm && \
    yum install --enablerepo=remi -y \
        php \
        php-devel \
        php-mcrypt \
        php-mbstring \
        php-gd \
        php-xml \
        php-pdo \
        apc \
        php-fpm

# User
RUN groupadd --gid 1000 www-data && useradd www-data --uid 1000 --gid 1000

# Cache cleaning
RUN yum clean all

# PHP setting
# COPY ./conf/php.ini /etc/php.ini
# COPY ./data/info.php /var/www/html/
# RUN mkdir -m 777 -p /run/php-fpm
# RUN chmod -R 755 /var/www && chown -R www-data:www-data /var/www

# Listen port
EXPOSE 9000

# php-fpm startup
CMD ["/usr/sbin/php-fpm","-D"]
