#!/bin/bash

#Criar uma chave de autenticacao para logar
AUTH_TOKEN="$(curl -d '{"jsonrpc": "2.0","method": "user.login","params":{"user":"Admin","password":"zabbix"},"id": 1,"auth": null}' -H "Content-Type: application/json-rpc" -X POST http://192.168.1.88/api_jsonrpc.php)"

#Chave de autenticacao
AUTH_TOKEN="$(echo $AUTH_TOKEN | cut -c28-59)"


#Criar host group
GROUP_ID="$(curl -d '{"jsonrpc": "2.0","method": "hostgroup.create","params": {"name": "Sites Monitorados"},"auth": "'$AUTH_TOKEN'","id": 1}' -H "Content-Type: application/json-rpc" -X POST http://192.168.1.88/api_jsonrpc.php)"


#HoustGroup ID
GROUP_ID="$(echo $GROUP_ID | cut -c41)"

#Criar Template
TEMPLATE_ID="$(curl -d '{"jsonrpc": "2.0","method": "template.create","params": {"host": "Template Sites Monitorados","groups": {"groupid": '$GROUP_ID'}},"auth":"'$AUTH_TOKEN'","id":1}' -H "Content-Type: application/json-rpc" -X POST http://192.168.1.88/api_jsonrpc.php)"


#Template ID
TEMPLATE_ID="$(echo $TEMPLATE_ID | cut -c44-48)"



#Criar Host Site API
curl -d '{"jsonrpc": "2.0","method": "host.create","params": {"host": "API Cep","interfaces": [{"type": 1,"main": 1,"useip": 1,"ip": "127.0.0.1","dns": "","port": "10050"}],"groups": [{"groupid": "'$GROUP_ID'"}],"templates": [{"templateid": "'$TEMPLATE_ID'"}]},"auth": "'$AUTH_TOKEN'","id": 1}' -H "Content-Type: application/json-rpc" -X POST http://192.168.1.88/api_jsonrpc.php

#Criar webscenario
curl -d '
{
    "jsonrpc": "2.0",
    "method": "httptest.create",
    "params": {
        "name": "Homepage",
        "hostid": "",
        "steps": [
            {
                "name": "API Cep",
                "url": "http://192.168.1.87",
                "status_codes": 200,
                "no": 1
            },
        ]
    },
    "auth": "'$AUTH_TOKEN'",
    "id": 1
}' -H "Content-Type: application/json-rpc" -X POST http://192.168.1.88/api_jsonrpc.php