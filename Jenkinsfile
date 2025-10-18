pipeline {

    parameters {
        booleanParam(name: 'DESTROY', defaultValue: false, description: 'Destroy Infrastructure')
    }

    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
        AWS_DEFAULT_REGION     = 'us-east-1'
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo "Checking out repository..."
                git branch: 'main', url: 'https://github.com/AdityaBhairawkar/aws_3tier_terraform'
            }
        }

        stage('Terraform Version') {
            steps {
                sh 'terraform version'
            }
        }

        stage('Initialize Terraform') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }

        stage('Format Check') {
            steps {
                dir('terraform') {
                    sh 'terraform fmt -check'
                }
            }
        }

        stage('Validate Configuration') {
            steps {
                dir('terraform') {
                    sh 'terraform validate'
                }
            }
        }

        stage('Plan Infrastructure') {
            when {
                expression { params.DESTROY == false }
            }
            steps {
                dir('terraform') {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Apply Infrastructure') {
            when {
                expression { params.DESTROY == false }
            }
            steps {
                dir('terraform') {
                    sh '''
                        if [ -f tfplan ]; then
                            echo "Applying existing plan..."
                            terraform apply -auto-approve tfplan
                        else
                            echo "No plan file found. Generating a new one..."
                            terraform plan -out=tfplan
                            terraform apply -auto-approve tfplan
                        fi
                    '''
                }
            }
        }

        stage('Output Info') {
            when {
                expression { params.DESTROY == false }
            }
            steps {
                dir('terraform') {
                    sh 'terraform output'
                }
            }
        }

        stage('Destroy Infrastructure') {
            when {
                expression { params.DESTROY == true }
            }
            steps {
                input message: 'Confirm destruction of all infrastructure?', ok: 'Yes, destroy'
                dir('terraform') {
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }

    post {
        success {
            echo 'Infrastructure deployment completed successfully.'
        }

        failure {
            echo 'Build or deployment failed. Check logs for details.'
        }

        always {
            echo 'Cleaning workspace...'
            deleteDir()
        }
    }
}
