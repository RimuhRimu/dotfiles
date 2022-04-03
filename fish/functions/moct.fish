# Defined in - @ line 1
function moct --wraps='mocp -T transparent-background' --description 'alias moct=mocp -T transparent-background'
  mocp -T transparent-background $argv;
end
