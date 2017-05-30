stage('build app'){
	node {
	input(
	 message: 'Please provide repository and branch to build.',
	 ok: 'Submit',
	 parameters: [
	 string(defaultValue: '', description: 'repository to build from git', name: 'repository'),
	 string(defaultValue: 'master', description: 'specify which branch you want to build ( default master)', name: 'branch')
	 ]
	 )
		dir('app') {
		    	mvnHome = tool 'M3'
		    	JAVA_HOME = tool 'java 8'
		    	git branch: '' + input['branch'], url: 'git@github.com:COLARDYNIT/' + input['repository'] + '.git'
		    	sh "'${mvnHome}/bin/mvn' clean compile -Pci -Dmaven.test.skip"
		}
    }
}
stage('build image'){
	node {
        sh "sudo rm -rf work/**/*.img"
		checkout scm
		sh "sudo ./build.sh"
		archiveArtifacts 'work/*-dockerpi/export-image/*.img'
    }
}
