pipeline {
    agent any
    
    stages {
        stage("Test") {
            steps {
                echo "Starting Test"
                sh 'xcodebuild -scheme "NasaApodTests" -derivedDataPath derivedData -destination "platform=iOS Simulator,name=iPhone 8" test'
            }
        }
    }
    post {
        success {
            echo "Success!"
        }
    }
}
