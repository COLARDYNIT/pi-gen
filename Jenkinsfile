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
		    	git branch: 'master', url: 'git@github.com:COLARDYNIT/' + repository + '.git'
		    	sh "export APP_NAME="+repository
		    	sh "'${mvnHome}/bin/mvn' package -Pprod -Dmaven.test.skip"
		    	sh "mv target/*.war work/*-dockerpi/stage2/01-sys-tweaks/files/"
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
