#!/bin/bash

echo "RDS_HOST=${RDS_ENDPOINT}" >> /etc/environment
echo "RDS_USER=${RDS_USERNAME}" >> /etc/environment
echo "RDS_PASSWORD=${RDS_PASSWORD}" >> /etc/environment
echo "RDS_DB=${RDS_DATABASE_NAME}" >> /etc/environment

# Backend user data script
export RDS_HOST=${RDS_ENDPOINT}
export RDS_USER=${RDS_USERNAME}
export RDS_PASSWORD=${RDS_PASSWORD}
export RDS_DB=${RDS_DATABASE_NAME}




# Update system
sudo apt update -y
sudo apt install -y python3-pip python3-venv git
sudo apt install mysql-client-core-8.0 -y


# mysql -h $RDS_HOST -u $RDS_USER -p

# USE todo_app;

# CREATE TABLE IF NOT EXISTS todos (
#     id INT AUTO_INCREMENT PRIMARY KEY,
#     text VARCHAR(255) NOT NULL,
#     completed BOOLEAN DEFAULT FALSE,
#     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
# );




# Clone repo
cd /home/ubuntu
git clone https://github.com/AdityaBhairawkar/Todo.git
cd Todo/backend

sudo chown -R ubuntu:ubuntu /home/ubuntu/Todo
sudo chown -R $USER:$USER /home/ubuntu/Todo/backend/venv
sudo chown $USER:$USER /home/ubuntu/Todo/backend/backend.log
sudo chown -R $USER:$USER /home/ubuntu/Todo/backend

# Setup virtual environment
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Run Flask backend
nohup /home/ubuntu/Todo/backend/venv/bin/gunicorn --bind 0.0.0.0:5000 app:app > /home/ubuntu/Todo/backend/backend.log 2>&1 &

