#


## Opprette VPC

aws ec2 create-vpc --instance-tenancy "default" --cidr-block "10.0.0.0/24" --tag-specifications '{"resourceType":"vpc","tags":[{"key":"Name","value":"eksamen_api"}]}' 


## Opprett EC2

aws ec2 create-security-group --group-name "launch-wizard-1" --description "launch-wizard-1 created 2025-02-25T21:43:00.175Z" --vpc-id "vpc-059275b5b06617e43" 
aws ec2 authorize-security-group-ingress --group-id "sg-preview-1" --ip-permissions '{"IpProtocol":"tcp","FromPort":22,"ToPort":22,"IpRanges":[{"CidrIp":"84.210.0.16/32"}]}' '{"IpProtocol":"tcp","FromPort":80,"ToPort":80}' 
aws ec2 run-instances --image-id "ami-09a9858973b288bdd" --instance-type "t3.micro" --block-device-mappings '{"DeviceName":"/dev/sda1","Ebs":{"Encrypted":false,"DeleteOnTermination":true,"Iops":3000,"SnapshotId":"snap-046802eb841ec1309","VolumeSize":8,"VolumeType":"gp3","Throughput":125}}' --network-interfaces '{"SubnetId":"subnet-0bf59eaad36235385","AssociatePublicIpAddress":true,"DeviceIndex":0,"Groups":["sg-preview-1"]}' --credit-specification '{"CpuCredits":"unlimited"}' --tag-specifications '{"ResourceType":"instance","Tags":[{"Key":"Name","Value":"eksamen_server"}]}' --metadata-options '{"HttpEndpoint":"enabled","HttpPutResponseHopLimit":2,"HttpTokens":"required"}' --private-dns-name-options '{"HostnameType":"ip-name","EnableResourceNameDnsARecord":false,"EnableResourceNameDnsAAAARecord":false}' --count "1" 