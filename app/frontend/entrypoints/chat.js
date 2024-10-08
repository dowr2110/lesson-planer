import { createConsumer } from "@rails/actioncable";

document.addEventListener('DOMContentLoaded', () => {
    const chatId = document.querySelector('#chat-container').getAttribute('data-chat-id');
    const userId = document.querySelector('#chat-container').getAttribute('data-user-id');

    function scrollToBottom() {
        let chatWindow = document.querySelector('.chat-window');
        chatWindow.scrollTop = chatWindow.scrollHeight;
    }

    function showMessages() {
        document.getElementById('messages').style.display = 'block'
        document.getElementById('search-messages').style.display = 'none'
    }

    // Connect to ActionCable
    const consumer = createConsumer();

    const chatChannel = consumer.subscriptions.create(
        { channel: "ChatChannel", chat_id: chatId },
        {
            connected() {
                scrollToBottom();
                console.log("Connected to the chat channel with chat_id:", chatId);
            },
            disconnected() {
                console.log("Disconnected from the chat channel");
            },
            received(data) {
                const messagesContainer = document.getElementById('messages');
                messagesContainer.innerHTML += data.message;
                scrollToBottom();
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

        showMessages();

        if (message.trim() !== '') {
            sendMessage(message).then(() => {
                messageInput.value = '';
            }).catch((error) => {
                console.error('Failed to send message:', error);
            });
        }
    });
});

document.addEventListener('DOMContentLoaded', () => {
    const searchForm = document.getElementById('search-form');

    searchForm.addEventListener('ajax:error', function(event) {
        console.error('Search failed:', event.detail[2].statusText);
    });

    document.getElementById('search_button').addEventListener('click', function() {
        document.getElementById('messages').style.display = 'none'
        document.getElementById('search-messages').style.display = 'block'
    });

    document.getElementById('clear_button').addEventListener('click', function() {
        document.getElementById('messages').style.display = 'block'
        document.getElementById('search-messages').style.display = 'none'
    });

    const messagesContainer = document.getElementById('search-messages');
    messagesContainer.addEventListener('click', function(event) {
        if (event.target.id) {
            document.getElementById('messages').style.display = 'block'
            document.getElementById('search-messages').style.display = 'none'
            document.getElementById(event.target.id).scrollIntoView({ behavior: 'smooth', block: 'start' });
        }
    });
});