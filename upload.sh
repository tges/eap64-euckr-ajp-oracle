docker save -o eap64-euckr-ajp-oracle.tar jboss-eap-6/eap64-openshift-euckr-ajp-oracle:latest
scp eap64-euckr-ajp-oracle.tar root@10.1.0.42:/root
ssh root@10.1.0.42 "docker load -i /root/eap64-euckr-ajp-oracle.tar"
ssh root@10.1.0.42 "docker push jboss-eap-6/eap64-openshift-euckr-ajp-oracle:latest"

