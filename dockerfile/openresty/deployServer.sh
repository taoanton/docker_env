#!/bin/bash

sites=/opt/sites/sites.txt
conf=/opt/conf/

# 判断文件是否存在
if [ ! -f "$sites" ]
then 
    echo "sites.txt not found!"
    exit 1
fi

for line in `cat $sites`
do 
    arr=(${line//=/ })
    # echo "${line}"
    # echo "arr[0]:" ${arr[0]}
    # echo "arr[1]:" ${arr[1]}
    echo "
    server {
        listen       80;
        server_name  ${arr[0]};

        charset utf-8;
        access_log  logs/${arr[0]}.access.log  main;
        error_log  logs/${arr[0]}.error.log error;
        root   ${arr[1]};
        index index.html index.htm index.php app.php;

        location / {
            try_files \$uri \$uri/ /index.php?\$query_string;
        }

        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   /usr/share/nginx/html;
        }

        location ~ \.php\$ {
            fastcgi_split_path_info ^(.+\.php)(/.+)\$;
            fastcgi_pass php:9000;
            fastcgi_index index.php;
            include fastcgi_params;
            fastcgi_intercept_errors        off;
            fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        }
    }
    " > "/usr/local/openresty/nginx/conf/conf.d/${arr[0]}"
done

if [ -d "$conf" ]
then
    for site in `ls $conf`
    do
        cp -f $conf$site /usr/local/openresty/nginx/conf/conf.d/        
    done
    
fi

chown -R www-data:www-data /usr/local/openresty/nginx/conf/conf.d/

# nginx -s reload