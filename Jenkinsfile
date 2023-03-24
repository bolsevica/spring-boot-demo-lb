node {
   def mvnHome
   def dockerImage
   stage('Prepare') {
      git 'https://github.com/cicdTrainer/spring-boot-demo.git'
      mvnHome = tool 'maven'
   }
   stage('Compile') {
      if (isUnix()) {
         sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean compile"
      } else {
         bat(/"${mvnHome}\bin\mvn" -Dmaven.test.failure.ignore clean compile/)
      }
   }
   stage('Code Review') {
   if (isUnix()) {
   sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"
   } else {
   bat(/"${mvnHome}\bin\mvn" -Dmaven.test.failure.ignore clean package/)
   }
 }
   stage('Unit Testing') {
      junit '**/target/surefire-reports/TEST-*.xml'
      archive 'target/*.jar'
   }
   stage('Integration Test') {
     if (isUnix()) {
        sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean verify"
     } else {
        bat(/"${mvnHome}\bin\mvn" -Dmaven.test.failure.ignore clean verify/)
     }
   }
   stage('Build docker') {
         dockerImage = docker.build("springboot-deploy:${env.BUILD_NUMBER}")
    }
   stage('Push image') {
        docker.withRegistry('https://registry.hub.docker.com', 'jenkins-dockerhub') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
   stage('Deploy docker'){
          sh "docker stop springboot-deploy || true && docker rm springboot-deploy || true"
          sh "docker run --name springboot-deploy -d -p 8081:8081 springboot-deploy:${env.BUILD_NUMBER}"
    }
}
