docker build -t pajamaguy/multi-client:latest -t pajamaguy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pajamaguy/multi-server:latest -t pajamaguy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pajamaguy/multi-worker:latest -t pajamaguy/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pajamaguy/multi-client:latest
docker push pajamaguy/multi-server:latest
docker push pajamaguy/multi-worker:latest

docker push pajamaguy/multi-client:$SHA
docker push pajamaguy/multi-server:$SHA
docker push pajamaguy/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pajamaguy/multi-server:$SHA
kubectl set image deployments/client-deployment client=pajamaguy/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pajamaguy/multi-worker:$SHA