docker build -t itreers/multi-client-k8s:latest -t itreers/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t itreers/multi-server-k8s:latest -t itreers/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t itreers/multi-worker-k8s:latest -t itreers/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push itreers/multi-client-k8s:latest
docker push itreers/multi-server-k8s:latest
docker push itreers/multi-worker-k8s:latest

docker push itreers/multi-client-k8s:$SHA
docker push itreers/multi-server-k8s:$SHA
docker push itreers/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=itreers/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=itreers/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=itreers/multi-worker-k8s:$SHA