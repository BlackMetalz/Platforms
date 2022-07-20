# Sample for save
# Ref: https://medium.com/@ManHay_Hong/how-to-create-a-telegram-bot-and-send-messages-with-python-4cf314d9fa3e
import requests


_text = "Insert text here"

def telegram_bot_sendtext(bot_message):
    bot_token = 'Your Token'
    bot_chatID = 'Your chat ID'
    send_text = 'https://api.telegram.org/bot' + bot_token + '/sendMessage?chat_id=' + bot_chatID + '&parse_mode=Markdown&text=' + bot_message

    response = requests.get(send_text)

    return response.json()


test = telegram_bot_sendtext(_text)
print(test)
