##############################################################################################################
#
# FortiGate Terraform deployment
# Active Passive High Availability MultiAZ with AWS Transit Gateway with VPC standard attachment -
#
##############################################################################################################

# Access and secret keys to your environment
variable "access_key" {}
variable "secret_key" {}

# Prefix for all resources created for this deployment in AWS
variable "tag_name_prefix" {
  description = "Provide a common tag prefix value that will be used in the name tag for all resources"
  default     = "TGW"
}

variable "tag_name_unique" {
  description = "Provide a unique tag prefix value that will be used in the name tag for each modules resources"
  default     = "terraform"
}

// license file for the active fgt
variable "license" {
  // Change to your own byol license file, license.lic
  type    = string
  default = "license.txt"
}

// license file for the passive fgt
variable "license2" {
  // Change to your own byol license file, license2.lic
  type    = string
  default = "license2.txt"
}

// License Type to create FortiGate-VM
// Provide the license type for FortiGate-VM Instances, either byol or payg.
variable "license_type" {
  default = "payg"
}

// instance architect
// Either arm or x86
variable "arch" {
  default = "x86"
}

// instance type needs to match the architect
// c5n.xlarge is x86_64
// c6g.xlarge is arm
// For detail, refer to https://aws.amazon.com/ec2/instance-types/
variable "instance_type" {
  description = "Provide the instance type for the FortiGate instances"
  default     = "c5n.xlarge"
}

#############################################################################################################
#  AMI

