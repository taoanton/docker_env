 server {
        listen       80;
        server_name  docker.app;

        charset utf-8;
        access_log  logs/docker.app.access.log  main;
        error_log  logs/docker.app.error.log error;
        root   /www;
        index index.html index.htm index.php app.php;

        # location !~ build{ xxx
        #     auth_basic "registry.domain.com";
        #     auth_basic_user_file /etc/nginx/registry.passwd;
        # }

        location / {
            try_files $uri $uri/ /index.php?$query_string;
        }

        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   /usr/share/nginx/html;
        }

        location ~ \.php$ {
            fastcgi_split_path_info ^(.+\.php)(/.+)$;
            fastcgi_pass php:9000;
            fastcgi_index index.php;
            include fastcgi_params;
            fastcgi_intercept_errors        off;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        }
    }