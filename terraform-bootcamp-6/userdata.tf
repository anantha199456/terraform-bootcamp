data "template_file" "user_data" {
  template = <<EOF
#!/bin/bash -xe
sudo apt-get update -y
sudo apt-get install -y default-jre nfs-common
sudo mkdir ${var.JENKINS_HOME}
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${module.create_efs.efs_dns}:/ ${var.JENKINS_HOME}
wget "https://get.jenkins.io/war/${var.jenkins_version}/jenkins.war"
export JENKINS_HOME=${var.JENKINS_HOME}
nohup java -jar jenkins.war &
  EOF
}