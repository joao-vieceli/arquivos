#!/bin/bash

# Ler o nome do usuário a partir do input
read -p "Digite o nome do novo usuário: " USERNAME

# Criar novo usuário
sudo adduser $USERNAME

# Ler a senha do novo usuário a partir do input
read -sp "Digite a senha para o usuário $USERNAME: " PASSWORD
echo
read -sp "Confirme a senha para o usuário $USERNAME: " PASSWORD_CONFIRM
echo

# Verificar se as senhas coincidem
if [ "$PASSWORD" != "$PASSWORD_CONFIRM" ]; then
  echo "As senhas não coincidem. Tente novamente."
  exit 1
fi

# Definir a senha do novo usuário
echo "$USERNAME:$PASSWORD" | sudo chpasswd

# Adicionar o usuário ao grupo sudo
sudo usermod -aG sudo $USERNAME

# Criar diretório .ssh no home do usuário e ajustar permissões
sudo mkdir -p /home/$USERNAME/.ssh
sudo chmod 700 /home/$USERNAME/.ssh

# Copiar chave autorizada para o novo usuário (substitua '/root/.ssh/authorized_keys' pelo caminho correto se necessário)
sudo cp /root/.ssh/authorized_keys /home/$USERNAME/.ssh/
sudo chmod 600 /home/$USERNAME/.ssh/authorized_keys

# Ajustar permissões do diretório home do usuário
sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh

echo "Usuário $USERNAME criado, senha definida e adicionado ao grupo sudo com sucesso."

