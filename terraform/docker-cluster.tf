variable "region" {
  default = "us-central1"
}
variable "gcp_project" {
  default = "infra-como-codigo-e-automacao"
}
variable "credentials" {
  default = "~/repositorios/terraform/gcloud/credentials.json"
}
variable "vpc_name" {
  default = "default"
}
variable "user" {
  default = "ubuntu"
}
variable "pub_key" {
  default = "~/repositorios/terraform/alessander-tf.pub"
}
variable "priv_key" {
  default = "~/repositorios/terraform/alessander-tf"
}

// Configure the Google Cloud provider
provider "google" {
 credentials = "${file("${var.credentials}")}"
 project     = "${var.gcp_project}"
 region      = "${var.region}"
}

// Linux instance - Ubuntu 16.04
resource "google_compute_instance" "kube-cluster" {
 count = 1
 name         = "kube-cluster-${count.index + 1}"
 machine_type = "n1-standard-2"  # 7.5 GB RAM
 # machine_type = "n1-standard-1"  # 3.75 GB RAM
 zone         = "${var.region}-b"
 allow_stopping_for_update = true

 tags = [ "kube-cluster-${count.index + 1}" ]

 boot_disk {
   initialize_params {
     image = "ubuntu-1604-xenial-v20190306"
   }
 }

 network_interface {
   subnetwork = "default"
   access_config { }
   # If necessary update the firewall rule
   # *****************************************************************************************************
   # gcloud compute firewall-rules update YOUR_RULE_NAME --allow tcp:22,tcp:80,tcp:3389,tcp:8080,tcp:9000
   # *****************************************************************************************************
 }

 # provisioner "local-exec" {
 #     command = "gcloud compute scp ../docker-compose.yml ${var.user}@${google_compute_instance.kube-cluster.name}:~/ --zone=${var.region}-b --ssh-key-file=${file(${var.priv_key})}"
 #   }

 metadata {
   ssh-keys = "${var.user}:${file("${var.pub_key}")}"
 }

metadata_startup_script = "${file("startup-script.sh")}"

# sudo kubeadm config images pull
# sudo kubeadm init
# # Cria o wave-net pod
# kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
# kubectl get pods -n kube-system

 # provisioner "remote-exec" {
 #    connection {
 #      type = "ssh"
 #      user = "${var.user}"
 #      private_key = "${file("${var.priv_key}")}"
 #      agent = false
 #    }
 #
 #    inline = [
 #      "curl -fsSL https://get.docker.com | sudo sh && sudo usermod -aG docker ubuntu",
 #    ]
 # }
}
