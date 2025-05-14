<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = (String) session.getAttribute("username");

    // Escape quotes and backslashes for safe JavaScript insertion
    String safeUsername = username.replace("\\", "\\\\").replace("\"", "\\\"");
%>
<html>
<head>
  <style>
    body { font-family: Arial; margin: 10px; }
    #chatBox { width: 100%; height: 300px; border: 1px solid gray; overflow-y: scroll; margin-bottom: 10px; padding: 5px; }
    input[type=text] { width: 80%; padding: 8px; }
    input[type=button] { padding: 8px 12px; }
    @media (max-width: 600px) {
      input[type=text], input[type=button] { width: 100%; display: block; margin-top: 5px; }
    }
  </style>
</head>
<body>
<h2>Welcome <%= username %></h2>

<!-- Safely inject username -->
<script>
  const username = "<%= safeUsername %>";
</script>

<div id="chatBox"></div>
<input type="text" id="msg" placeholder="Type a message..." />
<input type="button" value="Send" onclick="sendMessage()" />

<script>
let ws = new WebSocket("ws://" + window.location.host + "/SecureChatApp/chatSocket");
let isInteracting = false; // Flag to track user interaction
let isTabActive = true; // Track if the tab is active

// Handle incoming WebSocket messages
ws.onmessage = (evt) => {
  let chat = document.getElementById("chatBox");
  chat.innerHTML += evt.data + "<br/>";
  chat.scrollTop = chat.scrollHeight;
};

// Send a message
function sendMessage() {
  let msgBox = document.getElementById("msg");
  if (msgBox.value.trim()) {
    isInteracting = true; // User is interacting
    ws.send("<b>" + username + "</b>: " + msgBox.value);
    msgBox.value = "";
    setTimeout(() => (isInteracting = false), 500); // Reset interaction flag after 500ms
  }
}

// Detect when the tab becomes inactive
window.onblur = () => {
  isTabActive = false;
};

// Detect when the tab becomes active again
window.onfocus = () => {
  isTabActive = true;
};

// Periodically check for tab inactivity
setInterval(() => {
  if (!isTabActive && !isInteracting) {
    alert('Screenshot attempt detected: Chat tab lost focus');
  }
}, 1000); // Check every second
</script>
</body>
</html>
