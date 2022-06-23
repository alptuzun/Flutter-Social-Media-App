class Chat {
  String message;
  String type;

  Chat({required this.message, required this.type});
}

List<Chat> messageList = [
  Chat(
    message: "Alright you win.",
    type: "receiver",
  ),
  Chat(
    message: "The most expensive !!!",
    type: "sender",
  ),
  Chat(
    message: "Which ones ?",
    type: "receiver",
  ),
  Chat(
    message: "See you there then young blood",
    type: "sender",
  ),
  Chat(
    message: "BTW You owe me 10 cigars, don't you forget it",
    type: "sender",
  ),
  Chat(
    message: "YEAH, I would love to.",
    type: "receiver",
  ),
  Chat(
    message: "Staples Center, next week.",
    type: "sender",
  ),
  Chat(
    message: "Where, when?",
    type: "receiver",
  ),
  Chat(
    message: "Interested?",
    type: "sender",
  ),
  Chat(
    message: "I got court-side seats reserved for you.",
    type: "sender",
  ),
  Chat(
    message: "I'm fine, hey you coming to the game.",
    type: "sender",
  ),
  Chat(
    message: "Not much MJ, how are you?",
    type: "receiver",
  ),
  Chat(
    message: "Hello kid how are you?",
    type: "sender",
  ),
];
