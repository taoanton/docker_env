 server {
        listen       80;
        server_name  yaf.app;

        charset utf-8;
        access_log  logs/yaf.app.access.log  main;
        error_log  logs/yaf.app.error.log error;
        root   /www/fm/yaf-examples/;
        index index.html index.htm index.php app.php;

        location / {
        #    try_files $uri $uri/ /index.php?$query_string;
            try_files $uri $uri/ /index.php$is_args$args;
        }
        #if (!-e $request_filename) {
        #    rewrite ^/(.*)  /index.php?$1 last;
        #}

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