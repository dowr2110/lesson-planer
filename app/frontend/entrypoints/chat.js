import { createConsumer } from "@rails/actioncable";

document.addEventListener('DOMContentLoaded', () => {
    const chatId = document.querySelector('#chat-container').getAttribute('data-chat-id');
    const userId = document.querySelector('#chat-container').getAttribute('data-user-id');

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

    function sendMessage(message) {
        return new Promise((resolve, reject) => {
            chatChannel.perform('send_message', { message: message, user_id: userId });
            resolve();
        });
    }

    document.getElementById('send_message_button').addEventListener('click', function() {
        const messageInput = document.getElementById('message_input');
        const message = messageInput.value;

        if (message.trim() !== '') {
            sendMessage(message).then(() => {
                messageInput.value = '';
            }).catch((error) => {
                console.error('Failed to send message:', error);
            });
        }
    });
});

