#!/bin/bash
killall conky
sleep 10
conky -c ~/.config/conky/conky.conkyrc &
conky -c ~/.config/conky/Conky_Revisited_2/Conky_Square_Horizontal/start_conky_General_HORIZONTAL &
