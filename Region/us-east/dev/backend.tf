terraform {
	backend "s3" {
		bucket         	   = "deu1-state-bucket"
    		key              	   = "state/terraform.tfstate"
    		region         	   = "us-east-1"
    		encrypt        	   = true
	}
}
