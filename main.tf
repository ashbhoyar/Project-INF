module "vpc" {
    source = "./vpc_module"
    environment = "Dev" 
    vpc_cidr             = "192.168.0.0/16"
    public_subnets_cidr  = ["192.168.1.0/24", "192.168.2.0/24"]
    private_subnets_cidr = ["192.168.3.0/24", "192.168.4.0/24"]
    availability_zone   = ["ap-northeast-1a", "ap-northeast-1c"]
}


module "eks" {
    source = "./eks_module"
    cluster_name = "my_cluster"
    kubernetes_version = "1.28" 
    iam_role = "eks-cluster-role"
    node_group_name = "eks-nodes"
    instance_type = "t3.medium"
    max_available_config = 2
    public_subnet_1 = module.vpc.public-subnet-id-1
    public_subnet_2 = module.vpc.public-subnet-id-2
    private_subnet_1 = module.vpc.private-subnet-id-1
    private_subnet_2 = module.vpc.private-subnet-id-2
    core_dns = "coredns"
    core_dns_version = "v1.10.1-eksbuild.11"
    vpc_cni = "vpc-cni"
    vpc_cni_version = "v1.18.1-eksbuild.3"
    kube_proxy = "kube-proxy"
    kube_proxy_version = "v1.28.6-eksbuild.2"
    sg_name =  "eks_sg"
    sg_vpc_id  = module.vpc.vpc-id
    port_list =  [80,5052,443,9090,3000,3306]
}
