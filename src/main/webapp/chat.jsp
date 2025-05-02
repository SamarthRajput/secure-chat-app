
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
  HttpSession session = request.getSession(false);
  if (session == null || session.getAttribute("username") == null) {
      response.sendRedirect("login.jsp");
      return;
  }
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
<h2>Welcome <%= session.getAttribute("username") %></h2>
<div id="chatBox"></div>
<input type="text" id="msg" placeholder="Type a message..." />
<input type="button" value="Send" onclick="sendMessage()" />

<script>
let ws = new WebSocket("ws://" + window.location.host + "/SecureChatApp/chatSocket");
ws.onmessage = (evt) => {
  let chat = document.getElementById("chatBox");
  chat.innerHTML += evt.data + "<br/>";
  chat.scrollTop = chat.scrollHeight;
};
function sendMessage() {
  let msgBox = document.getElementById("msg");
  if (msgBox.value.trim()) {
    ws.send("<b><%= session.getAttribute("username") %></b>: " + msgBox.value);
    msgBox.value = "";
  }
}
window.onblur = () => alert('Screenshot attempt detected: Chat tab lost focus');
</script>
</body>
</html>
