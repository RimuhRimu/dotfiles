# Defined in - @ line 1
function ls --wraps='lsd -la' --description 'alias lsa=lsd -la'
  lsd -la $argv;
end
