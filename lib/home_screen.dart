import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool lastInMiddle = true;
  bool isNoteOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: isNoteOpen
                      ? null
                      : () {
                          setState(() {
                            isNoteOpen = true;
                          });
                        },
                  child: const Text('Tap me to open notes'),
                ),
              ),
            ],
          ),
          NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              if (notification.extent == 0.5) {
                if (lastInMiddle) {
                  // setState(() {
                  //   isNoteOpen = false;
                  // });
                } else {
                  lastInMiddle = true;
                }
              } else {
                lastInMiddle = false;
              }

              return true;
            },
            child: Notes(
              isNoteOpen: isNoteOpen,
            ),
          )
        ],
      ),
    );
  }
}

class Notes extends StatelessWidget {
  final bool isNoteOpen;
  const Notes({super.key, required this.isNoteOpen});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.5,
      maxChildSize: 1.0,
      snap: true,
      expand: false,
      snapSizes: const [0.5, 1.0],
      builder: (context, scrollController) {
        if (!isNoteOpen) {
          return const SizedBox.shrink();
        }

        return BottomSheet(
          enableDrag: false,
          backgroundColor: Colors.teal,
          onClosing: () {},
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          builder: (context) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: 20,
                controller: scrollController,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Note $index'),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
