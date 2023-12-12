# vkcloud_kubernetes
Setup k8s cluster in vk cloud and Nginx Ingress

# Terraform
[Official manual](https://cloud.vk.com/docs/manage/tools-for-using-services/terraform/quick-start)

1. Download ```vkcs_provider.tf``` and ```terraform.rc``` from project settings in account
2. Put ```vkcs_provider.tf``` in local folder, cat terraform.rc to ```~/.terraformrc```
3. You can also your password into local ```vkcs_provider.tf``` file

# Kubernetes cluster via terraform
All configs are in the repo
[Official manual](https://cloud.vk.com/docs/base/k8s/operations/create-cluster/create-terraform)
1. ```terraform apply```
2. So that you could use kubectl you need it's config
3. Install kubectl
4. install ```keystone-auth```

   ```curl -sSL https://hub.mcs.mail.ru/repository/client-keystone-auth/latest/linux/client-install.sh | bash```
6. After cluster creation in Account → Containers → Kubernetes Clusters you can download kubeconfig in ```<cluster name>_kubeconfig.yaml``` format
7. Then put it's contents to ```~/.kube/config``` or put it somewhere, for ex: ```/home/user/.kube/kubernetes-cluster-1234_kubeconfig.yaml``` and set ```export KUBECONFIG=/home/user/.kube/kubernetes-cluster-1234_kubeconfig.yaml```
8. Test - ```kubectl get nodes```

# Nginx Ingress
[Official manual](https://cloud.vk.com/docs/base/k8s/use-cases/ingress/ingress-tcp#7985-tabpanel-1)
1. Sources of the app was taken from [official example](https://github.com/nginxinc/kubernetes-ingress/tree/v2.4.0/examples/ingress-resources/complete-example)
2. Install helm repo of nginx ```helm repo add nginx-stable https://helm.nginx.com/stable```
3. Install nginx controller with proxy feature ```helm install nginx-ingress-tcp nginx-stable/nginx-ingress --set-string 'controller.config.entries.use-proxy-protocol=true' --create-namespace --namespace example-nginx-ingress-tcp```
4. When I check ```kubectl get svc -n example-nginx-ingress-tcp``` I don't get ```external-ip``` as in manual, but then, when I check it in global ips in vk cloud web and use it, after some time it appears in kubectl, so...
5. After that we can check it: -k for bypass self-signed certs warning
   ```curl -k https://cafe.きく.コム/tea```
   ```
   Server address: 10.100.249.193:8080
   Server name: tea-6b8fc7844-6bcsc
   Date: 12/Dec/2023:19:17:31 +0000
   URI: /tea
   Request ID: cdcaa473b730508f33d7dd8f49827e1a
   ```
6. ```curl -k https://cafe.きく.コム/coffee```
   ```
   Server address: 10.100.249.192:8080
   Server name: coffee-77df955494-hqmb7
   Date: 12/Dec/2023:19:18:34 +0000
   URI: /coffee
   Request ID: 2b734a0dc0fb5c9acac9c0505250c94f
   ```
7. Obviously we should add DNS record for out ingress to our domain owner: global ip of ingress which vk cloud gave us in (mentioned in part 4.)
