# seven_digital_acme_helper

The concept of this cookbook is that you will have two types of server:
1. A server who is responsible for renewing certificates (i.e. managing validation requests from letsencrypt) which will push the cert to an encrypted databag
2. Servers who retrieve the certs from the databag.

As the servers who retrieve the certs from the databag are the ones who will be serving the address we want the cert for (i.e. will receive the validation request from LetsEncrypt! they will need a redirect to the address of the renewal server.
Consider:
```
Server 1 (Renewal Server):
  FQDN: letsencrypt.example.com
  Nginx installed serving letsencrypt.example.com on 80
Server 2 (Web Server):
  FQDN example.com
  Nginx serving example.com on 80 and 443
    Configuration:
      REDIRECT /.well-known/acme-challenge TO letsencrypt.example.com/.wellknown/acme-challenge/
```