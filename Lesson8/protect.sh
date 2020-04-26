#!/bin/bash
# 1. Настроить сетевой фильтр, чтобы из внешней сети можно было обратиться только к сервисам http и ssh (80 и 443).
# 2. Запросы, идущие на порт 8080, перенаправлять на порт 80.
# 3. Настроить доступ по ssh только для вашего IP-адреса (или из всей сети вашего провайдера).

iptables -F
iptables -A OUTPUT -o lo -j ACCEPT                                      # Взаимодействия по интерфейсу Loopback
iptables -A OUTPUT -p icmp -j ACCEPT                                    # ICMP
iptables -A OUTPUT -p tcp --sport 32768:61000 -j ACCEPT                 # Исходящие соединения TCP, например apt update
iptables -A OUTPUT -p udp --sport 32768:61000 -j ACCEPT                 # Исходящие соединения UDP, например DNS
iptables -A OUTPUT -p tcp --sport 80 -j ACCEPT                          # Исходящий трафик HTTP
iptables -A OUTPUT -p tcp --sport 8080 -j ACCEPT                        # Исходящий трафик на порт 8080 для перенаправления на порт 80
iptables -A OUTPUT -p tcp --sport 443 -j ACCEPT                         # Исходящий трафик HTTPS
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --dst XXX.XXX.XXX.XXX --sport 22 -j ACCEPT     # Настроить доступ по ssh только для вашего IP-адреса (или из всей сети вашего провайдера).
iptables -A OUTPUT -j DROP                                              # Сбросить любой исходящий трафик

iptables -A INPUT -i lo -j ACCEPT                                           # Взаимодействия по интерфейсу Loopback
iptables -A INPUT -p icmp -j ACCEPT                                         # ICMP
iptables -A INPUT -p tcp -m state --state ESTABLISHED,RELATED -j ACCEPT     # Исходящие соединения TCP, например apt update
iptables -A INPUT -p udp -m state --state ESTABLISHED,RELATED -j ACCEPT     # Исходящие соединения UDP, например DNS
iptables -A INPUT -p tcp --dport 80 -j ACCEPT                               # Входящий трафик HTTP
iptables -A INPUT -p tcp --dport 8080 -j ACCEPT                             # Входящий трафик на порт 8080 для перенаправления на порт 80
iptables -A INPUT -p tcp --dport 443 -j ACCEPT                              # Входящий трафик HTTPS
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --src XXX.XXX.XXX.XXX --dport 22 -j ACCEPT          # Входящий трафик по ssh только для вашего IP-адреса (или из всей сети вашего провайдера).
iptables -A INPUT -j DROP                                                   # Сбросить любой входящий трафик

iptables -t nat -F
iptables -t nat -A PREROUTING -p tcp --dport 8080 -j REDIRECT --to-port 80  # Запросы, идущие на порт 8080, перенаправлять на порт 80
