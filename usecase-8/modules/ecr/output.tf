output "repositories" {
    value = {
        for repo, resource in aws_ecr_repository.ecr : 
        repo => resource.repository_url
    }
}
