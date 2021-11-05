pipeline {
    agent none
    options {
        buildDiscarder(logRotator(daysToKeepStr: '30'))
        parallelsAlwaysFailFast()
    }
    triggers { cron(env.BRANCH_NAME ==~ /^main$/ ? 'H H(0-6) 1 * *' : '') }
    stages {
        stage('Matrix') {
            matrix {
                axes {
                    axis {
                        name 'PLATFORM'
                        values 'linux-amd64', 'linux-arm64'
                    }
                }
                environment {
                    TAG_SUFFIX = "-${PLATFORM}"
                }
                stages {
                    stage('Build, Test, Publish') {
                        agent { label "${PLATFORM}" }
                        stages {
                            stage('Build') {
                                steps {
                                    sh 'docker-compose build --pull'
                                }
                            }
                            stage('Publish') {
                                environment {
                                    DOCKER_REGISTRY_CREDS = credentials('docker-registry-credentials')
                                }
                                when {
                                    branch 'main'
                                }
                                steps {
                                    sh 'echo "$DOCKER_REGISTRY_CREDS_PSW" | docker login --username "$DOCKER_REGISTRY_CREDS_USR" --password-stdin docker.io'
                                    sh 'docker-compose push'
                                }
                                post {
                                    always {
                                        sh 'docker logout docker.io'
                                    }
                                }
                            }
                        }
                        post {
                            always {
                                cleanWs()
                            }
                        }
                    }
                }
            }
        }
        stage('Publish main image') {
            agent { label "linux-amd64" }
            environment {
                DOCKER_REGISTRY_CREDS = credentials('docker-registry-credentials')
            }
            when {
                branch 'main'
            }
            steps {
                sh './manifest-push.sh'
            }
            post {
                always {
                    sh 'docker logout docker.io'
                    cleanWs()
                }
            }
        }
    }
}
