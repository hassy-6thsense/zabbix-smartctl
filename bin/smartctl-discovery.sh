#!/bin/bash

for disk in $(find /dev -type b | sort);
do
    smartctl_result=$(smartctl -i "${disk}")
    printf "${smartctl_result}" | grep -Ei "SMART support is: *Enabled" >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        serial="$(printf "${smartctl_result}" | grep -E "Serial Number *: *" | awk -F": *" '{print $2}')"
        printf "${serial_list}" | grep -E "${serial}" >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            disk_list="$(printf "${disk_list}\n${disk}" | grep -E -v -e '^\s*#' -e '^\s*$')"
            serial_list="$(printf "${serial_list}\n${serial}" | grep -E -v -e '^\s*#' -e '^\s*$')"
        fi
    fi
done

json="{\"data\":["
for disk in $(printf "${disk_list}\n");
do
    json="${json}{\"{#DISK}\":\"${disk}\"},"
done
json="${json%,}]}"

printf "${json}\n"
