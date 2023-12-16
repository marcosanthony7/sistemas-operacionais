#!/bin/bash

# Função para realizar um saque (mantida igual)
realizar_saque() {
    valor=$(dialog --inputbox "Digite o valor do saque:" 8 40 --stdout)
    if [ $? -eq 0 ]; then # Verifica se o usuário pressionou OK
        if [[ $valor =~ ^[0-9]+$ ]]; then
            dialog --msgbox "Simulando operação de saque de R\$$valor." 8 40

            notas=(200 100 50 20 10 5 2 1) # Array com os valores das notas
            notas_quantidade=() # Array para armazenar a quantidade de cada nota

            # Calcula a quantidade de cada nota
            for nota in "${notas[@]}"; do
                qtd=$((valor / nota)) # Calcula a quantidade de notas necessárias
                valor=$((valor % nota)) # Calcula o valor restante para as próximas notas

                notas_quantidade+=("$qtd")
            done

            # Exibe a quantidade de cada nota
            dialog --msgbox "Notas:\n\nR\$200: ${notas_quantidade[0]}x\nR\$100: ${notas_quantidade[1]}x\nR\$50: ${notas_quantidade[2]}x\nR\$20: ${notas_quantidade[3]}x\nR\$10: ${notas_quantidade[4]}x\nR\$5: ${notas_quantidade[5]}x\nR\$2: ${notas_quantidade[6]}x\nR\$1: ${notas_quantidade[7]}x" 15 60
        else
            dialog --msgbox "Valor inválido. Digite um valor numérico." 8 40
        fi
    else
        echo "Operação de saque cancelada."
    fi
}

# Função para realizar um depósito (mantida igual)
realizar_deposito() {
    valor=$(dialog --inputbox "Digite o valor do depósito:" 8 40 --stdout)
    if [ $? -eq 0 ]; then # Verifica se o usuário pressionou OK
        if [[ $valor =~ ^[0-9]+$ ]]; then
            dialog --msgbox "Simulando operação de depósito de R\$$valor." 8 40
            # Adicionar código para operação de depósito
        else
            dialog --msgbox "Valor inválido. Digite um valor numérico." 8 40
        fi
    else
        echo "Operação de depósito cancelada."
    fi
}

# Função para realizar uma transferência
realizar_transferencia() {
    local valor
    valor=$(dialog --inputbox "Digite o valor da transferência:" 8 40 --stdout)
    if [ $? -eq 0 ]; then # Verifica se o usuário pressionou OK
        until [[ $valor =~ ^[0-9]+$ ]]; do
            if [[ ! $valor ]]; then
                echo "Operação de transferência cancelada."
                return
            fi
            dialog --msgbox "Valor inválido. Digite um valor numérico." 8 40
            valor=$(dialog --inputbox "Digite o valor da transferência:" 8 40 --stdout)
        done

        destino=$(dialog --inputbox "Digite a conta de destino:" 8 40 --stdout)
        if [ $? -eq 0 ]; then # Verifica se o usuário pressionou OK
            dialog --msgbox "Simulando operação de transferência de R\$$valor para a conta $destino." 8 60
            # Adicionar código para operação de transferência
        else
            echo "Operação de transferência cancelada."
        fi
    else
        echo "Operação de transferência cancelada."
    fi
}

# Loop principal usando while para manter o programa em execução
while true; do
    escolha=$(dialog --clear --backtitle "Opções da Caixa" --title "Escolha uma opção" \
        --menu "Selecione uma opção:" 15 60 9 \
        1 "Saque" \
        2 "Depósito" \
        3 "Transferência" \
        0 "Sair" \
        3>&1 1>&2 2>&3)

    case $escolha in
        1)
            realizar_saque
            ;;
        2)
            realizar_deposito
            ;;
        3)
            realizar_transferencia
            ;;
        0)
            echo "Saindo do programa."
            exit 0
            ;;
        *)
            dialog --msgbox "Opção inválida. Por favor, escolha uma opção válida." 8 40
            ;;
    esac
done
