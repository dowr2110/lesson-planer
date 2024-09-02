import { createConsumer } from "@rails/actioncable";

document.addEventListener('DOMContentLoaded', () => {
    const chatId = document.querySelector('form').dataset.chatId;

    // Connect to ActionCable
    const consumer = createConsumer();

    const chatChannel = consumer.subscriptions.create(
        { channel: "ChatChannel", chat_id: chatId },
        {
            connected() {
                console.log("Connected to the chat channel with chat_id:", chatId);
            },
            disconnected() {
                console.log("Disconnected from the chat channel");
            },
            received(data) {
                const messagesContainer = document.getElementById('messages');
                messagesContainer.innerHTML += data.message;
            }
        }
    );

    // Обработка отправки сообщения
    const form = document.querySelector('form');
    form.addEventListener('submit', (event) => {
        event.preventDefault();

        const formData = new FormData(form);

        fetch(form.action, {
            method: "POST",
            body: formData,
            headers: {
                "X-Requested-With": "XMLHttpRequest",
                "Accept": "text/javascript"
            }
        })
            .then(response => response.text())
            .then(() => {
                document.getElementById('message_input').value = '';
            })
            .catch(error => console.error('Ошибка:', error));
    });
});

