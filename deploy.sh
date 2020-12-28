docker build -t guanxin43/multi-client:latest -t guanxin43/multi-client:$SHA -f ./client/Dockerfile ./client # build image
docker build -t guanxin43/multi-server:latest -t guanxin43/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t guanxin43/multi-worker:latest -t guanxin43/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push guanxin43/multi-client:latest # push image to docker hub with the latest tag
docker push guanxin43/multi-server:latest
docker push guanxin43/multi-worker:latest

docker push guanxin43/multi-client:$SHA # push image to docker hub with the $SHA tag
docker push guanxin43/multi-server:$SHA
docker push guanxin43/multi-worker:$SHA

kubectl apply -f k8s # apply configs in the k8s directory
kubectl set image deployments/client-deployment server=guanxin43/multi-client:$SHA
kubectl set image deployments/server-deployment client=guanxin43/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=guanxin43/multi-worker:$SHA

