#!/bin/bash

# تابع برای تبدیل آدرس IP به عدد صحیح
ip_to_int() {
    local ip="$1"
    local a b c d
    IFS=. read -r a b c d <<< "$ip"
    echo $((a * 256**3 + b * 256**2 + c * 256 + d))
}

# تابع برای تبدیل عدد صحیح به آدرس IP
int_to_ip() {
    local ip_int="$1"
    echo "$((ip_int >> 24 & 255)).$((ip_int >> 16 & 255)).$((ip_int >> 8 & 255)).$((ip_int & 255))"
}

# محدوده IP
start_ip="212.77.192.0"
end_ip="212.77.207.255"

# تبدیل آدرس‌های IP به عدد صحیح
start_int=$(ip_to_int "$start_ip")
end_int=$(ip_to_int "$end_ip")

# تولید و پینگ 10 آدرس IP
for ((i=0; i<10; i++)); do
    # تولید یک آدرس IP تصادفی در محدوده
    random_ip_int=$((RANDOM % (end_int - start_int + 1) + start_int))
    random_ip=$(int_to_ip "$random_ip_int")

    # پینگ آدرس IP و نمایش نتیجه
    echo "Pinging $random_ip..."
    ping -c 1 "$random_ip" &>/dev/null

    if [ $? -eq 0 ]; then
        echo "$random_ip is reachable."
    else
        echo "$random_ip is not reachable."
    fi
done
