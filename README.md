TEST your cicd on your own lightweight k8s cluster before implementing to your production

what you need:

- k8s cluster (for testing purpose I use kind)
- kubectl
- docker
- helm
- github
- Dockerfile
- main source code (for testing purpose I keep it simple, a simple python container greeting us a simple page only)
	
what is this for:
- to test  cicd using jenkins within k8s cluster

#k8s
- to simulate kubernetes cluster I use "kind":
- install and create k8s via kind, download and make changes accordingly (depends on your environment linux/mac/windows).
- to create `kind create cluster --name test-cluster-a --config=kind-cluster-expose-to-host-simple.yaml` (feel free to use the 1 with ingress for exploration, if encountered problem simply recreate or create the ingress on ingress-nginx namespace)
- to check if cluster is created `kubectl cluster-info`
- to check pods for the cluster `kubectl get pods --namespace kube-system` you may need to visit kind documentation for more info.
- if using with ingress you need to create the ff:
	- kubectl apply -f ingress-env.yml
	- kubectl apply -f create-ingress.yml

#jenkins
- a default(out-of-box) helm chart/manifest of jenkins:
	- add latest jenkins chart to helm's repo `helm repo add #reponame# https://charts.jenkins.io
	- add the stable(archived) repo `helm repo add stable https://charts.helm.sh/stable` (had to add archive repo stable to use old jenkins chart, for some reason, I haven't done RCA why on kind cluster installing jenkins using latest helm chart restarts pod without relevant error message)
- to update helm repository `help repo update`
- search jenkins chart `helm search hub jenkins`
- install jenkins chart `helm install jenkins-ci --set master.adminPassword=anystrongpasswordyouwanthere,master.serviceType=LoadBalancer #reponame#/jenkins` visit helm documentation for more info, e.g: change serviceType to NodePort if want to test locally, you may notice as well parameter master is no longer use on latest jenkins but controller instead.
- (optional) on jenkins-ci service set externalTrafficPolicy to `local`
- a jenkinsfile
- plugins: any desired or needed plugin for your CICD, e.g: blue ocean
	
