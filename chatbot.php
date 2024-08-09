<?php
include 'components/connect.php';

if (isset($_COOKIE['user_id'])) {
    $user_id = $_COOKIE['user_id'];
} else {
    $user_id = '';
}

// Fetch the namespaces and titles if the user is logged in
$validNamespaces = [];
if ($user_id) {
    $select_courses = $conn->prepare("
        SELECT playlist.namespace, playlist.title 
        FROM playlist
        JOIN registrations ON playlist.id = registrations.playlist_id 
        WHERE registrations.user_id = ? 
        AND playlist.status = 'active'
    ");
    $select_courses->execute([$user_id]);

    while ($fetch_course = $select_courses->fetch(PDO::FETCH_ASSOC)) {
        $validNamespaces[$fetch_course['namespace']] = $fetch_course['title'];
    }
}

$validNamespacesJson = json_encode($validNamespaces);

// Handle AJAX request to insert feedback
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Read JSON input
    $data = json_decode(file_get_contents('php://input'), true);

    if (isset($data['satisfaction'])) {
        $satisfaction = htmlspecialchars($data['satisfaction']);
        $question = htmlspecialchars($data['question']);
        $response = htmlspecialchars(urldecode($data['response'])); // Decode and escape special characters
        $time_response = htmlspecialchars($data['time_response']) . 'ms';

        // Validate the input to prevent SQL injection
        if ($satisfaction === 'satisfied') {
            $insert_query = $conn->prepare("
                INSERT INTO satisfied_response (question, response, time_response) 
                VALUES (?, ?, ?)
            ");
            $insert_query->execute([$question, $response, $time_response]);
            echo json_encode(['message' => 'Feedback recorded as satisfied']);
        } else if ($satisfaction === 'unsatisfied') {
            $insert_query = $conn->prepare("
                INSERT INTO unsatisfied_response (question, response, time_response) 
                VALUES (?, ?, ?)
            ");
            $insert_query->execute([$question, $response, $time_response]);
            echo json_encode(['message' => 'Feedback recorded as unsatisfied']);
        } else {
            echo json_encode(['message' => 'Invalid feedback type']);
        }
    } else {
        echo json_encode(['message' => 'Invalid input data']);
    }
    exit;
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- custom css file link  -->
    <link rel="stylesheet" href="css/style.css?v=2.0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css" />
    <title>Chatbot</title>
    <style>
        .thinking-dots {
            display: flex;
            align-items: center;
        }

        .thinking-dots p {
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            font-size: 16px;
        }

        .thinking-dots p::after {
            content: '...';
            display: inline-block;
            animation: ellipsis 1.5s infinite;
        }

        @keyframes ellipsis {
            0% {
                content: '.';
            }
            33% {
                content: '..';
            }
            66% {
                content: '...';
            }
        }
    </style>
</head>
<body>

<?php include 'components/user_header.php'; ?>

<div class="select-action-container">
    <select id="action" class="select-action">
        <option value="search">Tìm kiếm nội dung bài giảng hoặc tóm tắt</option>
        <option value="answer">Trả lời câu hỏi trong bài giảng</option>
    </select>
</div>

<div class="chat-container">
    <div class="chat-box" id="chat-box"></div>
    <div class="input-container">
        <input type="text" id="user_message" name="user_message" class="user-input" placeholder="Nhập nội dung...">
        <button id="send-button" onclick="sendMessage()">Send</button>
    </div>
</div>

<script>
let validNamespaces = <?php echo $validNamespacesJson; ?>;
console.log("Valid Namespaces:", validNamespaces); // Debugging line

function sendMessage() {
    var userMessage = document.getElementById("user_message").value;
    var action = document.getElementById("action").value;

    if (userMessage.trim() === "") return; // Prevent sending empty messages

    var chatBox = document.getElementById("chat-box");
    chatBox.innerHTML += "<div class='message2 user-message'><p class='user-text'>" + userMessage + "</p></div>";
    document.getElementById("user_message").value = "";
    chatBox.scrollTop = chatBox.scrollHeight;

    // Add the thinking dots
    var thinkingDots = document.createElement("div");
    thinkingDots.classList.add("message2", "bot-message", "thinking-dots");
    thinkingDots.innerHTML = "<p class='bot-text'></p>";
    chatBox.appendChild(thinkingDots);
    chatBox.scrollTop = chatBox.scrollHeight;

    if (action === "search") {
        fetchSearch(userMessage, thinkingDots);
    } else {
        fetchAnswer(userMessage, thinkingDots);
    }
}

function splitTextIntoChunks(text, sentencesPerChunk = 3) {
    const sentences = text.split(/(?<=[.?!])\s+(?=[A-Z])/);
    const chunks = [];
    for (let i = 0; i < sentences.length; i += sentencesPerChunk) {
        chunks.push(sentences.slice(i, i + sentencesPerChunk).join(' '));
    }
    return chunks;
}

function fetchSearch(userMessage, thinkingDots) {
    var startTime = Date.now();

    fetch('http://127.0.0.1:5000/get_response', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        },
        body: JSON.stringify({ user_message: userMessage })
    })
    .then(response => response.json())
    .then(data => {
        var endTime = Date.now();
        var responseTime = endTime - startTime;

        var chatBox = document.getElementById("chat-box");
        chatBox.removeChild(thinkingDots);

        if (data.text.length > 512) {
            const chunks = splitTextIntoChunks(data.text);
            chunks.forEach((chunk, index) => {
                setTimeout(() => {
                    var responseHTML = "<div class='message2 bot-message'><p class='bot-text'><h3>Phần " + (index + 1) + ":</h3> " + chunk + "</p>";
                    if (index === chunks.length - 1) {
                        responseHTML += `
                            <div class="reaction-buttons">
                                <button class="like-button" onclick="handleLike(this, '${userMessage}', '${encodeURIComponent(data.text)}', ${responseTime})">👍 Hài lòng</button>
                                <button class="dislike-button" onclick="handleDislike(this, '${userMessage}', '${encodeURIComponent(data.text)}', ${responseTime})">👎 Không hài lòng</button>
                            </div>
                        </div>`;
                    }
                    chatBox.innerHTML += responseHTML;
                }, index * 2000);
            });
        } else {
            var responseHTML = "<div class='message2 bot-message'><p class='bot-text'>" + data.text + "</p>";
            if (data.image) {
                responseHTML += "<img src='" + data.image + "' alt='Chatbot Image' class='chatbot-image'>";
            }
            responseHTML += `
                <div class="reaction-buttons">
                    <button class="like-button" onclick="handleLike(this, '${userMessage}', '${encodeURIComponent(data.text)}', ${responseTime})">👍 Hài lòng</button>
                    <button class="dislike-button" onclick="handleDislike(this, '${userMessage}', '${encodeURIComponent(data.text)}', ${responseTime})">👎 Không hài lòng</button>
                </div>
            </div>`;
            chatBox.innerHTML += responseHTML;
        }
        chatBox.scrollTop = chatBox.scrollHeight;
    })
    .catch(error => {
        console.error('Error in fetchSearch:', error);
        var chatBox = document.getElementById("chat-box");
        chatBox.removeChild(thinkingDots);
        chatBox.innerHTML += "<div class='message2 bot-message'><p class='bot-text'>An error occurred. Please try again.</p></div>";
        chatBox.scrollTop = chatBox.scrollHeight;
    });
}

function fetchAnswer(userMessage, thinkingDots) {
    var startTime = Date.now();

    fetch('http://127.0.0.1:5000/answer', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        },
        body: JSON.stringify({ mode: 'medium', question: userMessage })
    })
    .then(response => response.json())
    .then(data => {
        var endTime = Date.now();
        var responseTime = endTime - startTime;

        console.log("Data received from fetchAnswer:", data); // Debugging line

        var responseHTML = "";
        let namespace = data.data.namespace;
        let encodedAnswer = encodeURIComponent(data.data.answer); // Encode the answer

        if (validNamespaces.hasOwnProperty(namespace)) {
            responseHTML = "<div class='message2 bot-message'><p class='bot-text'>" + data.data.answer + "</p>";
            responseHTML += `
                <div class="reaction-buttons">
                    <button class="like-button" onclick="handleLike(this, '${userMessage}', '${encodedAnswer}', ${responseTime})">👍 Hài lòng</button>
                    <button class="dislike-button" onclick="handleDislike(this, '${userMessage}', '${encodedAnswer}', ${responseTime})">👎 Không hài lòng</button>
                </div>
            </div>`;
        } else {
            responseHTML = "<div class='message2 bot-message'><p class='bot-text'>Bạn chưa đăng ký khóa học '" + namespace + "' nên không thể trả lời.</p>";
        }

        // Replace the thinking dots with the actual response
        var chatBox = document.getElementById("chat-box");
        chatBox.removeChild(thinkingDots);
        chatBox.innerHTML += responseHTML;
        chatBox.scrollTop = chatBox.scrollHeight;
    })
    .catch(error => {
        console.error('Error in fetchAnswer:', error);
        var chatBox = document.getElementById("chat-box");
        chatBox.removeChild(thinkingDots);
        chatBox.innerHTML += "<div class='message2 bot-message'><p class='bot-text'>An error occurred. Please try again.</p></div>";
        chatBox.scrollTop = chatBox.scrollHeight;
    });
}

