#!/bin/bash
####################
#Script to delete the users from desired Github Repo
#Author: Ram
#Version: v1.0
###################

# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token
USERNAME=$username
TOKEN=$token

# User and Repository information
REPO_OWNER=$1
REPO_NAME=$2
DELETE_USER=$3

# Function to make a GET request to the GitHub API
function github_api_get {
#takes argument from the function list_users_with_read_access
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -L -X DELETE -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users with read access to the repository
function delete_users {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators/${DELETE_USER}"

    # Fetch the list of collaborators on the repository
    #collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.role_name == "write") | .login')"
    response=$(github_api_get "$endpoint")


    # Check for Successful deletion
    if [[ $? -eq 0 ]]; then
        echo "User ${DELETE_USER} Successfully removed from ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Failed to remove ${DELETE_USER} from ${REPO_OWNER}/${REPO_NAME}:"
        echo "Response: $response"
    fi
}

# Main script

echo "Deleting users from ${REPO_OWNER}/${REPO_NAME}..."
delete_users
