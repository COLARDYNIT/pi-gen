stage('input network'){
node {
    input id: 'input' ,message: 'Please enter the network credentials', parameters: [string(defaultValue: '', description: '', name: 'Network'), password(defaultValue: '', description: '', name: 'Password')]
    NETWORK=input['Network']
    PASSWORD=input['Password']
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
