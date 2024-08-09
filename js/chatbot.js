const chatbotToggler = document.querySelector(".chatbot-toggler");
const closeBtn = document.querySelector(".close-btn");
const chatbox = document.querySelector(".chatbox");
const chatInput = document.querySelector(".chat-input textarea");
const sendChatBtn = document.querySelector(".chat-input span");
const chatOptions = document.getElementById("chat-options");
let action = chatOptions.value; 
let userMessage = null; // Variable to store user's message
const inputInitHeight = chatInput.scrollHeight;

chatOptions.addEventListener("change", (event) => {
    action = event.target.value; // Cập nhật biến action khi giá trị thẻ select thay đổi
});

const createChatLi = (message, className) => {
    // Create a chat <li> element with passed message and className
    const chatLi = document.createElement("li");
    chatLi.classList.add("chat", `${className}`);
    let chatContent = className === "outgoing" ? `<p></p>` : `<span class="material-symbols-outlined"><img class="chatbot-icon" src="./images/chatbot.png" alt="chatbot"></span><p></p>`;
    chatLi.innerHTML = chatContent;
    chatLi.querySelector("p").textContent = message;
    return chatLi; // return chat <li> element
}

function splitTextIntoChunks(text, sentencesPerChunk = 3) {
    const sentences = text.split(/(?<=[.?!])\s+(?=[A-Z])/);
    const chunks = [];
    for (let i = 0; i < sentences.length; i += sentencesPerChunk) {
        chunks.push(sentences.slice(i, i + sentencesPerChunk).join(' '));
    }
    return chunks;
}
// API search and summary
const generateSearchResponse = (chatElement) => {
    console.log(playlistNamespace)
    const API_URL = "http://127.0.0.1:5000/get_response";
    const messageElement = chatElement.querySelector("p");
    // Define the properties and message for the API request
    const requestOptions = {
        method: "POST",
        headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        },
        body: JSON.stringify({
            user_message: userMessage,
            namespace: playlistNamespace
        })
    }
    // Send POST request to API, get response and set the reponse as paragraph text
    fetch(API_URL, requestOptions).then(res => res.json()).then(data => {
        if(data.text.length > 512) {
            const chunks = splitTextIntoChunks(data.text);
            //setimeout
            chunks.forEach((chunk, index) => {
                setTimeout(() => {
                    const response = "Phần " + (index + 1) + ": " + chunk;
                    if (index === 0) {
                        messageElement.textContent = response;
                    }
                    else {
                        const rs = createChatLi(response, "incoming");
                        chatbox.appendChild(rs);
                    }        
                    if(index === chunks.length - 1) {
                        chatbox.scrollTo(0, chatbox.scrollHeight);
                    }
                }, index * 2000);
            });            
        }
        else{
            messageElement.textContent = data.text.trim();
        }
    }).catch(() => {
        messageElement.classList.add("error");
        messageElement.textContent = "Xin lỗi! Có trục trặc. Vui lòng thử lại.";
    }).finally(() => chatbox.scrollTo(0, chatbox.scrollHeight));
}
// API answer question
const generateAnswer = (chatElement) => {
    const API_URL = "http://127.0.0.1:5000/answer";
    const messageElement = chatElement.querySelector("p");
    // Define the properties and message for the API request
    const requestOptions = {
        method: "POST",
        headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        },
        body: JSON.stringify({ mode: 'medium', question: userMessage, namespace: playlistNamespace })
    }
    // Send POST request to API, get response and set the reponse as paragraph text
    fetch(API_URL, requestOptions).then(res => res.json()).then(data => {        
        messageElement.textContent = data.data.answer.trim();      
    }).catch(() => {
        messageElement.classList.add("error");
        messageElement.textContent = "Xin lỗi! Có trục trặc. Vui lòng thử lại.";
    }).finally(() => chatbox.scrollTo(0, chatbox.scrollHeight));
}
const handleChat = () => {
    userMessage = chatInput.value.trim(); // Get user entered message and remove extra whitespace
    if(!userMessage) return;
    // Clear the input textarea and set its height to default
    chatInput.value = "";
    chatInput.style.height = `${inputInitHeight}px`;
    // Append the user's message to the chatbox
    chatbox.appendChild(createChatLi(userMessage, "outgoing"));
    chatbox.scrollTo(0, chatbox.scrollHeight);
    
    setTimeout(() => {
        // Display "Thinking..." message while waiting for the response
        const incomingChatLi = createChatLi("...", "incoming");
        chatbox.appendChild(incomingChatLi);
        chatbox.scrollTo(0, chatbox.scrollHeight);
        if(action === "summarize-search") {
            console.log(action)
            generateSearchResponse(incomingChatLi)
        }
        else {
            console.log(action)
            generateAnswer(incomingChatLi);
        }
    }, 1000);
}



chatInput.addEventListener("input", () => {
    // Adjust the height of the input textarea based on its content
    chatInput.style.height = `${inputInitHeight}px`;
    chatInput.style.height = `${chatInput.scrollHeight}px`;
});
chatInput.addEventListener("keydown", (e) => {
    // If Enter key is pressed without Shift key and the window 
    // width is greater than 800px, handle the chat
    if(e.key === "Enter" && !e.shiftKey && window.innerWidth > 800) {
        e.preventDefault();
        handleChat();
    }
});
sendChatBtn.addEventListener("click", handleChat);
closeBtn.addEventListener("click", () => document.body.classList.remove("show-chatbot"));
chatbotToggler.addEventListener("click", () => document.body.classList.toggle("show-chatbot"));

