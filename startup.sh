#!/usr/bin/env bash

cat << 'EOF' > /etc/nginx/conf.d/proxy.conf
server {
        listen 80;
        server_name $PROXY_DOMAIN;

        location / {
                proxy_pass http://$JENKINS_HOST;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_connect_timeout 150;
                proxy_send_timeout 100;
                proxy_read_timeout 100;
                proxy_buffers 4 32k;
                client_max_body_size 8m;
                client_body_buffer_size 128k;
        }

        location /github-webhook {
                proxy_pass http://$JENKINS_HOST;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_connect_timeout 150;
                proxy_send_timeout 100;
                proxy_read_timeout 100;
                proxy_buffers 4 32k;
                client_max_body_size 8m;
                client_body_buffer_size 128k;
        }

        location /ghprbhook {
                proxy_pass http://$JENKINS_HOST;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_connect_timeout 150;
                proxy_send_timeout 100;
                proxy_read_timeout 100;
                proxy_buffers 4 32k;
                client_max_body_size 8m;
                client_body_buffer_size 128k;
        }
}
EOF

sed -i 's/$JENKINS_HOST/'"$JENKINS_HOST"'/g' /etc/nginx/conf.d/proxy.conf
sed -i 's/$PROXY_DOMAIN/'"$PROXY_DOMAIN"'/g' /etc/nginx/conf.d/proxy.conf

service nginx restart