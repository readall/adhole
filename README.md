# adhole
mega list of spammers

There is a very good set of lists maintained at https://firebog.net/
This list is just an amalgamation of all the lists maintained there
Checked for recommended whitelist and those are removed from the list.

Simplified for easy digestion with Pihole 5 as gravity list.

## Infrastructure setup and lifecycle mangement
We are now moving towards Packer, Terraform and Pobbily Vault from Hashicorp.
Packer allows us to create and custom os images pre-built and loaded with all the apps
that we need. At the same time the customization capabilites support creating desired 
firewall rules.

Terraform: For standing up the infra, incremental changes to infra and then teardown when done

Vault: For future use, if we have some complex organization evolving later.

./terraform <apply/destroy> --var-file ./<file>.tfvar
  
