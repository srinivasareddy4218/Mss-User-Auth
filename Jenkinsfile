node{
     
    def mvnHome = tool 'maven-3.3.9'
      // holds reference to docker image
    def dockerImage
    // ip address of the docker private repository(nexus)
   
	
    stage('SCM Checkout'){
      git branch: 'main', credentialsId: 'github', url: 'https://github.com/srinivasareddy4218/Mss-User-Auth.git'
    }
	
    stage('Build Project'){
          sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"
          echo "Executed Successfully Project1"
    }

    	
       stage('Build Docker Image'){
	    sh "sudo docker build -t us.gcr.io/mssdevops-284216/javaproject ."
     }
    
    stage('GCR packaging') {
        withCredentials([file(credentialsId: 'gcp-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
        sh "gcloud auth activate-service-account --key-file=${GOOGLE_APPLICATION_CREDENTIALS}"
        sh "gcloud config set project ${projectname}"
        sh "gcloud config set compute/zone ${zone}"
        sh "gcloud config set compute/region ${region}"
        sh "gcloud auth configure-docker"
        sh "gcloud config list"
        sh "cat ${GOOGLE_APPLICATION_CREDENTIALS} | sudo docker login -u _json_key --password-stdin https://us.gcr.io"
		sh "sudo docker push us.gcr.io/mssdevops-284216/javaproject" 
        }
    }
    stage('Create Cluster GKE') {
	withCredentials([file(credentialsId: 'gcp-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
        sh "gcloud auth activate-service-account --key-file=${GOOGLE_APPLICATION_CREDENTIALS}"
	sh "gcloud config set project ${projectname}"
        sh "gcloud config set compute/zone ${zone}"
        sh "gcloud config set compute/region ${region}"
        sh "gcloud auth configure-docker"
        sh "gcloud config list"
		sh "gcloud container clusters create my-sampleproject \
--machine-type=e2-medium"
   }
   
     }
   stage('Deploy to kubernetes'){
        withCredentials([file(credentialsId: 'gcp-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
	sh "gcloud auth activate-service-account --key-file=${GOOGLE_APPLICATION_CREDENTIALS}"
//Configuring the project details to Jenkins and communicate with the gke cluster
         sh "gcloud config set project ${projectname}"
         sh "gcloud config set compute/zone ${zone}"
         sh "gcloud config set compute/region ${region}"
        sh "gcloud container clusters get-credentials javaproject --zone us-central1-a --project mssdevops-284216"
	 sh "kubectl version"
                  sh "kubectl get ns" 
		  sh "kubectl version" }
   }
}
