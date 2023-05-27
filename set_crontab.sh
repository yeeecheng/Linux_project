#!bin/bash


# define cron_task list 
cron_tasks=()

cron_task_path="cron_task.txt"


while IFS= read -r line; do
    
	cron_tasks+=("$line")

done < "$cron_task_path"

existing_tasks=$(crontab -l 2>/dev/null)
for task in "${cron_tasks[@]}"; do 
	
	if echo "$existing_tasks" | grep -qF "$task";then
		echo "task already exist $task"
	else 
		cron_tasks_to_add+=("$task")
	fi
done

if [ "${#cron_tasks_to_add[@]}" -eq 0 ]; then 
	echo " All tasks has already existed in the crontab"
	exit 0 
fi


tmp_file=$(mktemp)

printf "%s\n" "${cron_tasks_to_add[@]}" > "$tmp_file"

crontab "$tmp_file"


if [ $? -eq 0 ]; then
   echo "Add cron_task success."
else 
   echo "Add cron_task failed."
fi


rm "$tmp_file"

