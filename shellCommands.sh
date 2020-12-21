
#retrieve token
token=$(curl -k --location --request POST 'https://govf5openshift0.cloudmegalodon.us/mgmt/shared/authn/login' \
--header 'Content-Type: application/json' \
--data-raw '{
    "username":"admin",
    "password":"clearshark123!",
    "loginProviderName":"tmos"
}' | jq -r '.token.token')

#verify token
curl -k --location --request GET 'https://govf5openshift0.cloudmegalodon.us/mgmt/shared/authz/tokens' \
--header 'X-F5-Auth-Token: ${F5_TOKEN}'

curl -k --location --request PATCH 'https://govf5openshift0.cloudmegalodon.us/mgmt/shared/authz/tokens/RUZH3RX5TN45UX56S3ZYFZ43SF' \
--header 'Content-Type: application/json' \
--header 'X-F5-Auth-Token: RUZH3RX5TN45UX56S3ZYFZ43SF' \
--data-raw '{
    "timeout":"36000"
}'
