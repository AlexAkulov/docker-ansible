# Docker Ansible

Docker Image for deploy via Ansible

## Usage examples

# GitLab-CI

```
image: alexakulov/ansible

stages:
  - test
  - deploy

before_script:
  - eval $(ssh-agent -s)
  - ssh-add <(echo "$SSH_PRIVATE_KEY")

test_job:
  stage: test
  script:
    - ansible-galaxy install -r requirements.yml -p ./galaxy_roles
    - ansible-playbook --syntax-check site.yml -i staging
  tags:
    - docker

deploy:
  stage: deploy
  script:
    - ansible-galaxy install -r requirements.yml -p ./galaxy_roles
    - ansible-playbook -i staging site.yml -D -u $USERNAME
  only:
    - master
  tags:
    - docker
```

# Circle CI

```
version: 2
jobs:
  test:
    docker:
      - image: alexakulov/ansible
    steps:
      - checkout
      - run: ansible-playbook --syntax-check site.yml -i staging
  deploy:
    docker:
      - image: alexakulov/ansible
    steps:
      - checkout
      - run: ansible-playbook -i staging chat.yml -u circleci --diff

workflows:
  version: 2
  test-and-deploy:
    jobs:
      - test:
          filters:
            branches:
              only: master
      - deploy:
          requires:
            - test
          filters:
            branches:
              only: master
```

# Travis

```

```
