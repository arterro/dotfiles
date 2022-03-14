#***
# Filesearch
#***
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

#***
# Create directory and enter it
#***
function mkcd() { mkdir -p "$@" && cd "$_"; }

#***
# Search 1Password for object
#***
function opwd() { op get item $1 | jq '.details.fields[] | (select(.designation=="username").value),(select(.designation=="password").value)' }

#***
# Create note
#***
autoload bashcompinit
bashcompinit

_n() {
  local lis cur
  lis=$(find "${NOTES}" -name "*.md" | \
    sed -e "s|${NOTES}/||" | \
    sed -e 's/\.md$//')
  cur=${comp_words[comp_cword]}
  compreply=( $(compgen "$lis" -- "$cur") )
}

n() {
  : "${NOTES:?'NOTES env var not set'}"
  if [ $# -eq 0 ]; then
    local file
    file=$(find "${NOTES}" -name "*.md" | \
      sed -e "s|${NOTES}/||" | \
      sed -e 's/\.md$//' | \
      fzf \
        --multi \
        --select-1 \
        --exit-0 \
        --preview="cat ${NOTES}/{}.md" \
        --preview-window=right:70%:wrap)
    [[ -n $file ]] && \
      ${editor:-vim} "${NOTES}/${file}.md"
  else
    case "$1" in
      "-d")
        rm "${NOTES}"/"$2".md
        ;;
      *)
        ${editor:-vim} "${NOTES}"/"$*".md
        ;;
    esac
  fi
}

complete -f _n n

function pip-install-save { 
    pip install $1 && pip freeze | grep $1 >> requirements.txt
}

#***
# Create tmux Session
#***
function tsession() {
    sh ~/.tmux/tmux-bootstrap.sh $1
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
    fi
}

#***
# Create a new git branch
#***
function createbranch() {
    if [[ -z $1 ]] ; then
        echo "Please specify a branch name."
        return 1
    fi

    g checkout -b ${1}
    git push --set-upstream origin ${1}
}

#***
# Remove all branches other than defined
#***
function prunebranches() {
    if [[ -z $1 ]] ; then
        echo "Please specify the branch you would like to keep."
        return 1
    fi

    g checkout ${1} && g pull && g branch | grep -v "${1}" | xargs git branch -D
}

