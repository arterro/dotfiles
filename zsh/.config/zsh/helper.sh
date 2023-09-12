#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)

#***
# Filesearch
#***
function f() { find . -iname "*$1*" "${@:2}"; }
function r() { grep "$1" "${@:2}" -R .; }

#***
# Create directory and enter it
#***
function mkcd() { mkdir -p "$@" && cd "$_" || exit; }

#***
# Search 1Password for object
#***
function opwd() { op get item "$1" | jq '.details.fields[] | (select(.designation=="username").value),(select(.designation=="password").value)'; }

function pip-install-save { 
    pip install "$1" && pip freeze | grep "$1" >> requirements.txt
}

#***
# Create tmux Session
#***
function tsession() {
    sh ~/.tmux/tmux-bootstrap.sh "$1"
}

#***
# Set AWS profile
#***
function setaws() {
    local PURPLE='\033[1;35m'
    local YELLOW='\033[1;33m'
    local NC='\033[0m' # No Color

    if ! command -v aws &> /dev/null; then
	echo -e "${PURPLE}Please install the AWS Command Line Interface.${NC}"
	return 1
    fi

    local profile_name="${1}"
    local profile_status=$( (aws configure --profile ${profile_name} list) 2>&1)

    if [[ $profile_status = *'could not be found'* ]]; then
        echo -e "Unable to locate credentials for ${PURPLE}${profile_name}${NC}."
        echo -e "You can configure credentials by running \"${YELLOW}aws configure --profile ${1}${NC}\"."
    else
        export AWS_DEFAULT_PROFILE=$profile_name
        export AWS_PROFILE=$profile_name
        export AWS_DEFAULT_REGION=$(aws configure get region)
        export AWS_REGION=$(aws configure get region)
        export AWS_ACCOUNT=$(aws sts get-caller-identity --query "Account" --output text)
        export AWS_ACCOUNT_ALIAS=$(aws iam list-account-aliases --query "AccountAliases" --output text)
    fi
}

#***
# Create a new git branch
#***
function createbranch() {
    if [[ -z $1 ]]; then
        echo "Please specify a branch name."
        return 1
    fi

    g checkout -b "${1}"
    git push --set-upstream origin "${1}"
}

#***
# Remove all branches other than defined
#***
function prunebranches() {
    if [[ -z $1 ]] ; then
        echo "Please specify the branch you would like to keep."
        return 1
    fi

    git checkout "${1}" && g pull && g branch | grep -v "${1}" | xargs git branch -D
}

#***
# Rename branch local and remote
#***
function mvbranch() (
    current_branch=$1

    if [[ -z $1 ]] ; then
        current_branch=$(git branch --show-current)
    else
        git checkout "$1"
    fi

    printf "\nDo you want to rename the branch ${bold}%s${normal}?\n" "$current_branch"
    
    select yn in "Yes" "No"; do
        case $yn in
            "Yes")
                echo "Yes"
                ;;
            "No")
                echo "No"
                ;;
        esac
    done

    printf "\nNew branch name:"

    read -r new_branch_name
    
    printf "\nRenaming branch from %s to %s..." "$current_branch" "$new_branch_name"

    git branch -m "$new_branch_name"
    git push origin -u "$new_branch_name"
    git push origin :"$current_branch"
)

#***
# Remove branch local and remote
#***
function rmbranch() {
    if [[ -z $1 ]] ; then
        printf "Please specify a branch name."
        return 1
    fi

    git branch -d "$1"
    git push origin :"$1"
}