// AMIs for FGTVM-7.0.13
variable "fgtami" {
  type = map(any)
  default = {
    us-east-1 = {
      arm = {
        payg = "ami-02b88dbf3700a5f5b"
        byol = "ami-0b27a3cd8791f81d9"
      },
      x86 = {
        payg = "ami-08ddb86a9817b419a"
        byol = "ami-0b9df7c9b4112667f"
      }
    },
    us-east-2 = {
      arm = {
        payg = "ami-0fef54266b1f3f839"
        byol = "ami-06286156832b4bc1c"
      },
      x86 = {
        payg = "ami-0a7f3824838c0fd23"
        byol = "ami-0e5aeee78002f1b52"
      }
    },
    us-west-1 = {
      arm = {
        payg = "ami-05a65f115e2b4ddda"
        byol = "ami-0722ab64d1988268d"
      },
      x86 = {
        payg = "ami-053456054ecc34420"
        byol = "ami-053bbb461e1383ba2"
      }
    },
    us-west-2 = {
      arm = {
        payg = "ami-0e0ad6fb2c812b428"
        byol = "ami-040b8cbb77ad91013"
      },
      x86 = {
        payg = "ami-09726299549fdd606"
        byol = "ami-0b3f1c33eff028bea"
      }
    },
    af-south-1 = {
      arm = {
        payg = "ami-03291470544e3dcac"
        byol = "ami-0f7ef8e7cac3fbbbf"
      },
      x86 = {
        payg = "ami-00378e3f324cb2bca"
        byol = "ami-030bed93165b6d9b0"
      }
    },
    ap-east-1 = {
      arm = {
        payg = "ami-0643391cbd8b97008"
        byol = "ami-00b05240e781cf155"
      },
      x86 = {
        payg = "ami-0e7b9d51ba0285884"
        byol = "ami-0f59c077a5cbded0a"
      }
    },
    ap-south-2 = {
      arm = {
        payg = "ami-0a2f3a6a2bebfab82"
        byol = "ami-0f3f7330c731ccd84"
      },
      x86 = {
        payg = "ami-03b29ed8024bb4e5d"
        byol = "ami-08daf713c278f9689"
      }
    },
    ap-southeast-3 = {
      arm = {
        payg = "ami-009f60234db4dd29b"
        byol = "ami-0ead10cab2ecfb4b8"
      },
      x86 = {
        payg = "ami-0c4b93859b32568d3"
        byol = "ami-09a8c2b83bba8c532"
      }
    },
    ap-southeast-4 = {
      arm = {
        payg = "ami-0527ccce8201d57b2"
        byol = "ami-007821c7b0e82848b"
      },
      x86 = {
        payg = "ami-04b5b5621305f438e"
        byol = "ami-0e410b4c5558ed3a0"
      }
    },
    ap-south-1 = {
      arm = {
        payg = "ami-05f96e86bfcdcf614"
        byol = "ami-02b2184fb314994fc"
      },
      x86 = {
        payg = "ami-06a9ea93035ad6652"
        byol = "ami-023143443cb993996"
      }
    },
    ap-northeast-3 = {
      arm = {
        payg = "ami-0485e9003c15264e0"
        byol = "ami-0da83eb63e69ab8ff"
      },
      x86 = {
        payg = "ami-046af57b3b3fd46a8"
        byol = "ami-0085f60f10e1a0298"
      }
    },
    ap-northeast-2 = {
      arm = {
        payg = "ami-0e56c2cca097b2628"
        byol = "ami-0800c002e0e7dbbeb"
      },
      x86 = {
        payg = "ami-062e4e4c2cfe466d4"
        byol = "ami-0bb411f8906c6f2b2"
      }
    },
    ap-southeast-1 = {
      arm = {
        payg = "ami-08f8ecb0b938823fe"
        byol = "ami-0ecbffc08882ecd74"
      },
      x86 = {
        payg = "ami-090984cf32ea97ea4"
        byol = "ami-0dafb7c6dc8a8ebb6"
      }
    },
    ap-southeast-2 = {
      arm = {
        payg = "ami-088d6f074eb5700e4"
        byol = "ami-0f48503fdef538da3"
      },
      x86 = {
        payg = "ami-0a1165ef830e492e5"
        byol = "ami-0311ff51d2232ebeb"
      }
    },
    ap-northeast-1 = {
      arm = {
        payg = "ami-014771212698ebafe"
        byol = "ami-0394fd626561487a7"
      },
      x86 = {
        payg = "ami-0b2c33900c8f6d804"
        byol = "ami-0524e0da2625fe2aa"
      }
    },
    ca-central-1 = {
      arm = {
        payg = "ami-0b09bc5a4e6610fa7"
        byol = "ami-0e06196a8bfca98c7"
      },
      x86 = {
        payg = "ami-0fac559c46f5afc79"
        byol = "ami-0510e5f1560730e0b"
      }
    },
    eu-central-1 = {
      arm = {
        payg = "ami-017a5402becfa4299"
        byol = "ami-072f4254d0c2bae1f"
      },
      x86 = {
        payg = "ami-0fc57888b67a43971"
        byol = "ami-04c996d4885c5afcb"
      }
    },
    eu-west-1 = {
      arm = {
        payg = "ami-0d70509e3d3ee7ff6"
        byol = "ami-0957c8d2d38d7027b"
      },
      x86 = {
        payg = "ami-0148d94a3247be523"
        byol = "ami-08197ab32aec93c1b"
      }
    },
    eu-west-2 = {
      arm = {
        payg = "ami-08524710126fcf515"
        byol = "ami-0308b5e1332718813"
      },
      x86 = {
        payg = "ami-0ac070755a336b320"
        byol = "ami-0fa4850e1a4d5b8f4"
      }
    },
    eu-south-1 = {
      arm = {
        payg = "ami-0f01b6304b10b1c97"
        byol = "ami-0ba78abd0e413fd4c"
      },
      x86 = {
        payg = "ami-0c408a9ba146064f4"
        byol = "ami-042fb2c517409c843"
      }
    },
    eu-west-3 = {
      arm = {
        payg = "ami-0e8b49cc6c643c96c"
        byol = "ami-0a9c1345c69aa118e"
      },
      x86 = {
        payg = "ami-0cbdc1f05fac9225f"
        byol = "ami-03a7f6b81687e5b51"
      }
    },
    eu-south-2 = {
      arm = {
        payg = "ami-0a4655362a5c09ae8"
        byol = "ami-00d88484470861fdb"
      },
      x86 = {
        payg = "ami-0e8a7fcb04e5f9020"
        byol = "ami-043d0c646b938adcd"
      }
    },
    eu-north-1 = {
      arm = {
        payg = "ami-0cc9e05420d3a3d42"
        byol = "ami-011e188158fd91abd"
      },
      x86 = {
        payg = "ami-0cf2b83d278bcedcd"
        byol = "ami-0b0d62d91c6d086b1"
      }
    },
    eu-central-2 = {
      arm = {
        payg = "ami-01681544a199a5e54"
        byol = "ami-0df220374cd60af96"
      },
      x86 = {
        payg = "ami-0b6ee6e0b012b42a4"
        byol = "ami-0618a478cdbacfd20"
      }
    },
    me-south-1 = {
      arm = {
        payg = "ami-0966e992a42967770"
        byol = "ami-096fc2519b0253e79"
      },
      x86 = {
        payg = "ami-0597b0e71c581f94d"
        byol = "ami-0cfb8aecb2b5f5879"
      }
    },
    me-central-1 = {
      arm = {
        payg = "ami-0456145b49f435ad6"
        byol = "ami-0e8b7594ae986a571"
      },
      x86 = {
        payg = "ami-0aca1b5663e53c6cf"
        byol = "ami-099eae5a37856e756"
      }
    },
    il-central-1 = {
      arm = {
        payg = "ami-0c70570cc9bc14668"
        byol = "ami-07181e7ac5e9ef82d"
      },
      x86 = {
        payg = "ami-0dc940b45a8ef459a"
        byol = "ami-0c98367d4c3839cc6"
      }
    },
    sa-east-1 = {
      arm = {
        payg = "ami-0f310a5324a486259"
        byol = "ami-0a9e5be647002d789"
      },
      x86 = {
        payg = "ami-0bf479e74e6c90ce2"
        byol = "ami-0e2d73816f9db9ffa"
      }
    }
  }
}

