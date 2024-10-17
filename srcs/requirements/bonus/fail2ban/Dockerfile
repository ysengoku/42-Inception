FROM debian:bullseye

RUN apt update -y && apt upgrade -y && apt-get install -y \
	fail2ban \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./conf/custom.conf /etc/fail2ban/jail.d/custom.conf
COPY ./conf/nginx-http-auth.conf /etc/fail2ban/filter.d/nginx-http-auth.conf


# Start fail2ban
ENTRYPOINT ["/usr/bin/fail2ban-server", "-f"]

#Pour vérifier le bon fonctionnement de fail2ban vous pouvez essayer de vous identifier plusieurs fois en saisissant un mauvais mot de passe. Si Fail2ban fonctionne, vous devriez être interdit d'accès au serveur au bout d'un certain nombre d'essais (précisés dans la configuration à la ligne maxretry) à condition de ne pas avoir mis votre IP dans la directive ignoreip.
#Attention ! Pensez à régler la valeur de bantime sur un temps assez court si vous faites ce genre d’essais afin de pouvoir vous reconnecter à votre serveur.

#Côté serveur vous pouvez également surveiller ce qu'il se passe avec la commande

#sudo fail2ban-client status sshd

#qui dans ce cas vous retournera le statut de la prison « sshd » (avec le nombre de tentatives échouées et la liste des IP bannies)

#Si vous utilisez un service sujet à de nombreuses attaques par force brute, comme sshd sur le port standard 22, vous devriez très rapidement voir les premiers bannissements.

#Vous pouvez aussi examiner les logs de fail2ban pour voir les actions effectuées :

#tail -f /var/log/fail2ban.log

