#!/usr/bin/env zsh

setopt promptsubst

autoload -U add-zsh-hook

PROMPT_SUCCESS_COLOR=$FG[117]
PROMPT_FAILURE_COLOR=$FG[124]
PROMPT_VCS_INFO_COLOR=$FG[242]
PROMPT_PROMPT=$FG[077]

GIT_DIRTY_COLOR=$FG[133]
GIT_CLEAN_COLOR=$FG[118]
GIT_PROMPT_INFO=$FG[012]


ZSH_THEME_GIT_PROMPT_PREFIX="git("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$GIT_PROMPT_INFO%})"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$GIT_DIRTY_COLOR%}⚡"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$GIT_CLEAN_COLOR%}✔"

ZSH_THEME_GIT_PROMPT_ADDED="%{$FG[082]%} +%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$FG[166]%} !%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$FG[160]%} ø%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$FG[220]%}➜%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$FG[082]%} ↯%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$FG[190]%} ❃%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_bold[blue]%} ↓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[blue]%} ↑%{$reset_color%}"

ZSH_THEME_VIRTUALENV_PREFIX=" ["
ZSH_THEME_VIRTUALENV_SUFFIX="]"


local prompt_git='%{$GIT_PROMPT_INFO%}$(git_prompt_info)$(virtualenv_prompt_info)%{$GIT_DIRTY_COLOR%}$(git_prompt_status) %{$reset_color%}'
local return_code='%(?..%{$fg[red]%}%? ↵%{$reset_color%})'
local prefix='%{$PROMPT_SUCCESS_COLOR%}%m:'
local suffix='%{$PROMPT_PROMPT%}ᐅ '
local dir='%{$PROMPT_SUCCESS_COLOR%}%~%'

PROMPT="${prefix}${prompt_git}${suffix}%{$reset_color%}"
RPROMPT="${return_code} ${dir}"
