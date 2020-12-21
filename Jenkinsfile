pipeline {


  agent any
  TENANT="jsp"

  stages {
    stage ('Retrieve F5 auth token'){
      steps{
        script{

          F5_TOKEN = sh (
            label: '',
            returnStdout: true,
            script: '''curl -k --location --request POST \'https://govf5openshift0.cloudmegalodon.us/mgmt/shared/authn/login\' \\
                --header \'Content-Type: application/json\' \\
                --data-raw \'{
                    "username":"admin",
                    "password":"clearshark123!",
                    "loginProviderName":"tmos"
                }\' | jq -r \'.token.token\'
                '''
        ).trim()
       }
       echo "F5 Token is:  ${F5_TOKEN}"
      }
    }
    stage ('Verify F5 Auth Token and Set timeout'){
      steps{
        script{
          sh "curl -k --location --request GET \'https://govf5openshift0.cloudmegalodon.us/mgmt/shared/authz/tokens\' --header \'X-F5-Auth-Token: $F5_TOKEN\'"

          sh """curl -k --location --request PATCH \'https://govf5openshift0.cloudmegalodon.us/mgmt/shared/authz/tokens/$F5_TOKEN\' \\
            --header \'Content-Type: application/json\' \\
            --header \'X-F5-Auth-Token: $F5_TOKEN\' \\
            --data-raw \'{
                "timeout":"36000"
            }\'"""
          }
      }
    }
    stage ('Upload Federation Meta Data .xml'){
      steps{
        script{

          sh label: '',
          returnStatus: true,
          script: """curl --location --request POST \'https://govf5openshift0.cloudmegalodon.us/mgmt/shared/file-transfer/uploads/${TENANT}.xml\' \\
          --header \'X-F5-Auth-Token: $F5_TOKEN\' \\
          --header \'Content-Type: application/octet-stream\' \\
          --header \'Content-Range: 0-5250/5251\' \\
          --data-binary \'@/Users/jonathanspigler/projects/milcloud_f5_onboarding/tenant1.xml\'"""
        }
      }
    }
  }
}
