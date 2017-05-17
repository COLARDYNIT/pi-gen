stage('build image'){
	node {
    	checkout scm
	sh "sudo ./build.sh"
	archiveArtifacts 'work/*-dockerpi/export-image/*.img'
    }
}
