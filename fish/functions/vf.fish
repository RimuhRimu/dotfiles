# Defined in - @ line 1
function vf --wraps=vim\ \(fzf\ --preview\ \\\'bcat\ --color=always\ --style=numbers\ --line-range=:500\ \{\}\\\'\) --wraps=vim\ \(fzf\ --preview\ \'bcat\ --color=always\ --style=numbers\ --line-range=:500\ \{\}\'\) --description alias\ vf=vim\ \(fzf\ --preview\ \'bcat\ --color=always\ --style=numbers\ --line-range=:500\ \{\}\'\)
  vim (fzf --preview 'bcat --color=always --style=numbers --line-range=:500 {}') $argv;
end
