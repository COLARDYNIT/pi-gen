stage('build image'){
	node {
    	checkout scm
	sh "sudo ./build.sh"
	archiveArtifacts 'work/${IMG_DATE}-${IMG_NAME}/export-image/*.img'
    }
}
