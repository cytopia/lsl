#!/usr/bin/env bash

###
### My name
###
MY_NAME="lsl"


###
### Global colors
###



###
### Retrieving the ls path (for checking against label store)
###
path="$( pwd )"
IFS=$'\n'
for arg in "${@}"; do
	if [[ "${arg}" != "-"* ]]; then
		path="${arg}"
		break
	fi
done
path="$( realpath "${path}" )"


###
### Hack ls output (long output only)
###
if echo "${@}" | grep -oE '(^|[[:space:]])\-[1a-zA-Z]+' | grep -q 'l'; then
	# run ls
	#OUTPUT="$( ls "${@}" )"
	#IFS=$'\n'
	#for line in ${OUTPUT}; do
	ls "${@}" | while read line; do

		# Get last bit of line (filename part)
		# TODO: make faster
		f="$( echo "${line}" | awk '{for (i=9; i<NF; i++) printf $i " "; print $NF}' )"

		# path regex and remove possible ls color-codes
		# TODO: make faster
		p="${path}/$( echo "${f}" | sed 's/\x1B\[[0-9;]*[JKmsu]//g' )"


		# TODO: make faster
		for tag in $( grep "^${p}:::::" "${HOME}/.config/${MY_NAME}/store.lbl" 2>/dev/null ); do
			ttmp="${tag#*:::::}"
			label="${ttmp%%:::::*}"
			color="${ttmp#*:::::}"
			color="${color%%:::::*}"
			line="${line/${f}/${f} ${color}[ ${label} ]\\033\[0m}"
		done

		# Output the line
		echo -ne "${line}\n"
	done
# TODO: implement non-long output
else
	ls "${@}"
fi

