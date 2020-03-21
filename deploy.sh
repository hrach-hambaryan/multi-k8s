docker build -t hracho/multi-client:latest -t hracho/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hracho/multi-server:latest -t hracho/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hracho/multi-worker:latest -t hracho/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push hracho/multi-client:latest
docker push hracho/multi-server:latest
docker push hracho/multi-worker:latest

docker push hracho/multi-client:$SHA
docker push hracho/multi-server:$SHA
docker push hracho/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hracho/multi-server:$SHA
kubectl set image deployments/client-deployment client=hracho/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hracho/multi-worker:$SHA