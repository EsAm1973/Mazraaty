import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mazraaty/Features/plant_library/data/repos/AI%20Chat%20Repo/ai_chat_repo_impl.dart';
import 'package:mazraaty/Features/plant_library/data/services/ai_chat_service.dart';
import 'package:mazraaty/Features/plant_library/presentation/manager/AI%20Chat%20Cubit/cubit/ai_chat_cubit.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/chat_message_wrapper.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/typing_indecator.dart';

class AiChatViewBody extends StatefulWidget {
  const AiChatViewBody({super.key, required this.plantName});
  final String plantName;
  static const String deepSeekApiKey =
      "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";
  @override
  State<AiChatViewBody> createState() => _AiChatViewBodyState();
}

class _AiChatViewBodyState extends State<AiChatViewBody>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late ScrollController _scrollController;
  late AIChatCubit _aiChatCubit;
  late TextEditingController _textController;
  late AnimationController _typingAnimationController;
  late AnimationController _backgroundAnimationController;
  // Animation controllers for Lottie animations
  late AnimationController _loadingAnimationController;
  late AnimationController _welcomeAnimationController;
  late AnimationController _errorAnimationController;
  bool _showScrollButton = false; // Initialize with default value
  bool _hasPlayedWelcomeAnimation =
      false; // Track if welcome animation has played

  // Add a flag to track whether we've entered the chat view
  bool _hasEnteredChatView = false;

  @override
  void initState() {
    super.initState();

    // Debug print to verify animation assets
    debugPrint('Checking animation assets: ${[
      'assets/animations/plant_loading.json',
      'assets/animations/plant_growing.json',
      'assets/animations/error.json'
    ]}');

    // Setup animations
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _typingAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _backgroundAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();

    // Initialize Lottie animation controllers
    _loadingAnimationController = AnimationController(
      vsync: this,
      duration:
          const Duration(seconds: 5), // Longer duration for thinking steps
    );

    _welcomeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Remove automatic transition after animation completes
    // Instead, we'll only transition when the user clicks the start button
    _welcomeAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        setState(() {
          // Just indicate the animation has played, but don't transition
          _hasPlayedWelcomeAnimation = true;
        });
      }
    });

    _errorAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Setup scroll controller
    _scrollController = ScrollController();

    // Listen to scroll to show/hide scroll to bottom button
    _scrollController.addListener(_scrollListener);

    // Create dependencies directly without DI
    final apiService = AIChatService(apiKey: AiChatViewBody.deepSeekApiKey);
    final aiChatRepo = AIChatRepoImpl(apiService);
    _aiChatCubit = AIChatCubit(aiChatRepo);

    // Initialize text controller
    _textController = TextEditingController();

    // Start the welcome animation but don't auto-transition
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _welcomeAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    _textController.dispose();
    _typingAnimationController.dispose();
    _backgroundAnimationController.dispose();
    // Dispose Lottie animation controllers
    _loadingAnimationController.dispose();
    _welcomeAnimationController.dispose();
    _errorAnimationController.dispose();

    // Clear animation history when disposing the widget
    ChatMessageBubbleWrapper.clearAnimationHistory();

    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      setState(() {
        _showScrollButton = currentScroll < maxScroll - 200;
      });
    }
  }

  Widget _buildChatMessages() {
    // If user hasn't entered chat view yet, show welcome screen
    if (!_hasEnteredChatView) {
      return _buildWelcomeScreen();
    }

    return BlocConsumer<AIChatCubit, AIChatState>(
      listenWhen: (previous, current) {
        // Only trigger listener when transitioning from Loading to Success state
        // This prevents unnecessary scrolling and UI updates
        return previous is AIChatLoading && current is AIChatSuccess;
      },
      listener: (context, state) {
        if (state is AIChatSuccess && mounted) {
          // Only scroll to the bottom when we get a new AI message (not a user message)
          // This prevents scrolling back to top
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted &&
                state.messages.isNotEmpty &&
                !state.messages.last.isUser) {
              _scrollToBottom();
            }
          });
        }
      },
      buildWhen: (previous, current) {
        // Only rebuild in these specific state changes to minimize UI updates
        if (previous is AIChatSuccess && current is AIChatSuccess) {
          // Check if the message counts are different to avoid rebuilding for the same data
          return previous.messages.length != current.messages.length;
        }

        // Special case: avoid rebuilding when just adding a user message
        if (previous is AIChatSuccess && current is AIChatLoading) {
          return false; // Don't rebuild just for loading state
        }

        return true; // Always rebuild for other state transitions
      },
      builder: (context, state) {
        if (state is AIChatInitial) {
          // If we've already entered chat view, show loading screen
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Lottie.asset(
                    'assets/animations/plant_loading.json',
                    controller: _loadingAnimationController..forward(),
                    fit: BoxFit.contain,
                    repeat: true,
                    errorBuilder: (context, error, stackTrace) {
                      debugPrint(
                          'Lottie error: $error\nAsset path: assets/animations/plant_loading.json');
                      return CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.green.shade600),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Loading plant knowledge...',
                  style: GoogleFonts.questrial(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.psychology,
                            color: Colors.green.shade700,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'AI is thinking',
                            style: GoogleFonts.questrial(
                              fontSize: 16,
                              color: Colors.green.shade800,
                            ),
                          ),
                          AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText(
                                '...',
                                speed: const Duration(milliseconds: 300),
                              ),
                            ],
                            isRepeatingAnimation: true,
                            repeatForever: true,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildThinkingSteps(),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state is AIChatSuccess) {
          // Use the messages directly from the state instead of trying to deduplicate here
          final messages = state.messages;

          debugPrint('Building chat view with ${messages.length} messages');

          return Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ListView.builder(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                padding: const EdgeInsets.all(8.0),
                itemCount: messages.length,
                // Use a cacheExtent to improve performance
                cacheExtent: 1000,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  // Using our wrapper with a unique key
                  return ChatMessageBubbleWrapper(
                    key: ValueKey(
                        'message_${message.timestamp.millisecondsSinceEpoch}_${message.isUser}'),
                    message: message,
                  );
                },
              ),
            ),
          );
        } else if (state is AIChatError) {
          return _buildErrorWidget(state);
        } else if (state is AIChatLoading) {
          // Get messages directly from the cubit
          final previousMessages = _aiChatCubit.messages;

          if (previousMessages.isNotEmpty) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.all(8),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      padding: const EdgeInsets.only(
                          top: 8.0,
                          left: 8.0,
                          right: 8.0,
                          bottom: 80.0 // Increased padding for typing indicator
                          ),
                      itemCount: previousMessages.length +
                          1, // Add one for typing indicator
                      cacheExtent: 1000, // Improve performance
                      itemBuilder: (context, index) {
                        if (index < previousMessages.length) {
                          final message = previousMessages[index];
                          return ChatMessageBubbleWrapper(
                            key: ValueKey(
                                'message_${message.timestamp.millisecondsSinceEpoch}_${message.isUser}'),
                            message: message,
                          );
                        } else {
                          // This is the typing indicator at the end of the list
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, top: 8.0, bottom: 16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.green.shade100,
                                  child: Icon(
                                    Icons.local_florist,
                                    size: 16,
                                    color: Colors.green.shade700,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 5,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'AI is typing',
                                        style: GoogleFonts.questrial(
                                          fontSize: 16,
                                          color: Colors.green.shade800,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const TypingIndicator(
                                        bubbleColor: Colors.transparent,
                                        flashingCircleDarkColor:
                                            Color(0xFF81C784),
                                        flashingCircleBrightColor:
                                            Color(0xFF66BB6A),
                                        dotSize: 6.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          // Loading state with no previous messages
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Lottie.asset(
                    'assets/animations/plant_loading.json',
                    controller: _loadingAnimationController..forward(),
                    fit: BoxFit.contain,
                    repeat: true,
                    errorBuilder: (context, error, stackTrace) {
                      debugPrint(
                          'Lottie error: $error\nAsset path: assets/animations/plant_loading.json');
                      return CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.green.shade600),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        spreadRadius: 1,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.psychology,
                        color: Colors.green.shade700,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'AI is typing',
                        style: GoogleFonts.questrial(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.green.shade800,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const TypingIndicator(
                        bubbleColor: Colors.transparent,
                        flashingCircleDarkColor: Color(0xFF81C784),
                        flashingCircleBrightColor: Color(0xFF66BB6A),
                        dotSize: 7.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        // Fallback to welcome screen
        return _buildWelcomeScreen();
      },
    );
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      try {
        // Smoother scroll animation with easier curve
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutQuad,
        );
      } catch (e) {
        debugPrint('Error scrolling to bottom: $e');
      }
    }
  }

  Widget _buildWelcomeScreen() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animation always repeats now and is tappable to start chat
            GestureDetector(
              onTap: _startChat,
              child: SizedBox(
                width: 180,
                height: 180,
                child: Lottie.asset(
                  'assets/animations/plant_growing.json',
                  controller:
                      null, // Remove controller to allow automatic repeat
                  frameRate: FrameRate.max,
                  repeat: true, // Always repeat the animation
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    debugPrint(
                        'Lottie error: $error\nAsset path: assets/animations/plant_growing.json');
                    return Icon(
                      Icons.local_florist,
                      color: Colors.green.shade600,
                      size: 80,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Plant AI Assistant',
              style: GoogleFonts.playfairDisplay(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
            const SizedBox(height: 16),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  textAlign: TextAlign.center,
                  'Ask me anything about ${widget.plantName} or any other plants!',
                  textStyle: GoogleFonts.questrial(
                    fontSize: 16,
                    color: Colors.green.shade700,
                  ),
                  speed: const Duration(milliseconds: 50),
                ),
              ],
              totalRepeatCount: 1,
              displayFullTextOnTap: true,
            ),
            const SizedBox(height: 24),
            // Add a start chat button
            ElevatedButton(
              onPressed: _startChat,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 3,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.chat_bubble_outline),
                  const SizedBox(width: 10),
                  Text(
                    'Start chatting',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Suggestion cards - now just for display
            _buildSuggestionCards(),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionCards() {
    final suggestions = [
      {
        'title': 'Care Guide',
        'emoji': '🌱',
        'color': Colors.green,
        'query': 'How to care for ${widget.plantName}?'
      },
      {
        'title': 'Light Needs',
        'emoji': '☀️',
        'color': Colors.amber,
        'query': 'What light conditions does ${widget.plantName} need?'
      },
      {
        'title': 'Pet Safety',
        'emoji': '🐾',
        'color': Colors.blueGrey,
        'query': 'Is ${widget.plantName} poisonous to pets?'
      },
      {
        'title': 'Watering Guide',
        'emoji': '💧',
        'color': Colors.blue,
        'query': 'How often should I water ${widget.plantName}?'
      },
      {
        'title': 'Common Diseases',
        'emoji': '🦠',
        'color': Colors.redAccent,
        'query': 'Common diseases of ${widget.plantName}'
      },
      {
        'title': 'Propagation',
        'emoji': '✂️',
        'color': Colors.purple,
        'query': 'How to propagate ${widget.plantName}?'
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Text(
            'Popular Plant Questions',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.green.shade800,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            'These represent common topics users ask about',
            style: GoogleFonts.questrial(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          // Container with background color for cards
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.green.shade50.withOpacity(0.5),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.green.shade100.withOpacity(0.5),
                width: 1.5,
              ),
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1, // Slightly taller cards
                crossAxisSpacing: 16, // More space between cards
                mainAxisSpacing: 16, // More space between rows
              ),
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final suggestion = suggestions[index];
                // Use a non-clickable container instead of SuggestionCard
                return _buildNonClickableSuggestionCard(
                  title: suggestion['title'] as String,
                  emoji: suggestion['emoji'] as String,
                  color: suggestion['color'] as Color,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Improved non-clickable suggestion card with centered content
  Widget _buildNonClickableSuggestionCard({
    required String title,
    required String emoji,
    required Color color,
  }) {
    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 16, // Increased vertical padding
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // Increased border radius
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:
            MainAxisAlignment.center, // Center content vertically
        crossAxisAlignment:
            CrossAxisAlignment.center, // Center content horizontally
        children: [
          // Emoji container with improved styling
          Container(
            padding: const EdgeInsets.all(12), // Increased padding
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle, // Make it a circle
              border: Border.all(
                color: color.withOpacity(0.3),
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.1),
                  blurRadius: 4,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              emoji,
              style: const TextStyle(
                fontSize: 22, // Slightly larger emoji
              ),
            ),
          ),
          const SizedBox(height: 12), // Increased spacing
          // Title with improved styling
          Text(
            title,
            textAlign: TextAlign.center, // Center text
            style: GoogleFonts.poppins(
              // Changed to Poppins to match other UI elements
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(AIChatError state) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: Lottie.asset(
                'assets/animations/error.json',
                width: 120,
                height: 120,
                controller: _errorAnimationController..forward(),
                repeat: true,
                fit: BoxFit.contain,
                animate: true,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('Lottie error animation error: $error');
                  return Icon(
                    Icons.error_outline,
                    color: Colors.red.shade700,
                    size: 80,
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Oops! Something went wrong',
              style: GoogleFonts.playfairDisplay(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              state.failure.errorMessage,
              style: GoogleFonts.questrial(
                fontSize: 16,
                color: Colors.grey.shade800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                _aiChatCubit.getPlantDetails(widget.plantName);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 2,
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 12,
            // Fix keyboard spacing issue by using a smaller bottom padding
            // Only respect the bottom inset when the keyboard is visible
            bottom: MediaQuery.of(context).viewInsets.bottom > 0
                ? 12 // Fixed padding when keyboard is visible
                : 12 + MediaQuery.of(context).padding.bottom,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -2),
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // This fixes any potential gap between the input and keyboard
              MediaQuery.of(context).viewInsets.bottom > 0
                  ? const SizedBox.shrink()
                  : const SizedBox(height: 4),

              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: _textController.text.isNotEmpty
                              ? Colors.green.shade400
                              : Colors.grey.shade200,
                          width: 1.5,
                        ),
                        boxShadow: _textController.text.isNotEmpty
                            ? [
                                BoxShadow(
                                  color: Colors.green.shade100.withOpacity(0.5),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                ),
                              ]
                            : null,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min, // Constrain Row width
                        children: [
                          const SizedBox(width: 16),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.chat_rounded,
                              color: Colors.green.shade600,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _textController,
                              onChanged: (text) {
                                setState(() {});
                                if (text.isNotEmpty) {
                                  _typingAnimationController.forward();
                                } else {
                                  _typingAnimationController.reverse();
                                }
                              },
                              onSubmitted: (_) => _handleSubmit(),
                              decoration: InputDecoration(
                                hintText: 'Ask about ${widget.plantName}...',
                                hintStyle: GoogleFonts.poppins(
                                  color: Colors.grey.shade400,
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                isDense:
                                    true, // Make the input field more compact
                              ),
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey.shade800,
                              ),
                              cursorColor: Colors.green.shade600,
                              cursorRadius: const Radius.circular(4),
                              // Limit the number of lines to prevent excessive expansion
                              maxLines: 3,
                              minLines: 1,
                              // Keep the input field focused when keyboard appears
                              keyboardAppearance: Brightness.light,
                              textCapitalization: TextCapitalization.sentences,
                              enabled: _aiChatCubit.state is! AIChatLoading,
                            ),
                          ),
                          if (_textController.text.isNotEmpty)
                            IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Colors.grey.shade400,
                                size: 18,
                              ),
                              padding:
                                  EdgeInsets.zero, // Make button more compact
                              visualDensity: VisualDensity.compact,
                              onPressed: () {
                                _textController.clear();
                                setState(() {});
                                _typingAnimationController.reverse();
                              },
                            ),
                          IconButton(
                            icon: Icon(
                              Icons.mic_rounded,
                              color: Colors.grey.shade500,
                              size: 18, // Make icon smaller
                            ),
                            padding:
                                EdgeInsets.zero, // Make button more compact
                            visualDensity: VisualDensity.compact,
                            onPressed: () {
                              // Implement voice input feature
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Voice input coming soon!',
                                    style: GoogleFonts.poppins(),
                                  ),
                                  backgroundColor: Colors.green.shade600,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: BlocBuilder<AIChatCubit, AIChatState>(
                      builder: (context, state) {
                        final isLoading = state is AIChatLoading;
                        final canSend =
                            _textController.text.isNotEmpty && !isLoading;

                        return StatefulBuilder(builder: (context, setState) {
                          return Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: canSend
                                  ? Colors.green.shade600
                                  : Colors.grey.shade300,
                              shape: BoxShape.circle,
                              // Use fixed BoxShadow with guaranteed positive values
                              boxShadow: canSend
                                  ? [
                                      BoxShadow(
                                        color: Colors.green.withOpacity(0.3),
                                        blurRadius: 4.0, // Always positive
                                        spreadRadius: 1.0,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Material(
                              color: Colors.transparent,
                              shape: const CircleBorder(),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(24),
                                onTap: canSend ? _handleSubmit : null,
                                child: Center(
                                  child: isLoading
                                      ? SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                const AlwaysStoppedAnimation<
                                                    Color>(
                                              Colors.white,
                                            ),
                                            backgroundColor:
                                                Colors.green.shade200,
                                          ),
                                        )
                                      : AnimatedBuilder(
                                          animation: _typingAnimationController,
                                          builder: (context, child) {
                                            return Transform.rotate(
                                              angle: _typingAnimationController
                                                      .value *
                                                  3.14159 *
                                                  1.2,
                                              child: const Icon(
                                                Icons.send_rounded,
                                                color: Colors.white,
                                                size: 22,
                                              ),
                                            );
                                          },
                                        ),
                                ),
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmit() {
    final message = _textController.text.trim();
    if (message.isNotEmpty && _aiChatCubit.state is! AIChatLoading && mounted) {
      // Store the message before clearing the input
      final textToSend = message;

      // Immediately clear the text field to prevent further submissions
      _textController.clear();

      // Reset animation immediately
      _typingAnimationController.reset();

      // Add a small delay to let the UI stabilize before sending the message
      // This creates a smoother transition and helps prevent render box issues
      Future.delayed(const Duration(milliseconds: 150), () {
        if (!mounted) return;

        // Use a smoother transition for adding the user message
        setState(() {
          // Force a rebuild with the cleared text field
        });

        // Send the message after UI has updated
        Future.delayed(const Duration(milliseconds: 150), () {
          if (!mounted) return;
          _aiChatCubit.sendMessage(textToSend);
        });
      });
    }
  }

  // Method to start the chat
  void _startChat() {
    if (!_hasEnteredChatView) {
      setState(() {
        _hasEnteredChatView = true;
      });
      _aiChatCubit.getPlantDetails(widget.plantName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _aiChatCubit,
      child: Scaffold(
        // Use SafeArea to prevent layout overflow
        body: SafeArea(
          bottom: false, // Let the input handle bottom padding
          child: Stack(
            fit: StackFit.expand, // Ensure stack fills available space
            children: [
              // Enhanced animated background with pattern overlay
              Positioned.fill(
                child: Stack(
                  children: [
                    // Gradient background
                    AnimatedBuilder(
                      animation: _backgroundAnimationController,
                      builder: (context, child) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: const [
                                0.0,
                                0.3,
                                0.6,
                                1.0,
                              ],
                              colors: [
                                const Color(0xFFE8F5E9).withOpacity(0.9),
                                const Color(0xFFCBF0D9).withOpacity(0.8),
                                const Color(0xFFA8E3C3).withOpacity(0.7),
                                const Color(0xFF88D8B8).withOpacity(0.6),
                              ],
                              transform: GradientRotation(
                                  _backgroundAnimationController.value *
                                      2 *
                                      3.14159),
                            ),
                          ),
                        );
                      },
                    ),
                    // Pattern overlay
                    Opacity(
                      opacity: 0.05,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green
                              .shade50, // Fallback color if image not found
                          image: DecorationImage(
                            image: const AssetImage(
                                'assets/images/leaf_pattern.png'),
                            repeat: ImageRepeat.repeat,
                            onError: (exception, stackTrace) {
                              debugPrint(
                                  'Error loading leaf pattern: $exception');
                              return;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Main content column with flex layout
              Column(
                mainAxisSize: MainAxisSize.max, // Fill available space
                children: [
                  // Custom AppBar with glass effect - only show if in chat view or with different title
                  _hasEnteredChatView
                      ? _buildAppBar()
                      : const SizedBox(
                          height:
                              20), // Smaller space at top for welcome screen

                  // Chat messages area with enhanced scroll physics - use Expanded to constrain height
                  Expanded(
                    child: Stack(
                      children: [
                        _buildChatMessages(),

                        // Scroll to bottom button with improved design - only show in chat view
                        if (_hasEnteredChatView)
                          BlocBuilder<AIChatCubit, AIChatState>(
                              builder: (context, state) {
                            if (state is AIChatSuccess && _showScrollButton) {
                              return Positioned(
                                right: 16,
                                bottom: 20,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade600,
                                    borderRadius: BorderRadius.circular(24),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.green.withOpacity(0.4),
                                        blurRadius:
                                            4.0, // Explicit positive value
                                        spreadRadius: 0.5, // Reduced spread
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(24),
                                      onTap: _scrollToBottom,
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        child: const Icon(
                                          Icons.arrow_downward,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          }),
                      ],
                    ),
                  ),

                  // Input area with enhanced design - only show if in chat view
                  if (_hasEnteredChatView) _buildInputArea(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.only(
            top: 20, // Reduced top padding
            bottom: 8, // Reduced bottom padding
            left: 16,
            right: 8,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 2),
                blurRadius: 6, // Reduced blur
                spreadRadius: 0.5, // Added small spread radius
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center align the row
            crossAxisAlignment:
                CrossAxisAlignment.center, // Align items vertically
            children: [
              // Back button with ripple effect - made more compact
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(18),
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () => Navigator.of(context).pop(),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0), // Reduced padding
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.green.shade700,
                      size: 18, // Smaller icon
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6), // Reduced spacing
              // Improved plant avatar - made more compact
              Container(
                padding: const EdgeInsets.all(1.5), // Smaller padding
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
                      color: Colors.green.shade200.withOpacity(0.4),
                      blurRadius: 6,
                      spreadRadius: 0.5,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 16, // Smaller radius
                  child: Image.asset(
                    'assets/images/plant-02.png',
                    width: 24, // Smaller image
                    height: 24, // Smaller image
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.local_florist,
                      color: Colors.green.shade700,
                      size: 16, // Smaller icon
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12), // Reduced spacing
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Plant Assistant',
                      style: GoogleFonts.poppins(
                        fontSize: 16, // Smaller font
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 200),
                      child: BlocBuilder<AIChatCubit, AIChatState>(
                        builder: (context, state) {
                          if (state is AIChatLoading) {
                            return Row(
                              children: [
                                Text(
                                  'Thinking',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11, // Smaller font
                                    color: Colors.green.shade600,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: 20, // Smaller width
                                  child: AnimatedTextKit(
                                    animatedTexts: [
                                      TyperAnimatedText(
                                        '...',
                                        speed:
                                            const Duration(milliseconds: 300),
                                      ),
                                    ],
                                    isRepeatingAnimation: true,
                                    repeatForever: true,
                                  ),
                                ),
                              ],
                            );
                          }
                          return Text(
                            'Expert in ${widget.plantName}',
                            style: GoogleFonts.poppins(
                              fontSize: 11, // Smaller font
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Refresh button with ripple effect - made more compact
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(18),
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    // Reset animations if needed
                    _loadingAnimationController.reset();
                    _welcomeAnimationController.reset();

                    // Don't set _hasPlayedWelcomeAnimation back to false
                    // since we don't want to replay the welcome animation on refresh

                    // Clear chat and get plant details again
                    _aiChatCubit.clearChat();

                    // Clear the animation history
                    resetAnimationHistory();

                    _aiChatCubit.getPlantDetails(widget.plantName);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(6.0), // Reduced padding
                    child: Icon(
                      Icons.refresh_rounded,
                      color: Colors.green.shade700,
                      size: 20, // Smaller icon
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThinkingSteps() {
    final steps = [
      'Analyzing ${widget.plantName} characteristics',
      'Retrieving care information',
      'Checking growth conditions',
      'Generating personalized advice'
    ];

    return Column(
      children: List.generate(steps.length, (index) {
        // Create staggered animations for each step
        final isActive =
            _loadingAnimationController.value > (index / steps.length);

        return FadeTransition(
          opacity: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: _loadingAnimationController,
              curve: Interval(
                (index / steps.length),
                (index / steps.length) + 0.2,
                curve: Curves.easeOut,
              ),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color:
                        isActive ? Colors.green.shade100 : Colors.grey.shade200,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive
                          ? Colors.green.shade600
                          : Colors.grey.shade400,
                      width: 1.5,
                    ),
                  ),
                  child: isActive
                      ? Icon(
                          Icons.check,
                          size: 14,
                          color: Colors.green.shade700,
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    steps[index],
                    style: GoogleFonts.questrial(
                      fontSize: 14,
                      color: isActive ? Colors.black87 : Colors.grey.shade600,
                      fontWeight:
                          isActive ? FontWeight.w500 : FontWeight.normal,
                    ),
                  ),
                ),
                if (index == steps.length - 1 && !isActive)
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.green.shade600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void resetAnimationHistory() {
    // Use the static method to clear animation history
    ChatMessageBubbleWrapper.clearAnimationHistory();
  }
}
