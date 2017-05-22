stage('input network'){
node {
    input id: 'creds' ,message: 'Please enter the network credentials', parameters: [string(defaultValue: '', description: '', name: 'Network'), password(defaultValue: '', description: '', name: 'Password')]
    NETWORK= creds['Network']
    PASSWORD= creds['Password']
    }
}

stage('build image'){
	node {
    sh "sudo rm -rf work/"
sh "sudo rm -rf deploy/*"	
	checkout scm
	sh "sudo ./build.sh ${NETWORK} ${PASSWORD}"
	archiveArtifacts 'work/*-dockerpi/export-image/*.img'
    }
}
