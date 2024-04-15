apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo-deploy
  labels:
    app: demo-deploy
spec:
  replicas: 1
  selector:
    matchLabels:
      app: demo-deploy
  template:
    metadata:
      labels:
        app: demo-deploy
    spec:
      containers:
      - name: demo-deploy
        image: IMAGE_URI
        ports:
        - containerPort: 8080
---
kind: Service
apiVersion: v1
metadata:
  name: demo-deploy
spec:
  selector:
    app: demo-deploy
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8080
  type: ClusterIP
