# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="spaceship"   # steeef  robbyrussell cloud rixius dallas ys spaceship

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  	git
	autojump
	incr
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

source <(kubectl completion zsh)
source ~/.bashrc 
source ~/.bash_profile

export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8


##### SPACESHIP #######
# ORDER
SPACESHIP_PROMPT_ORDER=(
  user
  host
  time
  git
  golang
  docker
  kubectl
  jobs          # Background jobs indicator
  exec_time
  # terraform
  line_sep
  char
  dir
  # node
  # ruby
  # xcode
  # swift
  # battery       # Battery level and status
  vi_mode       # Vi-mode indicator
  exit_code     # Exit code section
  # venv
  # pyenv
)

# USER
SPACESHIP_USER_PREFIX="" # remove `with` before username
SPACESHIP_USER_SUFFIX="" # remove space before host
SPACESHIP_USER_SHOW="always"
# SPACESHIP_USER_COLOR="212"

# time 
SPACESHIP_TIME_SHOW="true"
SPACESHIP_TIME_FORMAT="%D{%H:%M:%S %x %A %jday}"
SPACESHIP_TIME_PREFIX=""
# SPACESHIP_TIME_SUFFIX=""
# SPACESHIP_BATTERY_SHOW="always"

# EXEC_TIME
SPACESHIP_EXEC_TIME_SHOW="true"
SPACESHIP_EXEC_TIME_PREFIX="took. "
SPACESHIP_EXEC_TIME_COLOR="red"
SPACESHIP_EXEC_TIME_ELAPSED="0.000001"

# char
SPACESHIP_CHAR_SYMBOL="$"
SPACESHIP_CHAR_PREFIX=""
SPACESHIP_CHAR_SUFFIX=" "

# HOST
SPACESHIP_HOST_SHOW="always"
SPACESHIP_HOST_SHOW_FULL="true"
SPACESHIP_HOST_COLOR="yellow"
# Result will look like this:
#   username@:(hostname)
SPACESHIP_HOST_PREFIX="@"
SPACESHIP_HOST_SUFFIX=": "

# DIR
SPACESHIP_DIR_SHOW="true"
SPACESHIP_DIR_PREFIX="" # disable directory prefix, cause it's not the first section
SPACESHIP_DIR_TRUNC="0" # show only last directory
# SPACESHIP_DIR_PREFIX="in ./"
SPACESHIP_DIR_TRUNC_PREFIX="./"
SPACESHIP_DIR_TRUNC_REPO="false"

# GIT
# Disable git symbol
SPACESHIP_GIT_SYMBOL="" # disable git prefix
SPACESHIP_GIT_BRANCH_PREFIX="" # disable branch prefix too
SPACESHIP_GIT_PREFIX="git:("
SPACESHIP_GIT_SUFFIX=") "
SPACESHIP_GIT_BRANCH_SUFFIX="" # remove space after branch name
SPACESHIP_GIT_STATUS_PREFIX=""
SPACESHIP_GIT_STATUS_SUFFIX=""

# NODE
SPACESHIP_NODE_PREFIX="node:("
SPACESHIP_NODE_SUFFIX=") "
SPACESHIP_NODE_SYMBOL="⬢ "

# GOLANG
SPACESHIP_GOLANG_PREFIX="go:("
SPACESHIP_GOLANG_SUFFIX=") "
SPACESHIP_GOLANG_SYMBOL="🐹 "

# DOCKER
SPACESHIP_DOCKER_PREFIX="docker:("
SPACESHIP_DOCKER_SUFFIX=") "
SPACESHIP_DOCKER_SYMBOL="🐳 "

# kubectl ·
SPACESHIP_KUBECTL_SHOW="true"
SPACESHIP_KUBECTL_PREFIX="k8s:("
SPACESHIP_KUBECTL_SUFFIX=") "
SPACESHIP_KUBECTL_SYMBOL="☸️ "

###################
