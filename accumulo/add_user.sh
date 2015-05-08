#!/bin/bash

su - accumulo << ENDE
echo -e "robert\nrobert\n" | accumulo shell -u root -p DOCKERDEFAULT -e 'createuser bob'
echo -e "robert\n" | accumulo shell -u root -p DOCKERDEFAULT -e 'authenticate bob'
echo -e "robert\n" | accumulo shell -u root -p DOCKERDEFAULT -e 'grant System.CREATE_TABLE -s -u bob'
ENDE
