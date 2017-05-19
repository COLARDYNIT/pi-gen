stage('build image'){
	node {
    	deleteDir();
	checkout scm
	sh "sudo ./build.sh"
	archiveArtifacts 'work/*-dockerpi/export-image/*.img'
    }
}
