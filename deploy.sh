docker build -t borisullmann/multi-client:latest  -t borisullmann/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t borisullmann/multi-server:latest  -t borisullmann/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t borisullmann/multi-worker:latest  -t borisullmann/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push borisullmann/multi-client:latest
docker push borisullmann/multi-client:$GIT_SHA
docker push borisullmann/multi-server:latest
docker push borisullmann/multi-server:$GIT_SHA
docker push borisullmann/multi-worker:latest
docker push borisullmann/multi-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=borisullmann/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=borisullmann/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=borisullmann/multi-worker:$GIT_SHA


