stage('build app'){
	node {
	def repository = input(
	 message: 'project to run on pi?',
	 ok: 'submit',
	 parameters: [string(defaultValue: '', description: '', name: 'repository')]
	 )
		dir('app') {

		    	mvnHome = tool 'M3'
		    	JAVA_HOME = tool 'java 8'
		    	git branch: 'v2', url: 'git@github.com:COLARDYNIT/' + repository + '.git'
		    	sh "'${mvnHome}/bin/mvn' clean compile -Pci -Dmaven.test.skip"
		    	sh "mv app/**/target/*.war work/*-dockerpi/stage2/01-sys-tweaks/files/"
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
