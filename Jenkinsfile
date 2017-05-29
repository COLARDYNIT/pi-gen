stage('build app'){
	node {
		dir('app') {
		    	mvnHome = tool 'M3'
		    	JAVA_HOME = tool 'java 8'
		    	checkout([$class: GitSCM, source: 'https://github.com/COLARDYNIT/hwbotadmin.git'])
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
