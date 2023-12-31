helm repo add nginx-stable https://helm.nginx.com/stable
helm install nginx-ingress-tcp nginx-stable/nginx-ingress --set-string 'controller.config.entries.use-proxy-protocol=true' --create-namespace --namespace nginx-ingress-tcp
