exit
clear
cd ~
tail -f ~/.gemini/server.log
exit
mkdir -p ~/.config/htop
cat <<EOF > ~/.config/htop/htoprc
fields=0 48 17 18 38 39 40 2 46 47 1
sort_key=46
sort_direction=1
hide_threads=0
hide_userland_threads=0
shadow_other_users=0
show_thread_names=1
show_program_path=1
highlight_base_name=1
detailed_cpu_time=1
cpu_count_from_zero=0
update_process_names=0
account_guest_in_cpu_meter=1
color_scheme=0
delay=15
left_meters=AllCPUs Memory Swap
right_meters=Tasks LoadAverage Uptime
EOF

nano ~/.bashrc
exit
