stage('build image'){
	node {
        sh "sudo rm -rf work/**/*.img"
        sh "sudo rm -rf home/pi/app"
	checkout scm
	sh "sudo ./build.sh"
	archiveArtifacts 'work/*-dockerpi/export-image/*.img'
    }
}
