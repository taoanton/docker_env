server {
    listen 80;
    server_name  yaf.app;
    root   /www/fm/yaf-example/yaf-light-frame/;
    index  index.php index.html index.htm;
    access_log  logs/yaf.app.access.log  main;
    error_log  logs/yaf.app.error.log error;

    if (!-e $request_filename) {
        rewrite ^/(.*)  /index.php?$1 last;
    }

    #location / {
        #try_files $uri $uri/ /index.php/$query_string;
    #}

    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass php:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_intercept_errors        off;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }
}
