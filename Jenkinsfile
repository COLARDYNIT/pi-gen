stage('build app'){
	node {
	input(
	 id: userInput ,
	 message: 'project to run on pi?',
	 ok: 'submit',
	 parameters: [string(defaultValue: '', description: '', name: 'repository')]
	 )
		dir('app') {
		    	mvnHome = tool 'M3'
		    	JAVA_HOME = tool 'java 8'
		    	git branch: 'master', url: 'git@github.com:COLARDYNIT/' + userInput + '.git'
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
