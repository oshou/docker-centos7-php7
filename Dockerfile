# Pull base image
FROM centos:7

# System update
RUN yum -y update

# Install tools
RUN yum -y install \
        git \
        less \
        vim \
        curl \
        wget \
        zip \
        unzip \
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
        php-fpm

# Cache cleaning
RUN yum clean all

# php setting
WORKDIR /var/www
COPY info.php /var/www/html/
EXPOSE 9000

# user setting
RUN groupadd www-data && useradd www-data -g www-data -u 1000
RUN mkdir -m 777 -p /run/php-fpm

# php-fpm startup
CMD ["/usr/sbin/php-fpm","-D"]
