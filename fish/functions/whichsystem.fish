# Defined in - @ line 1
function whichsystem --wraps='~/.config/whichsystem' --wraps='~/.config/whichsystem.py' --description 'alias whichsystem=~/.config/whichsystem.py'
  ~/.config/whichsystem.py  $argv;
end
