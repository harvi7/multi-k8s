docker build -t harshvirani/multi-client:latest -t harshvirani/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t harshvirani/multi-server:latest -t harshvirani/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t harshvirani/multi-worker:latest -t harshvirani/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push harshvirani/multi-client:latest
docker push harshvirani/multi-server:latest
docker push harshvirani/multi-worker:latest

docker push harshvirani/multi-client:$SHA
docker push harshvirani/multi-server:$SHA
docker push harshvirani/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=harshvirani/multi-server:$SHA
kubectl set image deployments/client-deployment client=harshvirani/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=harshvirani/multi-worker:$SHA