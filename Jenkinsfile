stage('build image'){
	node {
    sh "sudo rm -rf work/"
sh "rm -rf deploy/*"	
	checkout scm
	sh "sudo ./build.sh"
	archiveArtifacts 'work/*-dockerpi/export-image/*.img'
    }
}
