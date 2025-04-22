### Prerequisites:

1. Validate ansible installed and you are running in the right virtual env 
2. Validate roles installed from requirements.yml
3. Set hosts for the inventory.ini

### Commands description:

```make check-ansible``` -  Run check for ansible installation as a pre-requirement

```make install-roles``` - Run check for installed roles in the ```/role``` folder 

```make compa``` - Run ansible playbook for CompA

```make compb``` - Run ansible playbook for CompB

```make all``` - Run all checks and playbook