variable "scenario" {
  default = "ha-tgw"
}

// password for FortiGate HA configuration
variable "password" {
  default = "fortinet"
}
# References of your environment
variable "region" {
  description = "Provide the region to deploy the VPC in"
  default     = "eu-west-1"
}

variable "availability_zone1" {
  description = "Provide the first availability zone to create the subnets in"
  default     = "eu-west-1a"
}

variable "availability_zone2" {
  description = "Provide the second availability zone to create the subnets in"
  default     = "eu-west-1c"
}

# References to your Networks
# security VPC
variable "security_vpc_cidr" {
  description = "Provide the network CIDR for the VPC"
  default     = "10.0.0.0/16"
}

#### data subnets
variable "security_vpc_data_subnet_cidr1" {
  description = "Provide the network CIDR for the data subnet1 in security vpc"
  default     = "10.0.1.0/24"
}

variable "security_vpc_data_gw1" {
  description = "Provide the default local router IP for the subnet1"
  default     = "10.0.1.1/24"
}

variable "security_vpc_data_subnet_cidr2" {
  description = "Provide the network CIDR for the data subnet1 in security vpc"
  default     = "10.0.10.0/24"
}

variable "security_vpc_data_gw2" {
  description = "Provide the default local router IP for the subnet2"
  default     = "10.0.10.1/24"
}

#### relay subnets
variable "security_vpc_relay_subnet_cidr1" {
  description = "Provide the network CIDR for the relay subnet1 in security vpc"
  default     = "10.0.101.0/24"
}

variable "security_vpc_relay_subnet_cidr2" {
  description = "Provide the network CIDR for the relay subnet2 in security vpc"
  default     = "10.0.102.0/24"
}

#### mgmt subnets
variable "security_vpc_mgmt_subnet_cidr1" {
  description = "Provide the network CIDR for the mgmt subnet1 in security vpc"
  default     = "10.0.4.0/24"
}

variable "security_vpc_mgmt_subnet1_gw" {
  description = "Provide the default local router IP for the subnet1"
  default     = "10.0.4.1/24"
}

variable "security_vpc_mgmt_subnet_cidr2" {
  description = "Provide the network CIDR for the mgmt subnet2 in security vpc"
  default     = "10.0.40.0/24"
}

variable "security_vpc_mgmt_subnet2_gw" {
  description = "Provide the default local router IP for the subnet2"
  default     = "10.0.40.1/24"
}

#### Heartbeat subnets
variable "security_vpc_heartbeat_subnet_cidr1" {
  description = "Provide the network CIDR for the public subnet1 in security vpc"
  default     = "10.0.3.0/24"
}

variable "security_vpc_heartbeat_subnet_cidr2" {
  description = "Provide the network CIDR for the public subnet1 in security vpc"
  default     = "10.0.30.0/24"
}

# spoke1 VPC
variable "spoke_vpc1_cidr" {
  description = "Provide the network CIDR for the VPC"
  default     = "10.1.0.0/16"
}

variable "spoke_vpc1_private_subnet_cidr1" {
  description = "Provide the network CIDR for the private subnet1 in spoke vpc1"
  default     = "10.1.1.0/24"
}

variable "spoke_vpc1_private_subnet_cidr2" {
  description = "Provide the network CIDR for the private subnet2 in spoke vpc1"
  default     = "10.1.10.0/24"
}

# spoke2 VPC
variable "spoke_vpc2_cidr" {
  description = "Provide the network CIDR for the VPC"
  default     = "10.2.0.0/16"
}

variable "spoke_vpc2_private_subnet_cidr1" {
  description = "Provide the network CIDR for the private subnet1 in spoke vpc2"
  default     = "10.2.1.0/24"
}

variable "spoke_vpc2_private_subnet_cidr2" {
  description = "Provide the network CIDR for the private subnet2 in spoke vpc2"
  default     = "10.2.10.0/24"
}

# Mgmt VPC
variable "mgmt_cidr" {
  description = "Provide the network CIDR for the Mgmt VPC"
  default     = "10.3.0.0/16"
}

variable "mgmt_private_subnet_cidr1" {
  description = "Provide the network CIDR for the mgmt subnet1 in spoke mgmt"
  default     = "10.3.1.0/24"
}

variable "mgmt_private_subnet_cidr2" {
  description = "Provide the network CIDR for the mgmt subnet2 in spoke mgmt"
  default     = "10.3.10.0/24"
}

# References to your FortiGate
variable "ami" {
  description = "Provide an AMI for the FortiGate instances"
  default     = "automatically gathered by terraform modules"
}

variable "keypair" {
  description = "Provide a keypair for accessing the FortiGate instances"
  default     = "<AWS SSH KEY>"
}

variable "cidr_for_access" {
  description = "Provide a network CIDR for accessing the FortiGate instances"
  default     = "0.0.0.0/0"
}
