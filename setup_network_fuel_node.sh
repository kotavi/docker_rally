#!/bin/bash
#
#


get_management_network_info(){
    fuel_net_grp=$(fuel network-group | grep management | awk '{ if ($5 ~ /^[0-9]+$/) print $0;}')
    vlan_tag=$(fuel network-group | grep management | awk '{if ($5 ~ /^[0-9]+$/) print $5}')
    cidr=$(fuel network-group | grep management | awk '{if ($5 ~ /^[0-9]+$/) print $7}')
    echo "Management network information: "
    echo "$fuel_net_grp"
}

enter_interface_info(){
    echo "Enter ip addrress (e.q. 10.109.6.233/24): "
    read ip_addr_drg
    echo "Enter broadcast address: "
    read brd
    ip_address=$(echo $ip_addr_drg | cut -d\/ -f1)
    available=$(sudo -u postgres psql -d nailgun -c "select * from ip_addrs" | grep $ip_address | wc -l)
}

check_availability_ip_addr(){
    while [ $available -eq 1 ]
        do
            echo
            echo "IP ADDRESS IS NOT AVAILABLE"
            enter_interface_info
        done
}

check_information(){
    echo
    echo "The next COMMANDS will be executed, please CHECK them:"
    echo
    echo "ip link add link eth1 name eth1.$vlan_tag type vlan id $vlan_tag"
    echo "ip addr add $ip_addr_drg brd $brd dev eth1.$vlan_tag"
    echo "ip link set dev eth1.$vlan_tag up"
    echo
    echo "Proceed (Y/N): "; read reply
    if [ $reply == 'N' ]; then
        echo 'Exiting the script'
        exit 0
    fi
}

bring_interface_up(){
    echo $reply
    if [ $reply == 'Y' ]; then
        echo "The next commands will be executed, please check them:"
        echo "ip link add link eth1 name eth1.$vlan_tag type vlan id $vlan_tag"
        echo "ip addr add $ip_addr_drg brd $brd dev eth1.$vlan_tag"
        echo "ip link set dev eth1.$vlan_tag up"
    fi
#    # Create interface (add vlan interface):
#    ip link add link eth1 name eth1.$vlan_tag type vlan id $vlan_tag
#    # Provide interface with an address:
#    ip addr add $ip_addr_drg brd $brd dev eth1.$vlan_tag
#    # Bring interface up:
#    ip link set dev eth1.$vlan_tag up
}


## The next steps show how to delete interface
#ip link set dev eth1.301 down
#ip link delete eth1.301

get_management_network_info
enter_interface_info
check_availability_ip_addr
check_information
bring_interface_up