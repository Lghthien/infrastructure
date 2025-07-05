#!/bin/bash
set -eux

# Đổi về user ubuntu nếu chạy với cloud-init (nên dùng với Ubuntu 22.04 trở lên)
USER_HOME="/home/ubuntu"
export DEBIAN_FRONTEND=noninteractive

# 1. Cập nhật hệ thống & cài gói cơ bản
apt-get update -y
apt-get upgrade -y
apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  wget \
  software-properties-common \
  lsb-release \
  unzip \
  git \
  gnupg2 \
  net-tools

# 2. Cài Docker & Docker Compose
curl -fsSL https://get.docker.com | bash
usermod -aG docker ubuntu
# Docker Compose v2 (standalone)
curl -SL https://github.com/docker/compose/releases/download/v2.29.1/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# 3. Cài Node.js 20 LTS
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt-get install -y nodejs

# 4. Cài Java 17 (OpenJDK)
apt-get install -y openjdk-17-jdk

# 5. Cài Jenkins (mới nhất)
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
apt-get update
apt-get install -y jenkins
systemctl enable jenkins
systemctl start jenkins

# 6. Cài Snyk (qua npm)
npm install -g snyk

# 8. SonarQube & OWASP ZAP (qua Docker)
docker pull sonarqube:lts-enterprise

# 7. Cài Trivy (bảo mật container)
sudo apt-get install wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy




# 9. Mở firewall các port cơ bản (nếu muốn dùng UFW)
ufw allow 22 || true
ufw allow 80 || true
ufw allow 443 || true
ufw allow 8080 || true   # Jenkins
ufw allow 9000 || true   # SonarQube
ufw --force enable || true

docker run -d --name sonarqube -p 9000:9000 sonarqube:lts-enterprise
---------------------------
TẤT CẢ CÔNG CỤ ĐÃ CÀI XONG!

- Jenkins: http://<EC2_IP>:8080  | user: admin (lấy mật khẩu ở: sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
- SonarQube: http://<EC2_IP>:9000 (tự chạy docker run nếu chưa chạy: sudo docker run -d --name sonarqube -p 9000:9000 sonarqube:lts)
- OWASP ZAP: docker run -it -p 8081:8080 owasp/zap2docker-stable
- Snyk: snyk --version
- Trivy: trivy --version
---------------------------
" > /etc/motd
