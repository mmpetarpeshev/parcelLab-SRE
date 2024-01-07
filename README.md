# parcelLab-SRE
parcelLab SRE challenge solution

# parcelLab-SRE
parcelLab SRE challenge solution

The repository contains solutions for all required tasks (minimum and optional ones).  

Minimum requirements:
1. Create a “Hello World” greetings service (REST-API) which responds with different salutations for customers (there won’t be further purpose for this API, just one GET endpoint is fine)
   Customer A wants to say “Hi”, customer B wants to say “Dear Sir or Madam”, customer C wants to say “Moin” and so on.
   Choose whatever programming language and framework you think might be the best fit
   Describe or implement the necessary things to ensure “good quality“ for your product
2. Automated docker build & push process with Github Actions plus deployment with helm to minikube.  
3. Deploy to local Kubernetes environments like minikube with GH Actions

## Requirements
Docker and Helm

## Local build , run and test

Docker build and run:

docker build -t parcel-lab .

docker run -p 5000:5000 parcel-lab

The parcel-lab python app will be available on http://localhost:5000

Build and push with the bash script.Example script run with arguments:

./build_push.sh --image-name my-app --image-tag v1.0 --registry https://index.docker.io/v1 --username my-docker-username --password my-docker-password --repository my-docker-repo

Curl commands to test all customers endpoints:

curl http://localhost:5000/greet/customerA
curl http://localhost:5000/greet/customerB
curl http://localhost:5000/greet/customerC

Simulate error with random wrong customer.For example:

curl http://localhost:5000/greet/customerD

## Github Actions pipeline

To repository has pipeline for automated deployment of the helm charts to minikube on every push in main branch.  

https://github.com/mmpetarpeshev/parcelLab-SRE/actions

## Helm Chart

Repository contains helm chart for parcelLab python app.
The helm chart supports the creation of the following  resources:

    * deployment  
    * hpa  
    * ingress  
    * pvc  
    * service  
    * service account  

The chart could be installed with the following command:

```
  helm instal --values charts/parcel-lab/values.yaml parcel-lab ./charts/parcel-lab --dependency-update
```

## Feature improvements
1. Pipeline Enhancement: Consider splitting the test steps into a separate pipeline as they expand.

2. Traefik Ingress:Explore exposing the service with Traefik Ingress (template available in the chart).
   Note: Traefik deployment to minikube requires additional work.

3. Resource Creation Enhancement: Improve conditional creation of resources for better resource management.
