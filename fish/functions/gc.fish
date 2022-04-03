# Defined in - @ line 1
function gc --wraps='git clone' --description 'alias gc=git clone'
  git clone $argv;
end
