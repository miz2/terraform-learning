ec2_config = [ {
    ami            = "ami-0c55b159cbfafe1f0" # Example AMI, replace with a valid one for your region ubuntu
    instance_type = "t2.micro"
    }, {
    ami            = "ami-0c55b159cbfafe1f0" # Example AMI, replace with a valid one for your region amazon linux
    instance_type = "t2.micro"
    }, {
    
} ]
ec2_map = {
    ubuntu = {
        ami            = "ami-0c55b159cbfafe1f0" # Example AMI, replace with a valid one for your region ubuntu
        instance_type = "t2.micro"
    },
    amazon_linux = {
        ami            = "ami-0c55b159cbfafe1f0" # Example AMI, replace with a valid one for your region amazon linux
        instance_type = "t2.micro"
    }
}