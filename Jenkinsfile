stage('build app'){
	node {
	input(
	 message: 'project to run on pi?',
	 ok: 'submit',
	 parameters: [class: 'TextParameterDefinition',string(defaultValue: '', description: '', name: 'repository')]
	 )
		dir('app') {
		    	mvnHome = tool 'M3'
		    	JAVA_HOME = tool 'java 8'
		    	git branch: 'v2', url: 'git@github.com:COLARDYNIT/' + input + '.git'
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
