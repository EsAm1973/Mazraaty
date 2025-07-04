import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Features/plant_library/data/models/ai_chat_response.dart';
import 'package:timeago/timeago.dart' as timeago;

// Keep track of which messages have already been animated
final Map<String, bool> _animatedMessages = {};

class ChatMessageBubbleWrapper extends StatefulWidget {
  final AIChatResponse message;

  const ChatMessageBubbleWrapper({
    Key? key,
    required this.message,
  }) : super(key: key);

  // Static method to clear animation history
  static void clearAnimationHistory() {
    _animatedMessages.clear();
  }

  @override
  State<ChatMessageBubbleWrapper> createState() =>
      _ChatMessageBubbleWrapperState();
}

class _ChatMessageBubbleWrapperState extends State<ChatMessageBubbleWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  bool _hasAnimated = false;
  
  // For AI typing effect
  String _displayedText = '';
  bool _isTyping = false;
  int _charIndex = 0;
  
  // Generate a unique identifier for this message
  late final String _messageId;

  @override
  void initState() {
    super.initState();
    
    // Generate a unique ID for this message
    _messageId = '${widget.message.timestamp.millisecondsSinceEpoch}_${widget.message.isUser}';
    
    // Initialize timeago
    timeago.setLocaleMessages('en_short', timeago.EnShortMessages());

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(widget.message.isUser ? 1.0 : -1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutQuint,
    ));

    // Check if this message has already been animated
    final bool hasBeenAnimated = _animatedMessages[_messageId] ?? false;

    // Only animate new messages
    if (!hasBeenAnimated) {
      // For user messages or when no need to animate
      if (widget.message.isUser) {
        _displayedText = widget.message.message;
        _animatedMessages[_messageId] = true;
      }
      
      // Slide-in animation and typing animation will be handled in post-frame callback
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && !_hasAnimated) {
          _slideController.forward();
          setState(() {
            _hasAnimated = true;
          });
          
          // Only animate typing for AI messages that haven't been animated yet
          if (!widget.message.isUser && !hasBeenAnimated) {
            _startTypingAnimation();
          } else {
            // For previously animated AI messages, just show the full text
            _displayedText = widget.message.message;
          }
        }
      });
    } else {
      // For previously animated messages, just show full content immediately
      _displayedText = widget.message.message;
      _slideController.value = 1.0; // Set to end position
      _hasAnimated = true;
    }
  }
  
  void _startTypingAnimation() {
    setState(() {
      _isTyping = true;
      _displayedText = '';
      _charIndex = 0;
    });

    _animateText();
  }

  Future<void> _animateText() async {
    if (!mounted) return;

    final text = widget.message.message;
    final textLength = text.length;

    // This loop will simulate the typing effect
    while (_charIndex < textLength && mounted && _isTyping) {
      await Future.delayed(const Duration(milliseconds: 15));
      if (!mounted) return;

      setState(() {
        _charIndex++;
        _displayedText = text.substring(0, _charIndex);
      });

      // Add variable timing for more natural typing
      int delay = 15;
      if (text.length > _charIndex) {
        final nextChar = text[_charIndex];
        if ('.!?,;:\n'.contains(nextChar)) {
          delay = 250;
        }
      }

      await Future.delayed(Duration(milliseconds: delay));
    }

    if (mounted) {
      setState(() {
        _isTyping = false;
        _displayedText = text;
        
        // Mark this message as completely animated
        _animatedMessages[_messageId] = true;
      });
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    _isTyping = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUser = widget.message.isUser;
    final textColor = isUser ? Colors.white : Colors.black87;
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Calculate a more generous width
    final messageMaxWidth = screenWidth * 0.75;
    final bubbleMaxWidth = screenWidth * 0.70;
    final contentWidth = screenWidth * 0.65;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0), // More vertical spacing between messages
      child: SlideTransition(
        position: _slideAnimation,
        child: Align(
          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: messageMaxWidth,
            ),
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isUser) _buildAvatar(),
                  if (!isUser) const SizedBox(width: 8),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: isUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            minWidth: bubbleMaxWidth * 0.5, // Minimum width for the bubble
                            maxWidth: bubbleMaxWidth,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 14.0, // More vertical padding
                          ),
                          decoration: BoxDecoration(
                            color: isUser ? Colors.green.shade600 : Colors.grey.shade200, // Lighter background for AI messages
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(isUser ? 20.0 : 4.0),
                              topRight: Radius.circular(isUser ? 4.0 : 20.0),
                              bottomLeft: const Radius.circular(20.0),
                              bottomRight: const Radius.circular(20.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(isUser ? 0.05 : 0.03), // Lighter shadow for AI messages
                                blurRadius: isUser ? 5 : 3, // Reduced blur for AI messages
                                offset: isUser ? const Offset(0, 2) : const Offset(0, 1), // Smaller offset for AI messages
                              ),
                            ],
                            gradient: isUser
                                ? LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Colors.green.shade500,
                                      Colors.green.shade600,
                                      Colors.green.shade700,
                                    ],
                                  )
                                : null,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Message content
                              if (isUser)
                                Text(
                                  widget.message.message,
                                  style: GoogleFonts.questrial(
                                    color: textColor,
                                    fontSize: 15.0,
                                    height: 1.5, // Line height for user messages
                                  ),
                                )
                              else
                                Container(
                                  constraints: BoxConstraints(
                                    minHeight: 40, // Reduce minimum height to prevent initial oversizing
                                    minWidth: contentWidth * 0.5, // Reduced minimum width
                                  ),
                                  margin: const EdgeInsets.only(bottom: 4), // Reduced margin
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6,
                                    horizontal: 4,
                                  ), // Reduced padding
                                  child: DefaultTextStyle(
                                    style: GoogleFonts.questrial(
                                      color: textColor,
                                      fontSize: 15.0,
                                      height: 1.5, // Reduced line height
                                    ),
                                    child: MarkdownBody(
                                      data: _displayedText,
                                      shrinkWrap: true,
                                      selectable: false,
                                      softLineBreak: true,
                                      onTapLink: (_, __, ___) {},
                                      fitContent: true,
                                      styleSheet: MarkdownStyleSheet(
                                        p: GoogleFonts.questrial(
                                          color: textColor,
                                          fontSize: 15.0,
                                          height: 1.5, // Reduced line height
                                          shadows: const [], // Explicitly empty shadows
                                        ),
                                        h1: GoogleFonts.playfairDisplay(
                                          color: textColor,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          shadows: const [], // Explicitly empty shadows
                                        ),
                                        h2: GoogleFonts.playfairDisplay(
                                          color: textColor,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          shadows: const [], // Explicitly empty shadows
                                        ),
                                        h3: GoogleFonts.playfairDisplay(
                                          color: textColor,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          shadows: const [], // Explicitly empty shadows
                                        ),
                                        listBullet: GoogleFonts.questrial(
                                          color: textColor,
                                          fontSize: 15.0,
                                          shadows: const [], // Explicitly empty shadows
                                        ),
                                        strong: GoogleFonts.questrial(
                                          color: textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                          shadows: const [], // Explicitly empty shadows
                                        ),
                                        em: GoogleFonts.questrial(
                                          color: textColor,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 15.0,
                                          shadows: const [], // Explicitly empty shadows
                                        ),
                                        code: GoogleFonts.firaCode(
                                          color: isUser ? Colors.white70 : Colors.green.shade700,
                                          backgroundColor: isUser
                                              ? Colors.green.shade700
                                              : Colors.grey.shade100,
                                          fontSize: 14.0,
                                          shadows: const [], // Explicitly empty shadows
                                        ),
                                        codeblockDecoration: BoxDecoration(
                                          color: isUser
                                              ? Colors.green.shade700
                                              : Colors.grey.shade100,
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                              // Show cursor for typing animation
                              if (!isUser && _isTyping)
                                Container(
                                  height: 15,
                                  width: 2,
                                  margin: const EdgeInsets.only(top: 5),
                                  color: Colors.green.shade400,
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 4, left: 4, right: 4),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (!isUser &&
                                  widget.message.message.length > 100 &&
                                  !_isTyping)
                                GestureDetector(
                                  onTap: () {
                                    // Copy message to clipboard
                                    Clipboard.setData(ClipboardData(
                                        text: widget.message.message));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Message copied to clipboard!',
                                          style:
                                              GoogleFonts.poppins(fontSize: 12),
                                        ),
                                        backgroundColor: Colors.green.shade600,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade50,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.copy_rounded,
                                          size: 12,
                                          color: Colors.green.shade700,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Copy',
                                          style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            color: Colors.green.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              if (!isUser &&
                                  widget.message.message.length > 100 &&
                                  !_isTyping)
                                const SizedBox(width: 8),
                              Text(
                                _formatTimestamp(widget.message.timestamp),
                                style: GoogleFonts.poppins(
                                  color: isUser
                                      ? Colors.grey.shade600
                                      : Colors.grey.shade500,
                                  fontSize: 10.0,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                isUser
                                    ? Icons.check_circle
                                    : Icons.auto_awesome,
                                size: 12,
                                color: isUser
                                    ? Colors.green.shade500
                                    : Colors.green.shade300,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isUser) const SizedBox(width: 8),
                  if (isUser) _buildAvatar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    try {
      return timeago.format(timestamp, locale: 'en_short');
    } catch (e) {
      // Fallback if timeago fails
      final now = DateTime.now();
      final difference = now.difference(timestamp);

      if (difference.inMinutes < 1) {
        return 'now';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes}m';
      } else if (difference.inHours < 24) {
        return '${difference.inHours}h';
      } else {
        return '${difference.inDays}d';
      }
    }
  }

  Widget _buildAvatar() {
    if (widget.message.isUser) {
      return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.green.shade400,
              Colors.green.shade600,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.green.shade200.withOpacity(0.5),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: const Icon(
          Icons.person,
          size: 16,
          color: Colors.white,
        ),
      );
    } else {
      return Container(
        width: 32,
        height: 32,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Colors.green.shade300,
              Colors.green.shade500,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.green.shade200.withOpacity(0.5),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 14,
          child: Image.asset(
            'assets/images/plant-02.png',
            width: 18,
            height: 18,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.local_florist,
              size: 16,
              color: Colors.green.shade700,
            ),
          ),
        ),
      );
    }
  }
}
