#!/usr/bin/env python
import subprocess


# function to parse output of command "wpctl status" and return a dictionary of sinks with their id and name.
def parse_wpctl_status():
    # Execute the wpctl status command and store the output in a variable.
    output = str(subprocess.check_output("wpctl status", shell=True, encoding="utf-8"))

    # remove the ascii tree characters and return a list of lines
    lines = (
        output.replace("├", "")
        .replace("─", "")
        .replace("│", "")
        .replace("└", "")
        .splitlines()
    )

    # get the index of the Sinks line as a starting point
    sinks_index = None
    for index, line in enumerate(lines):
        if "Sinks:" in line:
            sinks_index = index
            break

    # start by getting the lines after "Sinks:" and before the next blank line and store them in a list
    sinks = []
    for line in lines[sinks_index + 1 :]:
        if not line.strip():
            break
        sinks.append(line.strip())

    # remove the "[vol:" from the end of the sink name
    for index, sink in enumerate(sinks):
        sinks[index] = sink.split("[vol:")[0].strip()

    # strip the * from the default sink
    for index, sink in enumerate(sinks):
        if sink.startswith("*"):
            sinks[index] = sink.strip().replace("*", "").strip() + " - Default"

    sinks_dict = []
    for sink in sinks:
        num = sink.split(".")[0]
        inspect = subprocess.run(
            f"wpctl inspect {num} | grep nick",
            shell=True,
            encoding="utf-8",
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        )
        name = inspect.stdout.strip().split("= ")[1].replace('"', "")
        sinks_dict.append({"id": num, "name": name})

    return sinks_dict


# get the list of sinks ready to put into wofi - highlight the current default sink
output = ""
sinks = parse_wpctl_status()
for items in sinks:
    if items["name"].endswith(" - Default"):
        output += f"<b>{items['name']}</b>\n"
    else:
        output += f"{items['name']}\n"

output += "Clear default"

# Call wofi and show the list. take the selected sink name and set it as the default sink
wofi_command = f"echo '{output}' | wofi --dmenu --hide-scroll --prompt=sinks --allow-markup --cache-file=/dev/null --location=top_right --width=500 --height=200"
wofi_process = subprocess.run(
    wofi_command,
    shell=True,
    encoding="utf-8",
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
)

if wofi_process.returncode != 0:
    exit(0)

selected_sink_name = wofi_process.stdout.strip()

if selected_sink_name == "Clear default":
    subprocess.run("wpctl clear-default", shell=True)
else:
    selected_sink = next(sink for sink in sinks if sink["name"] == selected_sink_name)
    subprocess.run(f"wpctl set-default {selected_sink['id']}", shell=True)
