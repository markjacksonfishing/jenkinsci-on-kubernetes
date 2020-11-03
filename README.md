# jenkinsci-on-kubernetes
This repository is for the Jenkins Online Meetup featuring Jenkins on Kubernetes.
The [YouTube recording can be found here](https://www.youtube.com/watch?v=h4hKSXjCqyI&t=186s)

## My Setup Notes
1. Minikube start

2. kubectl create ns jenkins

3. kubectl -n jenkins apply -f jenkins-admin-rbac.yaml

4. kubectl -n jenkins apply -f jenkins-service.yaml

5. kubectl -n jenkins apply -f jenkins-deployment.yaml

6. minikube ip

7. Kubectl -n jenkins get svc for nodeport

8. Use minikube ip and :nodeport to access Jenkins UI

9. Go to build executor status to config Kubernetes

10. Choose config cloud

11. Add new cloud

12. Run kubectl cluster-info | grep master to get control plane ip

13. Add that in the Kubernetes field 

14. Test the connection

15. Add jenkins url. This is the jenkins pod IP http://<pod IP>:8080

16. Explained the work of renaming 

17. You will use jenkins/inbound-agent

18. Everything else is named inbound-agent

19. Make sure to set the label on the job when you configure it

20. Configure a new freestyle job with the inbound-agent label and a shell that just echos `Hello World`
