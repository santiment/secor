podTemplate(label: 'docker-secor', containers: [
  containerTemplate(name: 'docker', image: 'docker', ttyEnabled: true, command: 'cat', envVars: [
    envVar(key: 'DOCKER_HOST', value: 'tcp://docker-host-docker-host:2375')
  ])
]) {
  node('docker-secor') {
    stage('Build Image') {
      container('docker') {
        def scmVars = checkout scm

        if (env.BRANCH_NAME == "master") {
          withDockerRegistry([ credentialsId: "dockerHubCreds", url: "" ]) {
            sh "docker build -t santiment/secor:${env.BRANCH_NAME} ."
            sh "docker push santiment/secor:${env.BRANCH_NAME}"
          }
        }
      }
    }
  }
}