function handleLike(button, userMessage, botResponse, responseTime) {
    var responseMessage = button.closest('.bot-message');
    if (responseMessage) {
        alert('Bạn đã hài lòng với câu trả lời này: ' + responseMessage.querySelector('.bot-text').innerText);

        sendFeedback('satisfied', userMessage, botResponse, responseTime);
    } else {
        console.error('Không thể tìm thấy phần tử .bot-message gần nhất.');
    }
}

function handleDislike(button, userMessage, botResponse, responseTime) {
    var responseMessage = button.closest('.bot-message');
    if (responseMessage) {
        alert('Bạn không hài lòng với câu trả lời này: ' + responseMessage.querySelector('.bot-text').innerText);

        sendFeedback('unsatisfied', userMessage, botResponse, responseTime);
    } else {
        console.error('Không thể tìm thấy phần tử .bot-message gần nhất.');
    }
}

function sendFeedback(satisfaction, userMessage, botResponse, responseTime) {
    fetch('chatbot.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        },
        body: JSON.stringify({
            satisfaction: satisfaction,
            question: userMessage,
            response: botResponse,
            time_response: responseTime
        })
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        console.log(data.message);
    })
    .catch(error => {
        console.error('Error in sendFeedback:', error);
    });
}

document.getElementById("user_message").addEventListener("keydown", function(event) {
    if (event.key === "Enter") {
        sendMessage();
    }
});
</script>
</body>
</html>
