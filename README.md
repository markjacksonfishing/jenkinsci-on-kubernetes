# WELCOME!

Welcome to the Jenkins Online Meetup featuring Jenkins on Kubernetes! We promise it's going to be more fun than your typical root canal procedure.

Here are some setup notes to get started:

1. Start up minikube.
2. Create a namespace for Jenkins. Think of it like a tiny kingdom ruled by our favorite continuous integration tool.
3. Apply the jenkins-admin-rbac.yaml file to give Jenkins the keys to the kingdom.
4. Create a service for Jenkins to help Kubernetes know where to find it.
5. Deploy Jenkins with the jenkins-deployment.yaml file. It's like bringing a new baby into the world, except this baby's name is Jenkins.
6. Get the IP address of your minikube and feel like a hacker for a brief moment.
7. Check out the nodeport by running kubectl -n jenkins get svc. It's like a fun treasure hunt, but instead of treasure, you get Jenkins.
8. Use the minikube IP address and nodeport to access the Jenkins UI. It's like a portal to a magical land of continuous integration.
9. Head over to build executor status to configure Kubernetes. This is where the real magic happens.
10. Choose config cloud. It's like being the captain of your own cloud kingdom.
11. Add a new cloud. It's like building a new castle for your kingdom.
12. Use kubectl cluster-info | grep master to get the control plane IP. It's like the key to the kingdom.
13. Add that to the Kubernetes field. It's like unlocking a secret door to a room full of candy.
14. Test the connection. It's like solving a mystery and revealing the culprit.
15. Add the Jenkins URL. This is the Jenkins pod IP, like your own personal compass that will guide you to the land of continuous integration.
16. Let's talk about renaming. It's like giving Jenkins a new name, like Prince or Beyonce.
17. Use jenkins/inbound-agent for your jobs. It's like a secret code that only cool people know.
18. Everything else is named inbound-agent. It's like wearing matching outfits with your BFF.
19. Make sure to set the label on the job when you configure it. It's like giving your new puppy a name tag so you don't lose them.
20. Configure a new freestyle job with the inbound-agent label and a shell that just echoes Hello World. It's like teaching your new puppy to sit, but way less messy.

So there you have it - a fun and easy way to get started with Jenkins on Kubernetes! Have fun, and may the continuous integration force be with you!
