pipeline {
  agent any
  stages {
    stage("Checkout") { steps { checkout scm } }
    stage("Scan") { steps { sh "trivy image --severity CRITICAL --exit-code 1 --no-progress 734391586315.dkr.ecr.us-east-1.amazonaws.com/yokozuna-app:1.0.0" } }
    stage("Init") { steps { sh "terraform init -input=false" } }
    stage("Validate") { steps { sh "terraform fmt -check -recursive && terraform validate" } }
    stage("Plan") { steps { sh "terraform plan -out=tfplan -input=false" } }
    stage("Approve") { steps { input message: "Appliquer ECS + Kubernetes ?" } }
    stage("Apply") { steps { sh "terraform apply -input=false tfplan" } }
  }
  post { always { archiveArtifacts artifacts: "tfplan", allowEmptyArchive: true } }
}
