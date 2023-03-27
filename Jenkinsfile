pipeline {
environment {
registry = "bolsevica/springboot"
registryCredential = 'jenkins-dockerhub'
dockerImage = ''
}
agent any
stages {
stage('Cloning Git') {
steps {
git 'https://github.com/bolsevica/spring-boot-demo-lb.git'
}
}
stage('Compile') {
steps {
sh 'mvn package'
 sh 'pwd'
  sh 'ls -lah'
}
}
stage('Building image') {
steps{
script {
dockerImage = docker.build registry + ":$BUILD_NUMBER"
}
}
}
stage('Deploy our image') {
steps{
script {
docker.withRegistry( '', registryCredential ) {
dockerImage.push()
}
}
}
}
stage('Run image') {
steps{
script {
dockerImage.withRun('-p 8081:8080')
}
}
}
//stage('Cleaning up') {
//steps{
//sh "docker rmi $registry:$BUILD_NUMBER"
//}
//}
}
}
