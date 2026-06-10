import 'package:chat_app/core/routes/app_routes.dart';
import 'package:chat_app/data/models/chat_model.dart';
import 'package:chat_app/presentation/bloc/chat/chat_event.dart';
import 'package:chat_app/presentation/bloc/chat/chat_state.dart';
import 'package:chat_app/presentation/bloc/chat/chat_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();

    context.read<ChatBloc>().add(LoadChatHistory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue.shade700,
        title: const Text(
          "Chat History",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state.messages.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history_rounded,
                    size: 90,
                    color: Colors.blue.shade200,
                  ),

                  const SizedBox(height: 20),

                  Text(
                    "No Chat History",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Your previous conversations\nwill appear here",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                  ),
                ],
              ),
            );
          }

          final Map<String, ChatMessageModel> conversations = {};

          for (final msg in state.messages) {
            if (msg.sender == "user") {
              conversations.putIfAbsent(msg.conversationId, () => msg);
            }
          }

          final historyList = conversations.values.toList()
            ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

          return Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade600, Colors.blue.shade400],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.chat, color: Colors.blue),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Your Conversations",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            "${historyList.length} Chats Saved",
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: historyList.length,

                  itemBuilder: (context, index) {
                    final chat = historyList[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),

                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        elevation: 2,

                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),

                          onTap: () {
                            context.read<ChatBloc>().add(
                              OpenConversation(chat.conversationId),
                            );

                            context.go(AppRoutes.chat);
                          },

                          child: Padding(
                            padding: const EdgeInsets.all(16),

                            child: Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,

                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(16),
                                  ),

                                  child: Icon(
                                    Icons.chat_bubble,
                                    color: Colors.blue.shade700,
                                    size: 28,
                                  ),
                                ),

                                const SizedBox(width: 14),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        chat.message,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,

                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),

                                      const SizedBox(height: 8),

                                      Row(
                                        children: [
                                          Icon(
                                            Icons.schedule_rounded,
                                            size: 14,
                                            color: Colors.grey.shade500,
                                          ),

                                          const SizedBox(width: 4),

                                          Text(
                                            DateFormat(
                                              'dd MMM yyyy • hh:mm a',
                                            ).format(chat.timestamp),

                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.08),
                                    shape: BoxShape.circle,
                                  ),

                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                    color: Colors.blue.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
